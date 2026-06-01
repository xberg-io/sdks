# Hand-rolled Dart models

Source of truth for hand-rolled `freezed` sealed unions that `swagger_parser`
cannot synthesize from discriminator-based `oneOf` schemas.

Edit files here; `task dart:generate` copies them back into
`lib/src/_generated/models/` after codegen runs, then re-runs
`build_runner build --delete-conflicting-outputs` so the `.freezed.dart` and
`.g.dart` companion files for the restored unions are regenerated.

Never edit the copy under `lib/src/_generated/` — it will be overwritten on
the next `task dart:generate` run.

Files currently maintained here:

- `models/annotation_kind.dart`
- `models/diff_line.dart`
- `models/node_content.dart`
- `models/ocr_bounding_geometry.dart`
- `models/revision_anchor.dart`
- `models/job_lookup_response.dart`
