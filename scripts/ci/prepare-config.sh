#!/usr/bin/env bash 
set -euo pipefail

platform="$INPUT_PLATFORM"
upload_requested="$INPUT_UPLOAD"
environment="$INPUT_ENVIRONMENT"
branch="$GITHUB_REF_NAME"

if [ -n "$INPUT_VERSION" ]; then 
  version="$INPUT_VERSION"
  else
    version="$(date +'%Y.%m.%d').${GITHUB_RUN_NUMBER}"
  fi

case "$platform" in
  Android)
    matrix='{"include":[{"buildPlatform":"Android","uploadPlatform":"android"}]}'
    ;;
  iOS)
    matrix='{"include":[{"buildPlatform":"iOS","uploadPlatform":"ios"}]}'
    ;;
  Both)
    matrix='{"include":[{"buildPlatform":"Android","uploadPlatform":"android"},{"buildPlatform":"iOS","uploadPlatform":"ios"}]}'
    ;;
  *)
    echo "Unsupported platform: $platform" >&2
    exit 1
    ;;
esac

should_upload="false"
if [ "$upload_requested" = "true" ] && [ "$environment" = "Production" ] && [ "$branch" = "production" ]; then
  should_upload="true"
fi

echo "matrix=$matrix" >> "$GITHUB_OUTPUT"
echo "version=$version" >> "$GITHUB_OUTPUT"
echo "should_upload=$should_upload" >> "$GITHUB_OUTPUT"
echo "environment=$environment" >> "$GITHUB_OUTPUT"
    