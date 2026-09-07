// @ts-check
import starlight from "@astrojs/starlight";
import { xbergStarlightConfig } from "@xberg-io/docs-theme";
import { defineConfig } from "astro/config";
import starlightLlmsTxt from "starlight-llms-txt";

const API_LANGUAGES = [
  { label: "Python", slug: "reference/api-python" },
  { label: "TypeScript / Node.js", slug: "reference/api-typescript" },
  { label: "Go", slug: "reference/api-go" },
];

export default defineConfig({
  site: "https://docs.sdks.xberg.io",
  integrations: [
    starlight(
      xbergStarlightConfig({
        title: "Xberg SDKs",
        description:
          "Official Python, TypeScript and Go clients for the Xberg extraction API. " +
          "One dual-target client per language: point it at an Xberg Enterprise or an Xberg Pro " +
          "deployment and it exposes the shared surface plus that tier's own operations.",
        githubUrl: "https://github.com/xberg-io/sdks",
        editBaseUrl: "https://github.com/xberg-io/sdks/edit/main/docs-site/",
        plugins: [
          starlightLlmsTxt({
            customSets: [
              {
                label: "Get Started",
                description: "Install a client and make a first extraction call.",
                paths: ["getting-started/**"],
              },
              {
                label: "Guides",
                description: "Task-focused guides: extraction, jobs, RAG, auto-tune, the control plane.",
                paths: ["guides/**"],
              },
              {
                label: "Concepts",
                description: "Tiers and capability gating, authentication, errors and retries.",
                paths: ["concepts/**"],
              },
              {
                label: "Reference",
                description: "Per-language method reference, tier capabilities and the raw OpenAPI surface.",
                paths: ["reference/**"],
              },
              {
                label: "More",
                description: "Changelog.",
                paths: ["changelog"],
              },
            ],
            optionalLinks: [
              {
                label: "GitHub",
                url: "https://github.com/xberg-io/sdks",
                description: "Source code and issues",
              },
            ],
          }),
        ],
        sidebar: [
          { label: "Home", link: "/" },
          {
            label: "Get Started",
            items: [
              { label: "Installation", slug: "getting-started/installation" },
              { label: "Quickstart", slug: "getting-started/quickstart" },
            ],
          },
          { label: "Guides", items: [{ autogenerate: { directory: "guides" } }] },
          { label: "Concepts", items: [{ autogenerate: { directory: "concepts" } }] },
          {
            label: "Reference",
            items: [
              { label: "API", items: API_LANGUAGES },
              { label: "Tier capabilities", slug: "reference/tier-capabilities" },
              { label: "OpenAPI", slug: "reference/openapi" },
            ],
          },
          {
            label: "More",
            items: [{ label: "Changelog", slug: "changelog" }],
          },
        ],
      }),
    ),
  ],
});
