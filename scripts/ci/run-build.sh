#!/usr/bin/env bash
set -euo pipefail

build_platform="${1:?build platform required}"
app_name="${2:?app name required}"
version="${3:?version required}"
enable_profiling="${4:?profiling flag required}"

cmd=(cli/build.sh --platform "$build_platform" --project-name "$app_name" --version "$version")

if [ "$enable_profiling" = "true" ]; then
  cmd+=(--profile)
fi

"${cmd[@]}"
