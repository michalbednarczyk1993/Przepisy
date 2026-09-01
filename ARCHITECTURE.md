# Architektura

Ten plik jest krótką mapą architektury. Szczegóły znajdują się w [opisie architektury](docs/architecture/overview.md), [modelu danych](docs/architecture/data-model.md) i [ADR](docs/architecture/adr/README.md).

## Zasady nadrzędne

- aplikacja mobilna Flutter dla Androida i iOS,
- prywatny Flutter Web jako testowy preview w ChatGPT Sites, nie jako trzecia platforma produktu,
- offline-first, bez backendu, logowania i synchronizacji w obecnym zakresie,
- SQLite/Drift jako trwałe lokalne źródło danych,
- Riverpod do składania zależności i stanu,
- `go_router` do nawigacji,
- lokalny system plików do zdjęć,
- logika domenowa poza widgetami,
- migracje schematu zamiast destrukcyjnego odtwarzania bazy.

## Stan obecny i kierunek

MVP ma dwa feature'y: `recipes` i `categories`. Po MVP składniki staną się strukturalne, a logika zostanie podzielona na moduły `product`, `quantity` i — zgodnie z zaakceptowanym ADR-0004 — `pricing`, który odpowiada za wartości odżywcze, a nie ceny.

Do czasu zaakceptowania decyzji zastępującej obowiązuje nazwa `pricing`. Issue [#25](https://github.com/michalbednarczyk1993/Przepisy/issues/25) proponuje zmianę na `nutrition`; jego rozstrzygnięcie będzie wymagało nowego ADR. Dokładny model `Product` / `ProductVariant` / `Food` wymaga osobnej decyzji przed M3.

[ADR-0006](docs/architecture/adr/0006-private-flutter-web-preview-in-chatgpt-sites.md) określa granicę preview webowego. Współdzielimy kod i podstawowe przepływy, ale trwałość w przeglądarce, zdjęcia i uprawnienia są zależnościami platformowymi i nie mogą udawać weryfikacji mobilnej.

## Granica MVP

W MVP `Recipe.ingredients` jest tekstem. Nie wolno przedwcześnie wprowadzać katalogu produktów, wariantów, jednostek lub kalkulatora wartości odżywczych do zadań M0/M1.
