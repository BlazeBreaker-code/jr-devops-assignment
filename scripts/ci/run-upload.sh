#!/usr/bin/env bash
set -euo pipefail

build_platform="${1:?build platform required}"
upload_platform="${2:?upload platform required}"

find "cli/build/${build_platform}" -type f | while read -r file; do
  cli/upload.sh "$upload_platform" "$file"
done
