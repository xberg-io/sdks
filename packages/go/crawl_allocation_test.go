package xberg

import (
	"strings"
	"testing"
)

func BenchmarkCrawlEventFrames(b *testing.B) {
	const count = 10000
	stream := strings.Repeat("data: {\"kind\":\"discovered\",\"url\":\"https://example.com\"}\n\n", count)
	b.ReportAllocs()
	b.ResetTimer()
	for b.Loop() {
		seen := 0
		streamCrawlEventFrames(strings.NewReader(stream), func(event CrawlEvent, err error) bool {
			if err != nil || event.Kind != CrawlEventKindDiscovered {
				b.Fatalf("event: %v %v", event.Kind, err)
			}
			seen++
			return true
		})
		if seen != count {
			b.Fatalf("got %d events, want %d", seen, count)
		}
	}
}

func TestCrawlEventsRetainIndependentPayloads(t *testing.T) {
	first := `{"kind":"discovered","url":"https://first.example"}`
	second := `{"kind":"discovered","url":"https://second.example"}`
	var events []CrawlEvent
	streamCrawlEventFrames(strings.NewReader("data: "+first+"\n\ndata: "+second+"\n\n"), func(event CrawlEvent, err error) bool {
		if err != nil {
			t.Fatal(err)
		}
		events = append(events, event)
		return true
	})
	if len(events) != 2 {
		t.Fatalf("got %d events", len(events))
	}
	for i, want := range []string{first, second} {
		got, err := events[i].MarshalJSON()
		if err != nil || string(got) != want {
			t.Fatalf("event %d: %s, %v; want %s", i, got, err, want)
		}
	}
}

func TestCrawlDecoderRejectsMalformedAndUnknownPayloads(t *testing.T) {
	for _, payload := range []string{`{`, `null`, `[]`, `{"kind":1}`, `{"kind":"unknown"}`, `{"kind":"page"} trailing`} {
		if _, err := parseCrawlEvent([]byte(payload)); err == nil {
			t.Errorf("accepted invalid payload %q", payload)
		}
	}
}

func TestCrawlDecoderAcceptsLargePayloadAndRetainsBytes(t *testing.T) {
	payload := `{"kind":"discovered","url":"` + strings.Repeat("a", maxCrawlEventFrameBytes/2) + `"}`
	count := 0
	streamCrawlEventFrames(strings.NewReader("data: "+payload+"\n\n"), func(event CrawlEvent, err error) bool {
		if err != nil {
			t.Fatal(err)
		}
		raw, marshalErr := event.MarshalJSON()
		if marshalErr != nil || string(raw) != payload {
			t.Fatalf("large payload changed: %v", marshalErr)
		}
		count++
		return true
	})
	if count != 1 {
		t.Fatalf("got %d events, want 1", count)
	}
}
