import type { APIRoute } from "astro";
import api from "../../../../spec/api/openapi.yaml?raw";
import backend from "../../../../spec/backend/openapi.yaml?raw";
import pro from "../../../../spec/pro/openapi.yaml?raw";

export function getStaticPaths() {
  return [
    { params: { plane: "api" }, props: { content: api } },
    { params: { plane: "backend" }, props: { content: backend } },
    { params: { plane: "pro" }, props: { content: pro } },
  ];
}

export const GET: APIRoute = ({ props }) =>
  new Response(props.content, { headers: { "Content-Type": "application/yaml; charset=utf-8" } });
