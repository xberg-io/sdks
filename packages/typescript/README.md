# @kreuzberg/cloud

Official TypeScript / Node.js client for the [Kreuzberg Cloud](https://kreuzberg.cloud)
document-processing API.

- ESM-only, modern (Node 20+, Bun, Deno, Cloudflare Workers)
- Generated types via `openapi-typescript`, runtime via `openapi-fetch`
- Tree-shakable, ~6 KB runtime, no bundled dependencies

## Install

```sh
pnpm add @kreuzberg/cloud
# or
npm install @kreuzberg/cloud
```

## Usage

```ts
import { createClient } from "@kreuzberg/cloud";

const client = createClient({
  baseUrl: "https://api.kreuzberg.cloud",
  apiKey: process.env.KREUZBERG_API_KEY!,
});

const { data, error } = await client.GET("/healthz");
if (error) throw error;
console.log(data.status);
```

## License

MIT — © Kreuzberg, Inc.
