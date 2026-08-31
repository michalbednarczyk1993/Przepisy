# Architektura

Ten plik jest krótką mapą architektury. Szczegóły znajdują się w [opisie architektury](docs/architecture/overview.md), [modelu danych](docs/architecture/data-model.md) i [ADR](docs/architecture/adr/README.md).

## Zasady nadrzędne

- aplikacja mobilna Flutter dla Androida i iOS,
- offline-first, bez backendu i logowania w obecnym zakresie,
- SQLite/Drift jako trwałe lokalne źródło danych,
- Riverpod do składania zależności i stanu,
- `go_router` do nawigacji,
- lokalny system plików do zdjęć,
- logika domenowa poza widgetami,
- migracje schematu zamiast destrukcyjnego odtwarzania bazy.

## Stan obecny i kierunek

MVP ma dwa feature'y: `recipes` i `categories`. Po MVP składniki staną się strukturalne, a logika zostanie podzielona na moduły `product`, `quantity` i — zgodnie z dotychczasową decyzją roboczą — `pricing`, który odpowiada za wartości odżywcze, a nie ceny.

Nazwa `pricing` oraz dokładny model `Product` / `ProductVariant` / `Food` wymagają osobnych decyzji przed implementacją tych etapów.

## Granica MVP

W MVP `Recipe.ingredients` jest tekstem. Nie wolno przedwcześnie wprowadzać katalogu produktów, wariantów, jednostek lub kalkulatora wartości odżywczych do zadań M0/M1.

