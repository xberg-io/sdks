import 'dart:convert';
import 'dart:io';
import 'package:test/test.dart';
import 'package:kreuzberg_cloud_sdk/kreuzberg_cloud_sdk.dart';

ExtractionResult _loadFixture(String name) {
  // spec/fixtures lives at the repo root; from packages/dart/ the path is ../../spec/fixtures/
  final file = File('../../spec/fixtures/$name');
  final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  return ExtractionResult.fromJson(json);
}

void main() {
  group('ExtractionResult wire shape', () {
    group('minimal payload', () {
      test('should_deserialize_content_and_mime_type', () {
        final result = _loadFixture('extraction_result_minimal.json');
        expect(result.content, 'Hello');
        expect(result.mimeType, 'text/plain');
      });

      test('should_deserialize_empty_tables_list', () {
        final result = _loadFixture('extraction_result_minimal.json');
        expect(result.tables, isEmpty);
      });

      test('should_have_non_null_metadata', () {
        final result = _loadFixture('extraction_result_minimal.json');
        expect(result.metadata, isNotNull);
        expect(result.metadata.format, isNull);
      });
    });

    group('PDF fixture', () {
      test('should_deserialize_content_and_mime_type', () {
        final result = _loadFixture('extraction_result_pdf.json');
        expect(result.mimeType, 'application/pdf');
        expect(result.content, contains('quarterly financial results'));
      });

      test('should_deserialize_quality_score', () {
        final result = _loadFixture('extraction_result_pdf.json');
        expect(result.qualityScore, closeTo(0.91, 0.001));
      });

      test('should_have_three_pages', () {
        final result = _loadFixture('extraction_result_pdf.json');
        expect(result.pages, isNotNull);
        expect(result.pages, hasLength(3));
        expect(result.pages!.first.pageNumber, 1);
      });

      test('table_cells_should_be_nested_string_array', () {
        final result = _loadFixture('extraction_result_pdf.json');
        expect(result.tables, hasLength(1));
        expect(result.tables.first.cells, [
          ['Header A', 'Header B'],
          ['Row 1A', 'Row 1B'],
        ]);
      });

      test('table_markdown_should_match_fixture', () {
        final result = _loadFixture('extraction_result_pdf.json');
        expect(
          result.tables.first.markdown,
          '| Header A | Header B |\n|----------|----------|\n| Row 1A   | Row 1B   |',
        );
        expect(result.tables.first.pageNumber, 1);
      });

      test('metadata_title_and_authors_should_match_fixture', () {
        final result = _loadFixture('extraction_result_pdf.json');
        expect(result.metadata.title, 'Q1 2024 Financial Report');
        expect(result.metadata.authors, ['Alice Müller', 'Bob Chen']);
      });

      test('format_discriminator_should_resolve_to_ocr_variant', () {
        final result = _loadFixture('extraction_result_pdf.json');
        expect(result.metadata.format, isNotNull);
        expect(result.metadata.format, isA<FormatMetadataOcr>());
      });

      test('ocr_variant_fields_should_match_fixture', () {
        final result = _loadFixture('extraction_result_pdf.json');
        final ocr = result.metadata.format! as FormatMetadataOcr;
        expect(ocr.language, 'eng');
        expect(ocr.outputFormat, 'markdown');
        expect(ocr.psm, 3);
        expect(ocr.tableCount, 1);
      });

      test('format_map_dispatch_should_reach_ocr_branch', () {
        final result = _loadFixture('extraction_result_pdf.json');
        final dispatched = result.metadata.format!.map(
          ocr: (ocr) => 'got-ocr:${ocr.language}',
          archive: (_) => 'archive',
          csv: (_) => 'csv',
          email: (_) => 'email',
          excel: (_) => 'excel',
          html: (_) => 'html',
          image: (_) => 'image',
          pptx: (_) => 'pptx',
          pst: (_) => 'pst',
          text: (_) => 'text',
          xml: (_) => 'xml',
        );
        expect(dispatched, 'got-ocr:eng');
      });
    });

    group('XLSX fixture with children', () {
      test('should_deserialize_content_and_mime_type', () {
        final result = _loadFixture(
          'extraction_result_xlsx_with_children.json',
        );
        expect(
          result.mimeType,
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        );
        expect(result.content, contains('Sheet1'));
      });

      test('should_have_three_tables', () {
        final result = _loadFixture(
          'extraction_result_xlsx_with_children.json',
        );
        expect(result.tables, hasLength(3));
      });

      test('first_table_cells_should_match_fixture', () {
        final result = _loadFixture(
          'extraction_result_xlsx_with_children.json',
        );
        expect(result.tables.first.cells, [
          ['Department', 'Budget', 'Actual'],
          ['Engineering', '50000', '48500'],
          ['Marketing', '30000', '31200'],
        ]);
      });

      test('metadata_title_should_match_fixture', () {
        final result = _loadFixture(
          'extraction_result_xlsx_with_children.json',
        );
        expect(result.metadata.title, 'Annual Budget 2024');
      });

      test('format_discriminator_should_resolve_to_excel_variant', () {
        final result = _loadFixture(
          'extraction_result_xlsx_with_children.json',
        );
        expect(result.metadata.format, isNotNull);
        expect(result.metadata.format, isA<FormatMetadataExcel>());
      });

      test('excel_variant_fields_should_match_fixture', () {
        final result = _loadFixture(
          'extraction_result_xlsx_with_children.json',
        );
        final excel = result.metadata.format! as FormatMetadataExcel;
        expect(excel.sheetCount, 3);
        expect(excel.sheetNames, ['Q1', 'Q2', 'Q3']);
      });

      test('format_map_dispatch_should_reach_excel_branch', () {
        final result = _loadFixture(
          'extraction_result_xlsx_with_children.json',
        );
        final dispatched = result.metadata.format!.map(
          excel: (excel) => 'got-excel:${excel.sheetCount}',
          archive: (_) => 'archive',
          csv: (_) => 'csv',
          email: (_) => 'email',
          html: (_) => 'html',
          image: (_) => 'image',
          ocr: (_) => 'ocr',
          pptx: (_) => 'pptx',
          pst: (_) => 'pst',
          text: (_) => 'text',
          xml: (_) => 'xml',
        );
        expect(dispatched, 'got-excel:3');
      });

      test('should_have_one_child_archive_entry', () {
        final result = _loadFixture(
          'extraction_result_xlsx_with_children.json',
        );
        expect(result.children, isNotNull);
        expect(result.children, hasLength(1));
      });

      test('child_path_and_mime_type_should_match_fixture', () {
        final result = _loadFixture(
          'extraction_result_xlsx_with_children.json',
        );
        final child = result.children!.first;
        expect(child.path, 'xl/embeddings/Doc1.docx');
        expect(
          child.mimeType,
          'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
        );
      });

      test('child_nested_extraction_result_should_deserialize', () {
        final result = _loadFixture(
          'extraction_result_xlsx_with_children.json',
        );
        final childResult = result.children!.first.result;
        expect(childResult.content, contains('methodology notes'));
        expect(childResult.metadata.title, 'Methodology Notes');
        expect(childResult.metadata.authors, ['Alice Müller']);
        expect(childResult.tables, isEmpty);
      });
    });

    group('DOCX fixture with revisions', () {
      test('should_deserialize_content_and_mime_type', () {
        final result = _loadFixture(
          'extraction_result_docx_with_revisions.json',
        );
        expect(
          result.mimeType,
          'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
        );
        expect(result.content, contains('project timeline'));
      });

      test('should_have_three_revisions', () {
        final result = _loadFixture(
          'extraction_result_docx_with_revisions.json',
        );
        expect(result.revisions, isNotNull);
        expect(result.revisions, hasLength(3));
      });

      test('first_revision_should_be_insertion', () {
        final result = _loadFixture(
          'extraction_result_docx_with_revisions.json',
        );
        final first = result.revisions!.first;
        expect(first.kind, RevisionKind.insertion);
        expect(first.revisionId, '42');
        expect(first.author, 'Alice');
        expect(first.timestamp, '2024-03-15T10:30:00Z');
      });

      test('second_revision_should_be_deletion', () {
        final result = _loadFixture(
          'extraction_result_docx_with_revisions.json',
        );
        final second = result.revisions![1];
        expect(second.kind, RevisionKind.deletion);
        expect(second.revisionId, '43');
        expect(second.author, 'Alice');
      });

      test('third_revision_should_be_comment', () {
        final result = _loadFixture(
          'extraction_result_docx_with_revisions.json',
        );
        final third = result.revisions![2];
        expect(third.kind, RevisionKind.comment);
        expect(third.revisionId, '44');
        expect(third.author, 'Bob');
        expect(third.timestamp, '2024-03-16T09:00:00Z');
      });

      test('revision_kind_enum_values_should_be_correct_type', () {
        expect(RevisionKind.insertion, isA<RevisionKind>());
        expect(RevisionKind.deletion, isA<RevisionKind>());
        expect(RevisionKind.comment, isA<RevisionKind>());
      });

      test('should_have_two_extracted_keywords', () {
        final result = _loadFixture(
          'extraction_result_docx_with_revisions.json',
        );
        expect(result.extractedKeywords, isNotNull);
        expect(result.extractedKeywords, hasLength(2));
      });

      test('keywords_should_have_yake_algorithm_and_scores', () {
        final result = _loadFixture(
          'extraction_result_docx_with_revisions.json',
        );
        final keywords = result.extractedKeywords!;
        for (final keyword in keywords) {
          expect(keyword.algorithm, KeywordAlgorithm.yake);
          expect(keyword.score, greaterThan(0.0));
        }
      });

      test('first_keyword_should_match_fixture', () {
        final result = _loadFixture(
          'extraction_result_docx_with_revisions.json',
        );
        final first = result.extractedKeywords!.first;
        expect(first.text, 'project timeline');
        expect(first.score, closeTo(0.42, 0.001));
        expect(first.algorithm, KeywordAlgorithm.yake);
        expect(first.positions, [4, 30]);
      });

      test('second_keyword_should_match_fixture', () {
        final result = _loadFixture(
          'extraction_result_docx_with_revisions.json',
        );
        final second = result.extractedKeywords![1];
        expect(second.text, 'delivery date');
        expect(second.score, closeTo(0.38, 0.001));
        expect(second.positions, [55, 68]);
      });

      test('keyword_algorithm_toString_should_contain_yake', () {
        final result = _loadFixture(
          'extraction_result_docx_with_revisions.json',
        );
        final first = result.extractedKeywords!.first;
        expect(first.algorithm.toString(), contains('yake'));
      });
    });

    group('URI fixture', () {
      test('should_deserialize_content_and_mime_type', () {
        final result = _loadFixture('extraction_result_with_uris.json');
        expect(result.mimeType, 'text/markdown');
        expect(result.content, contains('Research Notes'));
      });

      test('should_have_three_uris', () {
        final result = _loadFixture('extraction_result_with_uris.json');
        expect(result.uris, isNotNull);
        expect(result.uris, hasLength(3));
      });

      test('all_uris_should_have_non_empty_url', () {
        final result = _loadFixture('extraction_result_with_uris.json');
        for (final uri in result.uris!) {
          expect(uri.url, isNotEmpty);
        }
      });

      test('first_uri_should_be_hyperlink', () {
        final result = _loadFixture('extraction_result_with_uris.json');
        final first = result.uris!.first;
        expect(first.kind, UriKind.hyperlink);
        expect(first.url, 'https://docs.example.com');
        expect(first.label, 'official documentation');
        expect(first.page, 1);
      });

      test('second_uri_should_be_email', () {
        final result = _loadFixture('extraction_result_with_uris.json');
        final second = result.uris![1];
        expect(second.kind, UriKind.email);
        expect(second.url, 'mailto:support@example.com');
        expect(second.label, 'support@example.com');
        expect(second.page, 1);
      });

      test('third_uri_should_be_anchor', () {
        final result = _loadFixture('extraction_result_with_uris.json');
        final third = result.uris![2];
        expect(third.kind, UriKind.anchor);
        expect(third.url, '#fig-1');
        expect(third.label, 'Figure 1');
        expect(third.page, 1);
      });
    });

    group('round-trip deserialisation', () {
      for (final fixture in [
        'extraction_result_minimal.json',
        'extraction_result_pdf.json',
        'extraction_result_xlsx_with_children.json',
        'extraction_result_docx_with_revisions.json',
        'extraction_result_with_uris.json',
      ]) {
        test('should_deserialize_${fixture}_without_error', () {
          expect(() => _loadFixture(fixture), returnsNormally);
        });
      }
    });
  });
}
