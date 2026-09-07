package xberg

import (
	"bufio"
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"io"
	"iter"
	"net/http"
	"net/url"
)

// This file holds the Enterprise-only crawl-event stream. It is the one
// operation in the Enterprise spec that answers text/event-stream rather than
// JSON, which is why it does not go through the request helpers in http.go:
// those retry, and a retried subscription redelivers every event the caller
// already handled.

// crawlJobsPath is the root of the Enterprise crawl-job surface.
const crawlJobsPath = "/v1/crawl-jobs"

// eventStreamMediaType is the media type of an SSE response, sent as Accept.
const eventStreamMediaType = "text/event-stream"

// maxCrawlEventFrameBytes caps an event-stream frame. The frames this endpoint
// sends are a few hundred bytes; the cap exists so a server that never emits a
// newline cannot grow the scanner's buffer without bound.
//
// It is applied twice, because one application does not cover the other: to a
// single line, so one endless line cannot fill memory, and to the running total
// of a frame's "data:" fields, so an endless *succession* of lines just under
// the line cap — never followed by the blank line that would close the frame —
// cannot either.
const maxCrawlEventFrameBytes = 1 << 20

// CrawlEventKind is the `kind` discriminator every [CrawlEventV1] variant
// carries on the wire.
type CrawlEventKind string

// The four kinds GET /v1/crawl-jobs/{id}/events publishes.
const (
	// CrawlEventKindPage reports a page that was crawled and indexed.
	CrawlEventKindPage CrawlEventKind = "page"
	// CrawlEventKindDiscovered reports a newly discovered URL.
	CrawlEventKindDiscovered CrawlEventKind = "discovered"
	// CrawlEventKindComplete reports the crawl finished; the stream closes after it.
	CrawlEventKindComplete CrawlEventKind = "complete"
	// CrawlEventKindError reports a single URL that failed. The crawl continues.
	CrawlEventKindError CrawlEventKind = "error"
)

// valid reports whether kind is one of the four the spec declares.
func (k CrawlEventKind) valid() bool {
	switch k {
	case CrawlEventKindPage, CrawlEventKindDiscovered, CrawlEventKindComplete, CrawlEventKindError:
		return true
	default:
		return false
	}
}

// CrawlEvent is one event from [Client.StreamCrawlEvents]: the generated
// [CrawlEventV1] union together with the Kind it was tagged with.
//
// The generated union is opaque — decoding it means trying each As method
// until one fits — so Kind is lifted out of the payload and onto the struct.
// Switch on it, then call the matching accessor:
//
//	switch event.Kind {
//	case xberg.CrawlEventKindPage:
//	    page, err := event.AsPage()
//	case xberg.CrawlEventKindComplete:
//	    done, err := event.AsComplete()
//	}
type CrawlEvent struct {
	// Kind names which variant the payload carries.
	Kind CrawlEventKind
	// CrawlEventV1 is the raw union, embedded so the generated As/From
	// accessors remain reachable alongside the named ones below.
	CrawlEventV1
}

// AsPage decodes the event as a crawled page. Valid when Kind is
// [CrawlEventKindPage].
func (e CrawlEvent) AsPage() (CrawlEventV10, error) { return e.AsCrawlEventV10() }

// AsError decodes the event as a per-URL crawl failure. Valid when Kind is
// [CrawlEventKindError].
func (e CrawlEvent) AsError() (CrawlEventV11, error) { return e.AsCrawlEventV11() }

// AsDiscovered decodes the event as a newly discovered URL. Valid when Kind is
// [CrawlEventKindDiscovered].
func (e CrawlEvent) AsDiscovered() (CrawlEventV12, error) { return e.AsCrawlEventV12() }

// AsComplete decodes the event as the crawl-completed record. Valid when Kind
// is [CrawlEventKindComplete].
func (e CrawlEvent) AsComplete() (CrawlEventV13, error) { return e.AsCrawlEventV13() }

// StreamCrawlEvents subscribes to a crawl job's Server-Sent Events feed
// (GET /v1/crawl-jobs/{crawlJobID}/events) and returns an iterator over the
// events it publishes. Enterprise only.
//
// The returned error covers only what can be decided before any bytes move:
// the Enterprise tier gate. Everything after it — opening the connection,
// framing, decoding — surfaces as the iterator's second value, and the first
// non-nil error ends the sequence.
//
//	events, err := client.StreamCrawlEvents(ctx, crawlJobID)
//	if err != nil {
//	    return err
//	}
//	for event, err := range events {
//	    if err != nil {
//	        return err
//	    }
//	    if event.Kind == xberg.CrawlEventKindComplete {
//	        break
//	    }
//	}
//
// An iterator is returned rather than a channel because the package reports
// every failure as a returned error rather than a value on a side channel, and
// iter.Seq2 keeps that shape; a channel would need a second channel (or an
// error field) for the same information, and would leave the caller
// responsible for draining it to release the connection.
//
// Nothing is requested until the range loop starts, and the response body is
// closed when it stops — whether the sequence is exhausted, the caller breaks
// out, or ctx is cancelled. A caller who never ranges over the sequence opens
// nothing and leaks nothing.
//
// The stream deliberately sits outside two mechanisms every other method uses.
// The retry engine: replaying a partly consumed stream redelivers events the
// caller already handled, and no Retry-After makes that safe. And the
// *http.Client's Timeout, which bounds a whole request including the body read
// and would therefore sever a healthy subscription mid-crawl — a stream is idle
// between events by design. ctx is the only deadline; cancel it to hang up.
func (c *Client) StreamCrawlEvents(ctx context.Context, crawlJobID string) (iter.Seq2[CrawlEvent, error], error) {
	if err := c.requireTier(ctx, TargetEnterprise, "StreamCrawlEvents"); err != nil {
		return nil, err
	}
	path := crawlJobsPath + "/" + url.PathEscape(crawlJobID) + "/events"
	return func(yield func(CrawlEvent, error) bool) {
		body, err := c.openEventStream(ctx, path)
		if err != nil {
			yield(CrawlEvent{}, err)
			return
		}
		defer closeQuietly(body)
		streamCrawlEventFrames(body, yield)
	}, nil
}

// streamCrawlEventFrames reads SSE frames off body and yields one decoded
// event per frame, stopping at the first decode error or when yield says stop.
func streamCrawlEventFrames(body io.Reader, yield func(CrawlEvent, error) bool) {
	scanner := bufio.NewScanner(body)
	scanner.Buffer(nil, maxCrawlEventFrameBytes)
	scanner.Split(scanEventStreamLines)
	var frames sseDecoder
	for scanner.Scan() {
		payload, complete, err := frames.feed(scanner.Bytes())
		if err != nil {
			yield(CrawlEvent{}, err)
			return
		}
		if !complete {
			continue
		}
		event, err := parseCrawlEvent(payload)
		if err != nil {
			yield(CrawlEvent{}, err)
			return
		}
		if !yield(event, nil) {
			return
		}
	}
	if err := scanner.Err(); err != nil {
		yield(CrawlEvent{}, fmt.Errorf("xberg: reading crawl event stream: %w", err))
	}
}

// openEventStream issues the subscription request and returns its body for
// 2xx responses. The caller MUST close the returned reader.
//
// It reimplements the small part of doOnce it needs rather than calling it,
// because doOnce is wrapped by the retry loop and by the per-call timeout, and
// both are wrong for a subscription (see [Client.StreamCrawlEvents]).
func (c *Client) openEventStream(ctx context.Context, path string) (io.ReadCloser, error) {
	target := c.urlFor(path)
	req, err := http.NewRequestWithContext(ctx, methodGet, target, nil)
	if err != nil {
		return nil, fmt.Errorf("xberg: building request: %w", err)
	}
	req.Header.Set("Accept", eventStreamMediaType)
	if authErr := c.authorize(ctx, req); authErr != nil {
		return nil, authErr
	}

	// A shallow copy with Timeout cleared: http.Client.Timeout covers the body
	// read, so the configured value would cut a healthy stream off mid-crawl.
	// Transport and cookie jar are shared with the configured client, so
	// connection pooling and any installed middleware still apply.
	streamClient := *c.cfg.httpClient
	streamClient.Timeout = 0

	resp, err := streamClient.Do(req)
	if err != nil {
		return nil, fmt.Errorf("xberg: %s %s: %w", methodGet, target, err)
	}
	if resp.StatusCode < 200 || resp.StatusCode >= 300 {
		defer closeQuietly(resp.Body)
		body, readErr := io.ReadAll(resp.Body)
		if readErr != nil {
			return nil, fmt.Errorf("xberg: reading error response body: %w", readErr)
		}
		return nil, classifyHTTPError(resp.StatusCode, body, resp.Header)
	}
	return resp.Body, nil
}

// parseCrawlEvent decodes one SSE frame payload into the kind-discriminated
// variant it names. A malformed frame is an [XbergError], not a bare error, so
// the base errors.As catch documented on that type also covers a stream that
// goes wrong mid-flight — the TypeScript client raises its base error here too. The generated union stores the payload verbatim and
// validates nothing, so the kind is read (and checked) from a minimal envelope
// first — a frame naming a kind the spec does not declare is an error, not an
// event silently handed on with an empty Kind.
func parseCrawlEvent(raw []byte) (CrawlEvent, error) {
	var envelope struct {
		Kind string `json:"kind"`
	}
	if err := json.Unmarshal(raw, &envelope); err != nil {
		return CrawlEvent{}, &XbergError{Message: fmt.Sprintf("decoding crawl event: %s", err)}
	}
	kind := CrawlEventKind(envelope.Kind)
	if !kind.valid() {
		return CrawlEvent{}, &XbergError{
			Message: fmt.Sprintf("crawl event stream sent unrecognized kind %q", envelope.Kind),
		}
	}
	// ~keep dispatch transfers ownership; the scanner cannot overwrite this union's bytes.
	return CrawlEvent{Kind: kind, CrawlEventV1: CrawlEventV1{union: raw}}, nil
}

// sseDecoder assembles text/event-stream frames from the lines of a response
// body.
//
// A frame is terminated by a BLANK LINE, not by a newline: its payload is
// every "data:" field it carried, joined with "\n". Lines opening with ":" are
// comments — this endpoint's 15s heartbeat is one — and "event:"/"id:"/"retry:"
// fields are accepted and ignored. A single space after a field's colon is
// framing, not value, so it is stripped.
//
// All of which is why this exists instead of json.Unmarshal per line: against a
// server that happens to emit one compact frame per line the naive version
// passes every test, then silently drops every multi-line payload and fails on
// the first heartbeat against a real one.
//
// A stream that ends mid-frame — no terminating blank line — discards it, as
// the spec requires: the payload is by definition incomplete.
type sseDecoder struct {
	data    []byte
	present bool
}

func (d *sseDecoder) feed(line []byte) (payload []byte, complete bool, err error) {
	if len(line) == 0 {
		return d.dispatch()
	}
	field, value, _ := bytes.Cut(line, []byte(":"))
	if !bytes.Equal(field, []byte("data")) {
		return nil, false, nil
	}
	value = bytes.TrimPrefix(value, []byte(" "))
	separator := 0
	if d.present {
		separator = 1
	}
	if len(d.data)+len(value)+separator+1 > maxCrawlEventFrameBytes {
		return nil, false, &XbergError{Message: fmt.Sprintf(
			"crawl event frame exceeded %d bytes before the stream closed it", maxCrawlEventFrameBytes,
		)}
	}
	if d.present {
		d.data = append(d.data, '\n')
	}
	d.data = append(d.data, value...)
	d.present = true
	return nil, false, nil
}

func (d *sseDecoder) dispatch() (payload []byte, complete bool, err error) {
	payload, complete = d.data, d.present
	// ~keep Each event owns its buffer after dispatch; retained events must survive later scanner reads.
	d.data = nil
	d.present = false
	return payload, complete, nil
}

// scanEventStreamLines is a [bufio.SplitFunc] splitting on the three line
// terminators the event-stream format allows: "\r\n", "\n" and a lone "\r".
//
// bufio.ScanLines cannot be used: it does not split on a lone "\r", and it
// strips a trailing "\r" from every token, which would silently corrupt a
// payload whose last character really is one. A "\r" at the end of the buffer
// is left unconsumed until more data arrives, since it may be the first half
// of a "\r\n" the network split across two reads.
func scanEventStreamLines(data []byte, atEOF bool) (advance int, token []byte, err error) {
	if atEOF && len(data) == 0 {
		return 0, nil, nil
	}
	for i := range data {
		switch data[i] {
		case '\n':
			return i + 1, data[:i], nil
		case '\r':
			if i == len(data)-1 && !atEOF {
				return 0, nil, nil
			}
			if i+1 < len(data) && data[i+1] == '\n' {
				return i + 2, data[:i], nil
			}
			return i + 1, data[:i], nil
		}
	}
	if atEOF {
		return len(data), data, nil
	}
	return 0, nil, nil
}
