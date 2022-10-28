#!/usr/bin/env bash

set -euo pipefail

# ----- args and setup -----

src="${1:-}"
dest="${2:-}"

if command -v grealpath &> /dev/null; then
  realpath="grealpath"
elif command -v realpath &> /dev/null; then
  realpath="realpath"
else
  2>&1 echo "$0: This script requires GNU realpath. Install it with:"
  2>&1 echo "    brew install coreutils"
  exit 1
fi

dest_dir="$(dirname "$dest")"
mkdir -p "$dest_dir"

css_rel_path="$("$realpath" "dist/css/" --relative-to "$dest_dir")"

pandoc \
  --katex \
  --from markdown+tex_math_single_backslash \
  --filter pandoc-sidenote \
  --to html5+smart \
  --template=template \
  --css="$css_rel_path/theme.css" \
  --css="$css_rel_path/skylighting-solarized-theme.css" \
  --toc \
  --wrap=none \
  --output "$dest" \
  "$src"
