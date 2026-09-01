# Przepisy

`Przepisy` to prywatna aplikacja mobilna do przechowywania i wygodnego używania przepisów kucharskich. Działa offline, przechowuje dane i zdjęcia lokalnie oraz od początku ma wspierać Androida i iOS. Prywatny Flutter Web publikowany przez ChatGPT Sites służy wyłącznie jako szybki preview testowy; nie zastępuje aplikacji mobilnych ani ich UAT.

## Stan projektu

Repozytorium zawiera pierwszy szkic Flutterowego MVP. Nie traktujemy go jeszcze jako działającej wersji: build nie został odtworzony w pełnym środowisku Flutter, plik generowany przez Drift jest placeholderem, a konfiguracje platform mobilnych wymagają uzupełnienia i weryfikacji.

Najbliższy cel to **M0 — wiarygodny, powtarzalny zielony build** wraz z prywatnym preview webowym opisanym w [#31](https://github.com/michalbednarczyk1993/Przepisy/issues/31). Dopiero po nim domykamy funkcjonalne MVP.

## Zakres MVP

- dodawanie, edycja i usuwanie przepisu,
- jedno lokalne zdjęcie przepisu,
- kategorie,
- lista i szczegóły przepisów,
- wyszukiwanie po nazwie,
- filtrowanie po kategorii,
- trwałe przechowywanie danych na urządzeniu.

Składniki pozostają tekstem w MVP. Strukturalne składniki, skalowanie porcji, produkty, warianty, jednostki i wartości odżywcze są zaplanowane w kolejnych kamieniach milowych.

## Dokumentacja — źródła prawdy

- [Wizja produktu](docs/product/vision.md)
- [Roadmapa](docs/product/roadmap.md)
- [Decyzje produktowe](docs/product/decisions.md)
- [Wymagania MVP](docs/requirements/mvp.md)
- [Architektura](ARCHITECTURE.md)
- [Model danych](docs/architecture/data-model.md)
- [Decyzje architektoniczne](docs/architecture/adr/README.md)
- [Proces pracy AI](docs/process/ai-development-process.md)
- [Definition of Done](docs/quality/definition-of-done.md)
- [Instrukcje dla agentów](AGENTS.md)

## Zasady pracy

1. Każda zmiana zaczyna się od GitHub Issue.
2. Jedno logiczne zadanie trafia do jednego PR-a.
3. Nie commitujemy bezpośrednio do `master`.
4. Zmiana architektury wymaga ADR i akceptacji właściciela produktu.
5. Nie obniżamy quality gates, żeby przepchnąć zmianę.
6. Funkcjonalność wymagająca UAT nie jest ukończona przed akceptacją właściciela produktu.

Szczegółowy przebieg opisuje [AI Development Process](docs/process/ai-development-process.md).
