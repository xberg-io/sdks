package xberg

import (
	"context"
	"fmt"
	"mime/multipart"
)

func (c *Client) prepareDocumentLineage(ctx context.Context, files []FileSource, opts *ExtractOptions) (map[string]string, error) {
	if opts == nil || opts.DocumentIDs == nil {
		return nil, nil
	}
	if len(opts.DocumentIDs) != len(files) {
		return nil, fmt.Errorf("xberg: DocumentIDs must contain exactly one entry per file (nil for no lineage)")
	}
	seen := make(map[string]string, len(files))
	fields := make(map[string]string, len(files))
	for i, file := range files {
		value := ""
		if opts.DocumentIDs[i] != nil {
			value = opts.DocumentIDs[i].String()
		}
		if prior, exists := seen[file.Name]; exists && prior != value {
			return nil, fmt.Errorf("xberg: conflicting document IDs for filename %q; use distinct filenames", file.Name)
		}
		seen[file.Name] = value
		if value != "" {
			fields[file.Name] = value
		}
	}
	if len(fields) > 0 {
		if err := c.requireTier(ctx, TargetEnterprise, "Extract document lineage"); err != nil {
			return nil, err
		}
	}
	return fields, nil
}

func writeDocumentLineage(writer *multipart.Writer, fields map[string]string) error {
	for filename, documentID := range fields {
		if err := writer.WriteField("document_id-"+filename, documentID); err != nil {
			return fmt.Errorf("xberg: writing document lineage: %w", err)
		}
	}
	return nil
}
