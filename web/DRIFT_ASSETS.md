# Drift Web assets

The checked-in runtime files are required for offline-capable SQLite in the
Flutter Web build:

| File | Upstream release | SHA-256 |
| --- | --- | --- |
| `sqlite3.wasm` | `simolus3/sqlite3.dart`, `sqlite3-2.9.4` | `922a76b182b6af69b030c8e2fdd3283ecc8e827248b20e4b1f3f3db170b52117` |
| `drift_worker.dart.js` | `simolus3/drift`, `drift-2.31.0` (`drift_worker.js`) | `f0a9b87085f732fd7b6ee7eb34d3858c556f05d221eb1febfc443649cd365752` |

When Drift or `sqlite3` changes in `pubspec.lock`, download matching release
assets, update this table, run the full Web build and repeat the browser smoke
test before merging.
