package xberg_test

import (
	"context"
	"errors"
	"fmt"
	"io"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"
	"time"

	xberg "github.com/xberg-io/sdks/packages/go"
)

// GET /v1/crawl-jobs/{id}/events is the one Enterprise operation that answers
// text/event-stream. The bodies below are written as real SSE framing — blank
// line terminated, payloads spread over several "data:" lines, heartbeat
// comments interleaved — because a decoder that splits on newlines and decodes
// each line passes a friendly server and fails a real one.

const (
	testCrawlJobID   = "7c9e6679-7425-40de-944b-e07fc1f90ae7"
	testCrawlEventTS = "2026-05-09T10:00:00Z"
	crawlEventsPath  = "/v1/crawl-jobs/" + testCrawlJobID + "/events"
	sseMediaType     = "text/event-stream"
	// closeWaitTimeout bounds the "did the client hang up?" assertions. The
	// server observes the hang-up as its request context being cancelled.
	closeWaitTimeout = 2 * time.Second
)

func pageFrame() string {
	return dataFrame(fmt.Sprintf(
		`{"kind":"page","crawl_job_id":%q,"ts":%q,"url":"https://example.com/docs","status_code":200,"depth":1}`,
		testCrawlJobID, testCrawlEventTS,
	))
}

func discoveredFrame() string {
	return dataFrame(fmt.Sprintf(
		`{"kind":"discovered","crawl_job_id":%q,"ts":%q,"url":"https://example.com/docs/api","depth":2}`,
		testCrawlJobID, testCrawlEventTS,
	))
}

func errorFrame() string {
	return dataFrame(fmt.Sprintf(
		`{"kind":"error","crawl_job_id":%q,"ts":%q,"url":"https://example.com/gone","error":"404 Not Found"}`,
		testCrawlJobID, testCrawlEventTS,
	))
}

func completeFrame() string {
	return dataFrame(fmt.Sprintf(
		`{"kind":"complete","crawl_job_id":%q,"ts":%q,"pages_crawled":12}`,
		testCrawlJobID, testCrawlEventTS,
	))
}

// dataFrame renders one single-line, blank-line-terminated SSE frame.
func dataFrame(payload string) string { return "data: " + payload + "\n\n" }

// sseServer answers the events route with the given chunks, written in order
// and flushed one at a time so the client sees real network boundaries. When
// repeat is set the chunks cycle forever, which is how the hang-up assertions
// tell a cancelled subscription from a stream that simply ended.
//
// The returned channel closes once the server observes the client hanging up.
func sseServer(t *testing.T, chunks []string, repeat bool) (*xberg.Client, *recordedRequest, <-chan struct{}) {
	t.Helper()
	var seen recordedRequest
	hungUp := make(chan struct{})
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		seen.method = r.Method
		seen.path = r.URL.Path
		seen.query = r.URL.RawQuery
		seen.contentType = r.Header.Get("Accept")
		w.Header().Set("Content-Type", sseMediaType)
		w.WriteHeader(http.StatusOK)
		flusher, ok := w.(http.Flusher)
		if !ok {
			t.Errorf("test server response writer is not a flusher")
			return
		}
		defer close(hungUp)
		for {
			for _, chunk := range chunks {
				if _, err := io.WriteString(w, chunk); err != nil {
					return
				}
				flusher.Flush()
				select {
				case <-r.Context().Done():
					return
				default:
				}
			}
			if !repeat {
				return
			}
		}
	}))
	t.Cleanup(server.Close)
	return mustClient(t, xberg.WithBaseURL(server.URL), xberg.WithTarget(xberg.TargetEnterprise)), &seen, hungUp
}

// collectCrawlEvents drains an event sequence, returning what it yielded and
// the first error it reported.
func collectCrawlEvents(events func(func(xberg.CrawlEvent, error) bool)) ([]xberg.CrawlEvent, error) {
	var collected []xberg.CrawlEvent
	for event, err := range events {
		if err != nil {
			return collected, err
		}
		collected = append(collected, event)
	}
	return collected, nil
}

func kinds(events []xberg.CrawlEvent) []xberg.CrawlEventKind {
	out := make([]xberg.CrawlEventKind, 0, len(events))
	for _, event := range events {
		out = append(out, event.Kind)
	}
	return out
}

func TestStreamCrawlEvents_ParsesEveryKind(t *testing.T) {
	t.Parallel()
	client, seen, _ := sseServer(t, []string{pageFrame(), discoveredFrame(), errorFrame(), completeFrame()}, false)

	events, err := client.StreamCrawlEvents(context.Background(), testCrawlJobID)
	if err != nil {
		t.Fatalf("StreamCrawlEvents: %v", err)
	}
	collected, err := collectCrawlEvents(events)
	if err != nil {
		t.Fatalf("draining the stream: %v", err)
	}

	want := []xberg.CrawlEventKind{
		xberg.CrawlEventKindPage,
		xberg.CrawlEventKindDiscovered,
		xberg.CrawlEventKindError,
		xberg.CrawlEventKindComplete,
	}
	if got := kinds(collected); !equalKinds(got, want) {
		t.Fatalf("kinds = %v, want %v", got, want)
	}
	if seen.method != http.MethodGet || seen.path != crawlEventsPath {
		t.Errorf("request = %s %s, want GET %s", seen.method, seen.path, crawlEventsPath)
	}
	if seen.contentType != sseMediaType {
		t.Errorf("Accept = %q, want %q", seen.contentType, sseMediaType)
	}

	page, err := collected[0].AsPage()
	if err != nil {
		t.Fatalf("AsPage: %v", err)
	}
	if page.Url != "https://example.com/docs" || page.StatusCode != 200 || page.Depth != 1 {
		t.Errorf("page = %+v, want url/status/depth of the page frame", page)
	}
	if page.CrawlJobId.String() != testCrawlJobID {
		t.Errorf("page.CrawlJobId = %s, want %s", page.CrawlJobId, testCrawlJobID)
	}

	discovered, err := collected[1].AsDiscovered()
	if err != nil {
		t.Fatalf("AsDiscovered: %v", err)
	}
	if discovered.Depth != 2 {
		t.Errorf("discovered.Depth = %d, want 2", discovered.Depth)
	}

	failure, err := collected[2].AsError()
	if err != nil {
		t.Fatalf("AsError: %v", err)
	}
	if failure.Error != "404 Not Found" {
		t.Errorf("failure.Error = %q, want %q", failure.Error, "404 Not Found")
	}

	done, err := collected[3].AsComplete()
	if err != nil {
		t.Fatalf("AsComplete: %v", err)
	}
	if done.PagesCrawled != 12 {
		t.Errorf("done.PagesCrawled = %d, want 12", done.PagesCrawled)
	}
}

func TestStreamCrawlEvents_JoinsMultilineDataAndSkipsComments(t *testing.T) {
	t.Parallel()
	multiline := strings.Join([]string{
		": heartbeat",
		"event: message",
		"id: 42",
		"data: {",
		fmt.Sprintf(`data:   "kind": "page", "crawl_job_id": %q,`, testCrawlJobID),
		fmt.Sprintf(`data:   "ts": %q, "url": "https://example.com/split",`, testCrawlEventTS),
		`data:   "status_code": 201, "depth": 3`,
		"data: }",
		"",
		": heartbeat",
		"",
		"",
	}, "\n")
	client, _, _ := sseServer(t, []string{multiline, completeFrame()}, false)

	events, err := client.StreamCrawlEvents(context.Background(), testCrawlJobID)
	if err != nil {
		t.Fatalf("StreamCrawlEvents: %v", err)
	}
	collected, err := collectCrawlEvents(events)
	if err != nil {
		t.Fatalf("draining the stream: %v", err)
	}

	want := []xberg.CrawlEventKind{xberg.CrawlEventKindPage, xberg.CrawlEventKindComplete}
	if got := kinds(collected); !equalKinds(got, want) {
		t.Fatalf("kinds = %v, want %v", got, want)
	}
	page, err := collected[0].AsPage()
	if err != nil {
		t.Fatalf("AsPage: %v", err)
	}
	if page.Url != "https://example.com/split" || page.StatusCode != 201 || page.Depth != 3 {
		t.Errorf("page = %+v, want the fields of the multi-line frame", page)
	}
}

func TestStreamCrawlEvents_ReassemblesAFrameSplitAcrossWrites(t *testing.T) {
	t.Parallel()
	payload := fmt.Sprintf(
		`{"kind":"complete","crawl_job_id":%q,"ts":%q,"pages_crawled":7}`,
		testCrawlJobID, testCrawlEventTS,
	)
	// The last chunk boundary falls between the "\r" and the "\n" of a CRLF,
	// which a decoder that treats a trailing "\r" as a terminator gets wrong.
	chunks := []string{"data: " + payload[:10], payload[10:] + "\r", "\n\r\n"}
	client, _, _ := sseServer(t, chunks, false)

	events, err := client.StreamCrawlEvents(context.Background(), testCrawlJobID)
	if err != nil {
		t.Fatalf("StreamCrawlEvents: %v", err)
	}
	collected, err := collectCrawlEvents(events)
	if err != nil {
		t.Fatalf("draining the stream: %v", err)
	}

	if got := kinds(collected); !equalKinds(got, []xberg.CrawlEventKind{xberg.CrawlEventKindComplete}) {
		t.Fatalf("kinds = %v, want one complete event", got)
	}
	done, err := collected[0].AsComplete()
	if err != nil {
		t.Fatalf("AsComplete: %v", err)
	}
	if done.PagesCrawled != 7 {
		t.Errorf("done.PagesCrawled = %d, want 7", done.PagesCrawled)
	}
}

func TestStreamCrawlEvents_DiscardsAFrameTheStreamEndedMidWay(t *testing.T) {
	t.Parallel()
	unterminated := strings.TrimSuffix(completeFrame(), "\n")
	client, _, _ := sseServer(t, []string{pageFrame(), unterminated}, false)

	events, err := client.StreamCrawlEvents(context.Background(), testCrawlJobID)
	if err != nil {
		t.Fatalf("StreamCrawlEvents: %v", err)
	}
	collected, err := collectCrawlEvents(events)
	if err != nil {
		t.Fatalf("draining the stream: %v", err)
	}

	if got := kinds(collected); !equalKinds(got, []xberg.CrawlEventKind{xberg.CrawlEventKindPage}) {
		t.Fatalf("kinds = %v, want only the page event", got)
	}
}

func TestStreamCrawlEvents_RejectsUnrecognizedKind(t *testing.T) {
	t.Parallel()
	frame := dataFrame(fmt.Sprintf(`{"kind":"teleported","crawl_job_id":%q,"ts":%q}`, testCrawlJobID, testCrawlEventTS))
	client, _, _ := sseServer(t, []string{frame}, false)

	events, err := client.StreamCrawlEvents(context.Background(), testCrawlJobID)
	if err != nil {
		t.Fatalf("StreamCrawlEvents: %v", err)
	}
	collected, err := collectCrawlEvents(events)
	if err == nil {
		t.Fatalf("draining the stream: want an error, got %d events", len(collected))
	}
	if !strings.Contains(err.Error(), `unrecognized kind "teleported"`) {
		t.Errorf("err = %v, want it to name the unrecognized kind", err)
	}
	// The package documents that errors.As(err, &XbergError{}) reaches every
	// error the SDK raises. A stream that goes wrong mid-flight is no exception
	// — TypeScript throws its base error here, and a caller triaging "SDK
	// error vs. bug" must not have that answer depend on the language.
	var base *xberg.XbergError
	if !errors.As(err, &base) {
		t.Errorf("err is %T, want it to satisfy errors.As(&XbergError{})", err)
	}
}

func TestStreamCrawlEvents_RejectsANonJSONFrame(t *testing.T) {
	t.Parallel()
	client, _, _ := sseServer(t, []string{dataFrame("{not valid json")}, false)

	events, err := client.StreamCrawlEvents(context.Background(), testCrawlJobID)
	if err != nil {
		t.Fatalf("StreamCrawlEvents: %v", err)
	}
	collected, err := collectCrawlEvents(events)
	if err == nil {
		t.Fatalf("draining the stream: want an error, got %d events", len(collected))
	}
	var base *xberg.XbergError
	if !errors.As(err, &base) {
		t.Errorf("err is %T, want it to satisfy errors.As(&XbergError{})", err)
	}
	if base.Status != 0 {
		t.Errorf("Status = %d, want 0 — no HTTP response backs a decode failure", base.Status)
	}
}

func TestStreamCrawlEvents_ClosesBodyWhenCallerBreaks(t *testing.T) {
	t.Parallel()
	client, _, hungUp := sseServer(t, []string{pageFrame()}, true)

	events, err := client.StreamCrawlEvents(context.Background(), testCrawlJobID)
	if err != nil {
		t.Fatalf("StreamCrawlEvents: %v", err)
	}
	received := 0
	for event, err := range events {
		if err != nil {
			t.Fatalf("streaming: %v", err)
		}
		if event.Kind != xberg.CrawlEventKindPage {
			t.Fatalf("kind = %q, want page", event.Kind)
		}
		received++
		break
	}

	if received != 1 {
		t.Fatalf("received = %d, want 1", received)
	}
	select {
	case <-hungUp:
	case <-time.After(closeWaitTimeout):
		t.Fatal("breaking out of the range loop did not close the response body")
	}
}

func TestStreamCrawlEvents_ClosesBodyWhenContextIsCanceled(t *testing.T) {
	t.Parallel()
	client, _, hungUp := sseServer(t, []string{pageFrame()}, true)
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	events, err := client.StreamCrawlEvents(ctx, testCrawlJobID)
	if err != nil {
		t.Fatalf("StreamCrawlEvents: %v", err)
	}
	var streamErr error
	for _, iterErr := range events {
		if iterErr != nil {
			streamErr = iterErr
			break
		}
		cancel()
	}

	if streamErr == nil {
		t.Fatal("canceling the context did not end the stream with an error")
	}
	select {
	case <-hungUp:
	case <-time.After(closeWaitTimeout):
		t.Fatal("canceling the context did not close the response body")
	}
}

func TestStreamCrawlEvents_OpensNothingUntilRanged(t *testing.T) {
	t.Parallel()
	client, seen, _ := sseServer(t, []string{completeFrame()}, false)

	events, err := client.StreamCrawlEvents(context.Background(), testCrawlJobID)
	if err != nil {
		t.Fatalf("StreamCrawlEvents: %v", err)
	}
	if seen.path != "" {
		t.Fatalf("path = %q, want no request before the range loop starts", seen.path)
	}

	if _, err := collectCrawlEvents(events); err != nil {
		t.Fatalf("draining the stream: %v", err)
	}
	if seen.path != crawlEventsPath {
		t.Errorf("path = %q, want %q once ranged over", seen.path, crawlEventsPath)
	}
}

func TestStreamCrawlEvents_IsNotRetried(t *testing.T) {
	t.Parallel()
	attempts := 0
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		attempts++
		w.WriteHeader(http.StatusServiceUnavailable)
		_, _ = io.WriteString(w, `{"error":"no NATS"}`)
	}))
	t.Cleanup(server.Close)
	client := mustClient(t,
		xberg.WithBaseURL(server.URL),
		xberg.WithTarget(xberg.TargetEnterprise),
		xberg.WithRetries(3),
	)

	events, err := client.StreamCrawlEvents(context.Background(), testCrawlJobID)
	if err != nil {
		t.Fatalf("StreamCrawlEvents: %v", err)
	}
	if _, err := collectCrawlEvents(events); err == nil {
		t.Fatal("draining the stream: want a 503 error")
	}

	// A replayed subscription redelivers every event the caller already
	// handled, so the stream must surface the failure instead of retrying.
	if attempts != 1 {
		t.Errorf("attempts = %d, want exactly 1 — the stream must not be retried", attempts)
	}
}

func TestStreamCrawlEvents_MapsNotFound(t *testing.T) {
	t.Parallel()
	var seen recordedRequest
	client := targetClient(t, xberg.TargetEnterprise, http.StatusNotFound, `{"error":"no such crawl job"}`, &seen)

	events, err := client.StreamCrawlEvents(context.Background(), testCrawlJobID)
	if err != nil {
		t.Fatalf("StreamCrawlEvents: %v", err)
	}
	_, err = collectCrawlEvents(events)
	var notFound *xberg.NotFoundError
	if !asError(err, &notFound) {
		t.Fatalf("err = %v, want a *NotFoundError", err)
	}
}

// TestStreamCrawlEvents_StreamsOnPro pins that the crawl feed is reachable on
// Pro. The Pro spec declares `/v1/crawl-jobs/{id}/events` and always has, so the
// client must open the stream rather than refuse it — this method used to be
// gated to Enterprise, denying Pro callers an endpoint their own server serves.
func TestStreamCrawlEvents_StreamsOnPro(t *testing.T) {
	t.Parallel()
	var requestedPath string
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		requestedPath = r.URL.Path
		w.Header().Set("Content-Type", sseMediaType)
		_, _ = io.WriteString(w, pageFrame())
	}))
	t.Cleanup(server.Close)
	client := mustClient(t, xberg.WithBaseURL(server.URL), xberg.WithTarget(xberg.TargetPro))

	events, err := client.StreamCrawlEvents(context.Background(), testCrawlJobID)
	var tierErr *xberg.TierError
	if errors.As(err, &tierErr) {
		t.Fatalf("crawl events must not be Enterprise-gated, got %v", tierErr)
	}
	if err != nil {
		t.Fatalf("StreamCrawlEvents on pro: %v", err)
	}
	var kinds []xberg.CrawlEventKind
	for event, iterErr := range events {
		if iterErr != nil {
			t.Fatalf("iterating the pro stream: %v", iterErr)
		}
		kinds = append(kinds, event.Kind)
	}
	if len(kinds) != 1 || kinds[0] != xberg.CrawlEventKindPage {
		t.Errorf("kinds = %v, want exactly one page event", kinds)
	}
	if requestedPath != crawlEventsPath {
		t.Errorf("path = %q, want %q", requestedPath, crawlEventsPath)
	}
}

func equalKinds(got, want []xberg.CrawlEventKind) bool {
	if len(got) != len(want) {
		return false
	}
	for i := range got {
		if got[i] != want[i] {
			return false
		}
	}
	return true
}

// TestStreamCrawlEvents_RejectsAFrameThatNeverCloses covers the second half of
// the frame cap. The per-line cap already stops one endless line; this is the
// other shape — a succession of lines each well under it, with the blank line
// that would close the frame never arriving.
func TestStreamCrawlEvents_RejectsAFrameThatNeverCloses(t *testing.T) {
	t.Parallel()
	// 64 KiB per line, repeated forever: under the 1 MiB line cap, over the
	// 1 MiB frame cap after 16 of them.
	line := "data: " + strings.Repeat("x", 64*1024) + "\n"
	client, _, _ := sseServer(t, []string{line}, true)

	events, err := client.StreamCrawlEvents(context.Background(), testCrawlJobID)
	if err != nil {
		t.Fatalf("StreamCrawlEvents: %v", err)
	}
	collected, err := collectCrawlEvents(events)
	if err == nil {
		t.Fatalf("draining the stream: want an error, got %d events", len(collected))
	}
	if !strings.Contains(err.Error(), "exceeded") {
		t.Errorf("err = %v, want it to report the frame cap", err)
	}
	var base *xberg.XbergError
	if !errors.As(err, &base) {
		t.Errorf("err is %T, want it to satisfy errors.As(&XbergError{})", err)
	}
}
