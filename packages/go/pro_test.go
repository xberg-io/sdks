package xberg_test

import (
	"context"
	"net/http"
	"net/http/httptest"
	"testing"

	xberg "github.com/xberg-io/sdks/packages/go"
)

const (
	testProjectID     = "bbbbbbbb-0000-4000-8000-000000000001"
	testIntegrationID = "dddddddd-0000-4000-8000-000000000001"
)

// proClient spins up a Pro-targeted client whose transport records the method,
// path and query of the single request the method under test issues.
func proClient(t *testing.T, status int, response string, seen *recordedRequest) *xberg.Client {
	t.Helper()
	return targetClient(t, xberg.TargetPro, status, response, seen)
}

// -- projects -----------------------------------------------------------------

func TestListProjects_ReturnsTypedPage(t *testing.T) {
	t.Parallel()
	var seen recordedRequest
	client := proClient(t, http.StatusOK, `{
		"projects":[{"id":"bbbbbbbb-0000-4000-8000-000000000001","name":"Acme","slug":"acme","status":"ACTIVE",
			"owner_user_id":"ffffffff-0000-4000-8000-000000000001","created_at":"2025-01-01T00:00:00Z",
			"updated_at":"2025-01-02T00:00:00Z","api_key_count":2,
			"webhook_count":0,"total_pages_extracted":1200}],
		"total":1,"limit":50,"offset":0
	}`, &seen)

	page, err := client.ListProjects(context.Background(), 50, 0)
	if err != nil {
		t.Fatalf("ListProjects: %v", err)
	}
	if seen.method != http.MethodGet || seen.path != "/v1/projects" {
		t.Errorf("request = %s %s, want GET /v1/projects", seen.method, seen.path)
	}
	if seen.query != "limit=50" {
		t.Errorf("query = %q, want limit=50 (offset 0 omitted)", seen.query)
	}
	if page.Total != 1 || len(page.Projects) != 1 {
		t.Fatalf("page = %+v, want one project", page)
	}
	if page.Projects[0].Slug != "acme" || page.Projects[0].ApiKeyCount != 2 {
		t.Errorf("project = %+v, want slug=acme api_key_count=2", page.Projects[0])
	}
	if page.Projects[0].TotalPagesExtracted != 1200 {
		t.Errorf("TotalPagesExtracted = %d, want 1200", page.Projects[0].TotalPagesExtracted)
	}
}

func TestCreateProject_PostsRequestBody(t *testing.T) {
	t.Parallel()
	var seen recordedRequest
	client := proClient(t, http.StatusCreated, `{"id":"bbbbbbbb-0000-4000-8000-000000000001","name":"Acme","slug":"acme",
		"status":"ACTIVE","owner_user_id":"ffffffff-0000-4000-8000-000000000001","created_at":"2025-01-01T00:00:00Z",
		"updated_at":"2025-01-01T00:00:00Z","api_key_count":0,"webhook_count":0,
		"total_pages_extracted":0}`, &seen)

	project, err := client.CreateProject(context.Background(), xberg.CreateProjectRequest{
		Name: "Acme",
		Slug: "acme",
	})
	if err != nil {
		t.Fatalf("CreateProject: %v", err)
	}
	if seen.method != http.MethodPost || seen.path != "/v1/projects" {
		t.Errorf("request = %s %s, want POST /v1/projects", seen.method, seen.path)
	}
	if seen.body != `{"name":"Acme","slug":"acme"}` {
		t.Errorf("body = %s, want the name+slug payload", seen.body)
	}
	if project.Id.String() != "bbbbbbbb-0000-4000-8000-000000000001" {
		t.Errorf("Id = %q, want p1", project.Id)
	}
}

// -- API keys -----------------------------------------------------------------

func TestListApiKeys_ReturnsTypedPage(t *testing.T) {
	t.Parallel()
	var seen recordedRequest
	client := proClient(t, http.StatusOK, `{
		"api_keys":[{"id":"eeeeeeee-0000-4000-8000-000000000001","key_prefix":"kz_abcdefgh","scope":"read",
			"created_at":"2025-01-01T00:00:00Z"}],
		"total":1,"limit":100,"offset":0
	}`, &seen)

	page, err := client.ListAPIKeys(context.Background(), testProjectID, 0, 0)
	if err != nil {
		t.Fatalf("ListAPIKeys: %v", err)
	}
	if seen.path != "/v1/projects/bbbbbbbb-0000-4000-8000-000000000001/api-keys" {
		t.Errorf("path = %q, want /v1/projects/bbbbbbbb-0000-4000-8000-000000000001/api-keys", seen.path)
	}
	if seen.query != "" {
		t.Errorf("query = %q, want empty when limit and offset are unset", seen.query)
	}
	if len(page.ApiKeys) != 1 || page.ApiKeys[0].KeyPrefix != "kz_abcdefgh" {
		t.Fatalf("page = %+v, want one key with prefix kz_abcdefgh", page)
	}
	if page.ApiKeys[0].Scope != xberg.ApiKeyScopeRead {
		t.Errorf("Scope = %q, want read", page.ApiKeys[0].Scope)
	}
}

func TestCreateApiKey_ReturnsPlaintextKeyOnce(t *testing.T) {
	t.Parallel()
	var seen recordedRequest
	client := proClient(t, http.StatusCreated, `{"id":"eeeeeeee-0000-4000-8000-000000000001","key":"kz_secret_value",
		"key_prefix":"kz_secret","scope":"write","created_at":"2025-01-01T00:00:00Z"}`, &seen)

	scope := xberg.ApiKeyScopeWrite
	name := "ci"
	created, err := client.CreateAPIKey(context.Background(), testProjectID, xberg.CreateApiKeyRequest{
		Name:  &name,
		Scope: &scope,
	})
	if err != nil {
		t.Fatalf("CreateAPIKey: %v", err)
	}
	if seen.method != http.MethodPost || seen.path != "/v1/projects/bbbbbbbb-0000-4000-8000-000000000001/api-keys" {
		t.Errorf("request = %s %s, want POST /v1/projects/bbbbbbbb-0000-4000-8000-000000000001/api-keys", seen.method, seen.path)
	}
	if seen.body != `{"name":"ci","scope":"write"}` {
		t.Errorf("body = %s, want the name+scope payload", seen.body)
	}
	if created.Key != "kz_secret_value" {
		t.Errorf("Key = %q, want the plaintext key", created.Key)
	}
}

func TestRevokeApiKey_HandlesNoContent(t *testing.T) {
	t.Parallel()
	var seen recordedRequest
	client := proClient(t, http.StatusNoContent, "", &seen)

	if err := client.RevokeAPIKey(context.Background(), testProjectID, "eeeeeeee-0000-4000-8000-000000000001"); err != nil {
		t.Fatalf("RevokeAPIKey: %v", err)
	}
	if seen.method != http.MethodDelete {
		t.Errorf("method = %q, want DELETE", seen.method)
	}
	if seen.path != "/v1/projects/bbbbbbbb-0000-4000-8000-000000000001/api-keys/eeeeeeee-0000-4000-8000-000000000001" {
		t.Errorf("path = %q, want /v1/projects/bbbbbbbb-0000-4000-8000-000000000001/api-keys/eeeeeeee-0000-4000-8000-000000000001", seen.path)
	}
}

// -- integrations -------------------------------------------------------------

func TestListIntegrations_ReturnsTypedPage(t *testing.T) {
	t.Parallel()
	var seen recordedRequest
	client := proClient(t, http.StatusOK, `{
		"integrations":[{"id":"dddddddd-0000-4000-8000-000000000001","name":"Drive","kind":"google_drive",
			"auth_type":"oauth2","provider":"google","project_id":"bbbbbbbb-0000-4000-8000-000000000001"}],
		"total":1,"limit":50,"offset":10
	}`, &seen)

	page, err := client.ListIntegrations(context.Background(), testProjectID, 50, 10)
	if err != nil {
		t.Fatalf("ListIntegrations: %v", err)
	}
	if seen.path != "/v1/projects/bbbbbbbb-0000-4000-8000-000000000001/integrations" {
		t.Errorf("path = %q, want /v1/projects/bbbbbbbb-0000-4000-8000-000000000001/integrations", seen.path)
	}
	if seen.query != "limit=50&offset=10" {
		t.Errorf("query = %q, want limit=50&offset=10", seen.query)
	}
	if len(page.Integrations) != 1 || page.Integrations[0].Provider != "google" {
		t.Fatalf("page = %+v, want one google integration", page)
	}
}

func TestCreateIntegration_PostsRequestBody(t *testing.T) {
	t.Parallel()
	var seen recordedRequest
	client := proClient(t, http.StatusCreated, `{"id":"dddddddd-0000-4000-8000-000000000001","name":"Drive",
		"kind":"google_drive","auth_type":"oauth2","provider":"google"}`, &seen)

	integration, err := client.CreateIntegration(context.Background(), testProjectID,
		xberg.CreateIntegrationRequest{Name: "Drive", Kind: "google_drive", AuthType: "oauth2"})
	if err != nil {
		t.Fatalf("CreateIntegration: %v", err)
	}
	if seen.method != http.MethodPost || seen.path != "/v1/projects/bbbbbbbb-0000-4000-8000-000000000001/integrations" {
		t.Errorf("request = %s %s, want POST /v1/projects/bbbbbbbb-0000-4000-8000-000000000001/integrations", seen.method, seen.path)
	}
	// `credentials` is required by Pro's CreateIntegrationRequest -- it carries no
	// `#[serde(default)]`, so the key must be present even when it is null, which is
	// what Pro's own integration tests send. The client used to omit it, which Pro
	// would have rejected; the spec typing the property is what surfaced that.
	if seen.body != `{"auth_type":"oauth2","credentials":null,"kind":"google_drive","name":"Drive"}` {
		t.Errorf("body = %s, want the payload including a null credentials", seen.body)
	}
	if integration.Id.String() != testIntegrationID {
		t.Errorf("Id = %q, want %s", integration.Id, testIntegrationID)
	}
}

func TestGetIntegration_ReturnsTypedIntegration(t *testing.T) {
	t.Parallel()
	var seen recordedRequest
	client := proClient(t, http.StatusOK, `{"id":"dddddddd-0000-4000-8000-000000000001","name":"Drive",
		"kind":"google_drive","auth_type":"oauth2","provider":"google"}`, &seen)

	integration, err := client.GetIntegration(context.Background(), testProjectID, testIntegrationID)
	if err != nil {
		t.Fatalf("GetIntegration: %v", err)
	}
	if seen.method != http.MethodGet || seen.path != "/v1/projects/bbbbbbbb-0000-4000-8000-000000000001/integrations/dddddddd-0000-4000-8000-000000000001" {
		t.Errorf("request = %s %s, want GET the integration route", seen.method, seen.path)
	}
	if integration.Kind != "google_drive" {
		t.Errorf("Kind = %q, want google_drive", integration.Kind)
	}
}

func TestDeleteIntegration_HandlesNoContent(t *testing.T) {
	t.Parallel()
	var seen recordedRequest
	client := proClient(t, http.StatusNoContent, "", &seen)

	if err := client.DeleteIntegration(context.Background(), testProjectID, testIntegrationID); err != nil {
		t.Fatalf("DeleteIntegration: %v", err)
	}
	if seen.method != http.MethodDelete || seen.path != "/v1/projects/bbbbbbbb-0000-4000-8000-000000000001/integrations/dddddddd-0000-4000-8000-000000000001" {
		t.Errorf("request = %s %s, want DELETE the integration route", seen.method, seen.path)
	}
}

func TestConnectIntegration_ReturnsAuthorizeURL(t *testing.T) {
	t.Parallel()
	var seen recordedRequest
	client := proClient(t, http.StatusOK, `{"authorize_url":"https://accounts.google.test/o/oauth2/auth"}`, &seen)

	begun, err := client.ConnectIntegration(context.Background(), testProjectID, testIntegrationID)
	if err != nil {
		t.Fatalf("ConnectIntegration: %v", err)
	}
	if seen.method != http.MethodPost || seen.path != "/v1/projects/bbbbbbbb-0000-4000-8000-000000000001/integrations/dddddddd-0000-4000-8000-000000000001/connect" {
		t.Errorf("request = %s %s, want POST the connect route", seen.method, seen.path)
	}
	if seen.body != "" {
		t.Errorf("body = %q, want no payload", seen.body)
	}
	if begun.AuthorizeUrl != "https://accounts.google.test/o/oauth2/auth" {
		t.Errorf("AuthorizeUrl = %q, want the provider URL", begun.AuthorizeUrl)
	}
}

func TestDisconnectIntegration_HandlesNoContent(t *testing.T) {
	t.Parallel()
	var seen recordedRequest
	client := proClient(t, http.StatusNoContent, "", &seen)

	if err := client.DisconnectIntegration(context.Background(), testProjectID, testIntegrationID); err != nil {
		t.Fatalf("DisconnectIntegration: %v", err)
	}
	if seen.method != http.MethodPost || seen.path != "/v1/projects/bbbbbbbb-0000-4000-8000-000000000001/integrations/dddddddd-0000-4000-8000-000000000001/disconnect" {
		t.Errorf("request = %s %s, want POST the disconnect route", seen.method, seen.path)
	}
}

func TestListIntegrationDocuments_EncodesFilters(t *testing.T) {
	t.Parallel()
	var seen recordedRequest
	client := proClient(t, http.StatusOK, `{"documents":[
		{"id":"d1","name":"contract.pdf","mime_type":"application/pdf","size_bytes":2048}
	]}`, &seen)

	mimeTypes := "application/pdf,text/plain"
	limit := int64(25)
	docs, err := client.ListIntegrationDocuments(context.Background(), testProjectID, testIntegrationID,
		&xberg.ListIntegrationDocumentsParams{MimeTypes: &mimeTypes, Limit: &limit})
	if err != nil {
		t.Fatalf("ListIntegrationDocuments: %v", err)
	}
	if seen.path != "/v1/projects/bbbbbbbb-0000-4000-8000-000000000001/integrations/dddddddd-0000-4000-8000-000000000001/documents" {
		t.Errorf("path = %q, want the documents route", seen.path)
	}
	want := "limit=25&mime_types=application%2Fpdf%2Ctext%2Fplain"
	if seen.query != want {
		t.Errorf("query = %q, want %q", seen.query, want)
	}
	if len(docs.Documents) != 1 || docs.Documents[0].Name != "contract.pdf" {
		t.Fatalf("documents = %+v, want one contract.pdf", docs.Documents)
	}
	if docs.Documents[0].SizeBytes == nil || *docs.Documents[0].SizeBytes != 2048 {
		t.Errorf("SizeBytes = %v, want 2048", docs.Documents[0].SizeBytes)
	}
}

func TestListIntegrationDocuments_OmitsQueryWhenParamsAreNil(t *testing.T) {
	t.Parallel()
	var seen recordedRequest
	client := proClient(t, http.StatusOK, `{"documents":[]}`, &seen)

	if _, err := client.ListIntegrationDocuments(
		context.Background(), testProjectID, testIntegrationID, nil,
	); err != nil {
		t.Fatalf("ListIntegrationDocuments: %v", err)
	}
	if seen.query != "" {
		t.Errorf("query = %q, want empty for nil params", seen.query)
	}
}

func TestFetchIntegrationDocument_ReturnsRawBytes(t *testing.T) {
	t.Parallel()
	var seen recordedRequest
	client := proClient(t, http.StatusOK, "\x89PNG\r\n\x1a\nbinary", &seen)

	got, err := client.FetchIntegrationDocument(context.Background(), testProjectID, testIntegrationID, "d 1")
	if err != nil {
		t.Fatalf("FetchIntegrationDocument: %v", err)
	}
	if seen.path != "/v1/projects/bbbbbbbb-0000-4000-8000-000000000001/integrations/dddddddd-0000-4000-8000-000000000001/documents/d 1" {
		t.Errorf("decoded path = %q, want the escaped document route", seen.path)
	}
	if string(got) != "\x89PNG\r\n\x1a\nbinary" {
		t.Errorf("bytes = %q, want the raw document payload", got)
	}
}

// -- tier gating --------------------------------------------------------------

func TestControlPlane_IsGatedToPro(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(http.HandlerFunc(func(_ http.ResponseWriter, r *http.Request) {
		t.Errorf("unexpected HTTP call to %s; gate should short-circuit", r.URL.Path)
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL), xberg.WithTarget(xberg.TargetEnterprise))
	ctx := context.Background()

	calls := map[string]func() error{
		"ListProjects":  func() error { _, err := client.ListProjects(ctx, 0, 0); return err },
		"CreateProject": func() error { _, err := client.CreateProject(ctx, xberg.CreateProjectRequest{}); return err },
		"ListAPIKeys": func() error {
			_, err := client.ListAPIKeys(ctx, testProjectID, 0, 0)
			return err
		},
		"CreateAPIKey": func() error {
			_, err := client.CreateAPIKey(ctx, testProjectID, xberg.CreateApiKeyRequest{})
			return err
		},
		"RevokeAPIKey": func() error { return client.RevokeAPIKey(ctx, testProjectID, "eeeeeeee-0000-4000-8000-000000000001") },
		"ListIntegrations": func() error {
			_, err := client.ListIntegrations(ctx, testProjectID, 0, 0)
			return err
		},
		"CreateIntegration": func() error {
			_, err := client.CreateIntegration(ctx, testProjectID, xberg.CreateIntegrationRequest{})
			return err
		},
		"GetIntegration": func() error {
			_, err := client.GetIntegration(ctx, testProjectID, testIntegrationID)
			return err
		},
		"DeleteIntegration": func() error { return client.DeleteIntegration(ctx, testProjectID, testIntegrationID) },
		"ConnectIntegration": func() error {
			_, err := client.ConnectIntegration(ctx, testProjectID, testIntegrationID)
			return err
		},
		"DisconnectIntegration": func() error {
			return client.DisconnectIntegration(ctx, testProjectID, testIntegrationID)
		},
		"ListIntegrationDocuments": func() error {
			_, err := client.ListIntegrationDocuments(ctx, testProjectID, testIntegrationID, nil)
			return err
		},
		"FetchIntegrationDocument": func() error {
			_, err := client.FetchIntegrationDocument(ctx, testProjectID, testIntegrationID, "d1")
			return err
		},
	}
	if len(calls) != 13 {
		t.Fatalf("covered %d control-plane methods, want all 13", len(calls))
	}
	for name, call := range calls {
		t.Run(name, func(t *testing.T) {
			t.Parallel()
			err := call()
			var tierErr *xberg.TierError
			if !asError(err, &tierErr) {
				t.Fatalf("expected TierError, got %T: %v", err, err)
			}
			if tierErr.Required != "pro" || tierErr.Method != name {
				t.Errorf("TierError = %+v, want method=%s required=pro", tierErr, name)
			}
		})
	}
}
