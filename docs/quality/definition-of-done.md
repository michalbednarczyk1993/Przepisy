# Definition of Done

Zadanie jest ukończone dopiero, gdy wszystkie właściwe punkty są spełnione.

## Produkt

- Kryteria akceptacji z Issue są spełnione.
- Nie dodano zachowań spoza zakresu.
- Stany puste, błędy i anulowanie są obsłużone.
- Polskie teksty UI są zrozumiałe i spójne.
- UAT został zaakceptowany, jeśli Issue tego wymaga.

## Kod i dane

- Kod jest sformatowany i przechodzi analizę statyczną.
- Testy automatyczne przechodzą.
- Bugfix ma test regresyjny.
- Zmiana schematu ma migrację i test migracji.
- Pliki generowane pochodzą z generatora i są aktualne.
- Nie pozostawiono placeholdera udającego działającą implementację.
- Nie ma nowego, nieopisanego długu technicznego.

## Architektura i bezpieczeństwo

- Zależności zachowują granice modułów.
- Zmiana architektury ma zaakceptowany ADR.
- Nie dodano sekretów, niepotrzebnej telemetrii ani niejawnej komunikacji sieciowej.
- Destrukcyjne operacje i utrata danych wymagają Manual Approval.

## Dokumentacja i proces

- Wymagania, architektura, ADR i roadmapa są zaktualizowane, jeżeli zmiana ich dotyczy.
- PR linkuje Issue i opisuje sposób weryfikacji.
- CI jest zielone.
- Niezależny Reviewer AI nie zgłasza blokujących uwag.
- Wymagane uwagi review są poprawione albo jawnie rozstrzygnięte.

Brak możliwości uruchomienia testu lub buildu nie oznacza `Done`. To jawny bloker albo zadanie przekazane do właściwego środowiska CI.

