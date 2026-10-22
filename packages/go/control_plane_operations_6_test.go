package xberg

import (
	"context"
	"errors"
	"io"
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestControlPlaneBackendGetIntegrationSync(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "BackendGetIntegrationSync", method: "GET", path: "/v1/projects/id%2F%20space/integrations/id%2F%20space/sync",
		query: map[string]string{},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.BackendGetIntegrationSync(ctx, "id/ space", "id/ space")
			return err
		},
	})
}

func TestControlPlaneBackendSetIntegrationSync(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "BackendSetIntegrationSync", method: "PUT", path: "/v1/projects/id%2F%20space/integrations/id%2F%20space/sync",
		query: map[string]string{},
		body:  true, public: false,
		call: func(ctx context.Context, c *Client) error {
			return c.BackendSetIntegrationSync(ctx, "id/ space", "id/ space", SetIntegrationSyncRequest{Enabled: true})
		},
	})
}

func TestControlPlaneAssignProjectRole(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "AssignProjectRole", method: "PATCH", path: "/v1/projects/id%2F%20space/members/id%2F%20space/custom-role",
		query: map[string]string{},
		body:  true, public: false,
		call: func(ctx context.Context, c *Client) error {
			return c.AssignProjectRole(ctx, "id/ space", "id/ space", AssignProjectRoleRequest{})
		},
	})
}

func TestControlPlaneListProjectRoles(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "ListProjectRoles", method: "GET", path: "/v1/projects/id%2F%20space/roles",
		query: map[string]string{"limit": "7", "offset": "7"},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.ListProjectRoles(ctx, "id/ space", map[string]string{"limit": "7", "offset": "7"})
			return err
		},
	})
}

func TestControlPlaneCreateProjectRole(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "CreateProjectRole", method: "POST", path: "/v1/projects/id%2F%20space/roles",
		query: map[string]string{},
		body:  true, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.CreateProjectRole(ctx, "id/ space", CreateProjectRoleRequest{})
			return err
		},
	})
}

func TestControlPlaneGetProjectRole(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "GetProjectRole", method: "GET", path: "/v1/projects/id%2F%20space/roles/id%2F%20space",
		query: map[string]string{},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.GetProjectRole(ctx, "id/ space", "id/ space")
			return err
		},
	})
}

func TestControlPlaneUpdateProjectRole(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "UpdateProjectRole", method: "PATCH", path: "/v1/projects/id%2F%20space/roles/id%2F%20space",
		query: map[string]string{},
		body:  true, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.UpdateProjectRole(ctx, "id/ space", "id/ space", UpdateProjectRoleRequest{})
			return err
		},
	})
}

func TestControlPlaneDeleteProjectRole(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "DeleteProjectRole", method: "DELETE", path: "/v1/projects/id%2F%20space/roles/id%2F%20space",
		query: map[string]string{},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error { return c.DeleteProjectRole(ctx, "id/ space", "id/ space") },
	})
}

func TestControlPlaneListSamlDomains(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "ListSamlDomains", method: "GET", path: "/v1/projects/id%2F%20space/saml/domains",
		query: map[string]string{},
		body:  false, public: false,
		response: `[]`,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.ListSamlDomains(ctx, "id/ space")
			return err
		},
	})
}

func TestControlPlaneCreateSamlDomain(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "CreateSamlDomain", method: "POST", path: "/v1/projects/id%2F%20space/saml/domains",
		query: map[string]string{},
		body:  true, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.CreateSamlDomain(ctx, "id/ space", SamlDomainRequest{})
			return err
		},
	})
}

func TestControlPlaneVerifySamlDomain(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "VerifySamlDomain", method: "POST", path: "/v1/projects/id%2F%20space/saml/domains/id%2F%20space/verify",
		query: map[string]string{},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error { return c.VerifySamlDomain(ctx, "id/ space", "id/ space") },
	})
}

func TestControlPlaneListSamlProviders(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "ListSamlProviders", method: "GET", path: "/v1/projects/id%2F%20space/saml/providers",
		query: map[string]string{},
		body:  false, public: false,
		response: `[]`,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.ListSamlProviders(ctx, "id/ space")
			return err
		},
	})
}

func TestControlPlaneCreateSamlProvider(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "CreateSamlProvider", method: "POST", path: "/v1/projects/id%2F%20space/saml/providers",
		query: map[string]string{},
		body:  true, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.CreateSamlProvider(ctx, "id/ space", SamlProviderRequest{})
			return err
		},
	})
}

func TestControlPlaneUpdateSamlProvider(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "UpdateSamlProvider", method: "PUT", path: "/v1/projects/id%2F%20space/saml/providers/id%2F%20space",
		query: map[string]string{},
		body:  true, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.UpdateSamlProvider(ctx, "id/ space", "id/ space", SamlProviderRequest{})
			return err
		},
	})
}

func TestControlPlaneDeleteSamlProvider(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "DeleteSamlProvider", method: "DELETE", path: "/v1/projects/id%2F%20space/saml/providers/id%2F%20space",
		query: map[string]string{},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error { return c.DeleteSamlProvider(ctx, "id/ space", "id/ space") },
	})
}

func TestControlPlaneListScimConnections(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "ListScimConnections", method: "GET", path: "/v1/projects/id%2F%20space/scim/connections",
		query: map[string]string{},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.ListScimConnections(ctx, "id/ space")
			return err
		},
	})
}

func TestControlPlaneCreateScimConnection(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "CreateScimConnection", method: "POST", path: "/v1/projects/id%2F%20space/scim/connections",
		query: map[string]string{},
		body:  true, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.CreateScimConnection(ctx, "id/ space", CreateScimConnectionRequest{})
			return err
		},
	})
}

func TestControlPlaneListScimAdminGroups(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "ListScimAdminGroups", method: "GET", path: "/v1/projects/id%2F%20space/scim/connections/id%2F%20space/groups",
		query: map[string]string{},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.ListScimAdminGroups(ctx, "id/ space", "id/ space")
			return err
		},
	})
}

func TestControlPlaneReplaceScimGroupRoles(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "ReplaceScimGroupRoles", method: "PUT", path: "/v1/projects/id%2F%20space/scim/connections/id%2F%20space/groups/id%2F%20space/roles",
		query: map[string]string{},
		body:  true, public: false,
		call: func(ctx context.Context, c *Client) error {
			return c.ReplaceScimGroupRoles(ctx, "id/ space", "id/ space", "id/ space", ReplaceScimGroupRolesRequest{})
		},
	})
}

func TestControlPlaneRotateScimConnectionSecret(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "RotateScimConnectionSecret", method: "POST", path: "/v1/projects/id%2F%20space/scim/connections/id%2F%20space/rotate",
		query: map[string]string{},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.RotateScimConnectionSecret(ctx, "id/ space", "id/ space")
			return err
		},
	})
}

func TestControlPlaneSamlProvidersAndRolesDecode(t *testing.T) {
	control := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", contentTypeJSON)
		switch r.URL.Path {
		case "/v1/projects/p/saml/providers":
			_, _ = io.WriteString(w, `[{"id":"33333333-3333-3333-3333-333333333333","label":"Okta","enabled":true}]`)
		case "/v1/projects/p/roles/22222222-2222-2222-2222-222222222222":
			_, _ = io.WriteString(w, `{"id":"22222222-2222-2222-2222-222222222222","name":"Reviewer","permissions":["job.read"]}`)
		default:
			t.Errorf("unexpected path %s", r.URL.Path)
		}
	}))
	defer control.Close()
	client, err := New(WithBaseURL("http://127.0.0.1:1"), WithControlPlaneBaseURL(control.URL), WithTarget(TargetEnterprise))
	if err != nil {
		t.Fatal(err)
	}
	providers, err := client.ListSamlProviders(context.Background(), "p")
	if err != nil {
		t.Fatal(err)
	}
	if len(providers) != 1 || providers[0].Label != "Okta" || !providers[0].Enabled {
		t.Fatalf("providers = %+v", providers)
	}
	role, err := client.GetProjectRole(context.Background(), "p", "22222222-2222-2222-2222-222222222222")
	if err != nil {
		t.Fatal(err)
	}
	if role.Name != "Reviewer" || len(role.Permissions) != 1 || role.Permissions[0] != ProjectPermission("job.read") {
		t.Fatalf("role = %+v", role)
	}
}

func TestControlPlaneNewOperationsPropagateNotFound(t *testing.T) {
	control := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		w.Header().Set("Content-Type", contentTypeJSON)
		w.WriteHeader(http.StatusNotFound)
		_, _ = io.WriteString(w, `{"message":"missing"}`)
	}))
	defer control.Close()
	client, err := New(WithBaseURL("http://127.0.0.1:1"), WithControlPlaneBaseURL(control.URL), WithTarget(TargetEnterprise))
	if err != nil {
		t.Fatal(err)
	}
	_, listErr := client.ListSamlDomains(context.Background(), "p")
	replaceErr := client.ReplaceScimGroupRoles(context.Background(), "p", "c", "g", ReplaceScimGroupRolesRequest{})
	for _, err := range []error{listErr, replaceErr} {
		var notFound *NotFoundError
		if !errors.As(err, &notFound) || notFound.Status != http.StatusNotFound {
			t.Fatalf("error = %v; want NotFoundError", err)
		}
	}
}
