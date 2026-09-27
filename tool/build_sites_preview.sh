#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${repo_root}"

flutter build web --release --no-web-resources-cdn

rm -rf "${repo_root}/dist"
mkdir -p "${repo_root}/dist"
cp -R "${repo_root}/build/web/." "${repo_root}/dist/"

# The pinned dart2js build selects CanvasKit. Remove debug symbols and renderer
# variants that cannot be selected by this build so the Sites archive stays
# within its upload limit.
find "${repo_root}/dist/canvaskit" -type f \
  \( -name '*.symbols' -o -name 'skwasm*' -o -name 'wimp*' \) -delete

test -f "${repo_root}/dist/index.html"
test -f "${repo_root}/dist/sqlite3.wasm"
test -f "${repo_root}/dist/drift_worker.dart.js"
test -f "${repo_root}/dist/canvaskit/canvaskit.wasm"
