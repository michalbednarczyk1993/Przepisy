# Roadmapa

Roadmapa opisuje kolejność produktu, nie zobowiązanie terminowe. Każdy kamień ma kryteria wyjścia; praca z następnego etapu nie powinna omijać nierozwiązanych blokerów poprzedniego.

## M0 — Fundament i odzyskanie zielonego buildu

Cel: repozytorium daje się odtworzyć od zera, a automatyczne bramki jakości mówią prawdę.

Zakres:

- kompletny scaffold Flutter dla Androida i iOS,
- spójne zależności i wygenerowany kod Drift,
- formatowanie, analiza, testy i build Android w CI,
- strategia testów bazy i migracji,
- szablony Issues/PR oraz ochrona `master`,
- jednoznaczny proces AI Development Process v1.

Wyjście: świeży checkout przechodzi udokumentowane komendy, CI jest zielone, a `master` nie przyjmuje bezpośrednich zmian.

## M1 — MVP 0.1.0

Cel: prywatna książka kucharska działa na Androidzie i iOS.

Zakres:

- CRUD przepisów,
- jedno zdjęcie,
- kategorie i zasady ich usuwania,
- lista, szczegóły, wyszukiwanie i filtrowanie,
- trwałość danych,
- obsługa pustych, błędnych i anulowanych stanów,
- UAT na realnym urządzeniu.

Wyjście: wszystkie kryteria z `docs/requirements/mvp.md` są spełnione i zaakceptowane w UAT.

## M2 — Strukturalne składniki i skalowanie 0.2.0

Cel: przepis ma policzalne składniki i można zmienić liczbę porcji.

Zakres:

- `RecipeIngredient`, ilość, jednostka, notatka i kolejność,
- domena `quantity`,
- migracja istniejących tekstowych składników bez utraty danych,
- edytor składników,
- skalowanie z porcji bazowych do docelowych,
- reguły zaokrąglania i prezentacji ułamków.

Wyjście: scenariusze z `docs/requirements/structured-ingredients.md` przechodzą automatycznie i w UAT.

## M3 — Produkty, warianty, jednostki i ustawienia 0.3.0

Cel: użytkownik wybiera rzeczywisty wariant produktu i własne miary domowe.

Zakres:

- `Product` i `ProductVariant`,
- jednostki, miary domowe i opakowania jako rekordy bazy,
- konwersje zależne od produktu lub wariantu,
- domyślne warianty i definicje miar w ustawieniach,
- lokalne nadpisanie wariantu w pojedynczym przepisie.

Wyjście: zmiana lokalna i globalna zachowują się zgodnie z zaakceptowaną semantyką i nie zmieniają danych po cichu.

## M4 — Wartości odżywcze i katalog offline 0.4.0

Cel: aplikacja oblicza makro i mikro dla przepisu na podstawie lokalnego katalogu.

Zakres:

- elastyczny model `Nutrient` i wartości produktu,
- kalkulator całego przepisu i porcji,
- ostrzeżenia o brakujących danych lub niemożliwych konwersjach,
- wyselekcjonowany katalog ok. 3–5 tys. produktów generycznych dla polskiego użytkownika,
- pochodzenie, wersja i informacje licencyjne danych.

Wyjście: podstawowe gotowanie i obliczenia działają offline, a pipeline danych jest powtarzalny i audytowalny.

## M5 — Produkty własne i sklepowe 0.5.0

Cel: katalog można uzupełnić bez pakowania całej zewnętrznej bazy do aplikacji.

Zakres:

- produkty tworzone przez użytkownika,
- wyszukiwanie produktu sklepowego w Open Food Facts,
- opcjonalne skanowanie EAN,
- zapis pobranego produktu lokalnie,
- jawne stany offline, brak wyniku i niepełne dane.

Wyjście: funkcje sieciowe są dodatkiem, a zapisane produkty pozostają dostępne offline.

## Później

- eksport i import kopii zapasowej,
- wiele zdjęć,
- tagi i ulubione,
- lista zakupów,
- import przepisu z URL lub OCR,
- synchronizacja — wyłącznie po osobnej decyzji produktowej i architektonicznej.

