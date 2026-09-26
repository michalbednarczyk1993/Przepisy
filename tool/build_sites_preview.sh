#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${repo_root}"

flutter build web --release

rm -rf "${repo_root}/dist"
mkdir -p "${repo_root}/dist"
cp -R "${repo_root}/build/web/." "${repo_root}/dist/"

test -f "${repo_root}/dist/index.html"
test -f "${repo_root}/dist/sqlite3.wasm"
test -f "${repo_root}/dist/drift_worker.dart.js"
