#!/usr/bin/env bash
# Scaffolding script for new Jekyll posts
# Usage: ./tools/newpost.sh

set -euo pipefail

read -rp "Post title: " TITLE
read -rp "Categories (comma-separated, optional): " CATS
read -rp "Tags (comma-separated, optional): " TAGS

# slugify title (simple)
SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g' | sed -E 's/^-+|-+$//g')
DATE=$(date +%Y-%m-%d)
FNAME="${DATE}-${SLUG}.md"
OUT_DIR="_posts"

mkdir -p "$OUT_DIR"

cat >"$OUT_DIR/$FNAME" <<EOF
---
title: "$TITLE"
date: $(date -u +"%Y-%m-%d %H:%M:%S %z")
categories: [$(echo "$CATS" | sed -E "s/[[:space:]]*,[[:space:]]*/, /g")]
tags: [$(echo "$TAGS" | sed -E "s/[[:space:]]*,[[:space:]]*/, /g")]
---

Write your content here in Markdown.

EOF

echo "Created $OUT_DIR/$FNAME"
