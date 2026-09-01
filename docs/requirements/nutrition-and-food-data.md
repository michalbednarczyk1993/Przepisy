# Wartości odżywcze i dane produktów

Status: **zaakceptowany kierunek M4/M5; pipeline selekcji danych pozostaje discovery**.

## Cel

Aplikacja oblicza makro- i mikroskładniki całego przepisu i jednej porcji, działa przy tym offline i jawnie pokazuje braki danych.

## Źródła danych

- USDA FoodData Central — podstawowe źródło danych dla produktów generycznych.
- Inne europejskie źródła, np. CIQUAL — uzupełnienie, gdy lepiej opisują produkt używany w Polsce.
- Open Food Facts — źródło konkretnych produktów sklepowych pobieranych na żądanie, nie cała baza w paczce aplikacji.
- Dane użytkownika — lokalne produkty własne.

Przed dystrybucją danych pipeline musi zapisać źródło, identyfikator rekordu, wersję importu i wymagane informacje licencyjne. Każde źródło wymaga osobnej weryfikacji warunków użycia.

## Katalog offline

- Orientacyjny cel: 3–5 tys. wyselekcjonowanych produktów generycznych.
- Katalog jest dostosowany do polskiego gotowania: polskie nazwy, typowe warianty, sensowne synonimy i jednostki.
- Nie kopiujemy automatycznie pierwszych kilku tysięcy rekordów USDA.
- Selekcja, tłumaczenie, deduplikacja i mapowanie są powtarzalnym pipeline'em, nie ręczną zmianą pliku w aplikacji.
- Rozmiar paczki i czas indeksowania są mierzone przed akceptacją.

## Typy pochodzenia produktu

- `GENERIC` — produkt generyczny wbudowany lub zaimportowany z zatwierdzonego źródła,
- `BRANDED` — konkretny produkt sklepowy, opcjonalnie z EAN,
- `USER` — produkt utworzony lokalnie przez użytkownika.

To pole opisuje pochodzenie pozycji. Nie rozstrzyga jeszcze, czy encja docelowo nazywa się `Food`, `Product` czy inaczej.

## Model składników odżywczych

Nie dodajemy kolumny do produktu dla każdego mikroelementu. Model pozostaje rozszerzalny:

- definicja `Nutrient`,
- profil produktu,
- wartość składnika odżywczego i jednostka,
- ilość referencyjna profilu, np. 100 g.

Widok podstawowy pokazuje energię, białko, tłuszcz, węglowodany i błonnik. Szczegóły mogą pokazać m.in. wapń, żelazo, magnez, potas, sód, cynk i witaminy A, C, D, E, K, B1, B2, B6, B12 oraz foliany. Model nie może być ograniczony do tej listy.

## Kalkulacja i komunikaty

- Wynik całego przepisu jest sumą policzalnych składników.
- Wynik porcji wynika z bazowej liczby porcji.
- Brak profilu, gęstości albo definicji opakowania jest widoczny w wyniku.
- Kalkulator nie zastępuje braków zerem i nie zgaduje.
- Wynik wskazuje, czy jest pełny czy częściowy.

Przykładowe komunikaty:

```text
Brak wartości odżywczych dla: ketchup
Nie można przeliczyć opakowania na gramy.
```

## Produkty sklepowe

- Funkcja sieciowa jest opcjonalna i jasno wskazuje brak połączenia.
- Pobrany produkt jest zapisywany lokalnie i później działa offline.
- Dane z Open Food Facts mogą być niepełne; użytkownik widzi źródło i braki.
- Skanowanie EAN wymaga osobnego zakresu uprawnień, prywatności i testów platformowych.

## Otwarte prace discovery

- kryteria wyboru 3–5 tys. produktów,
- tłumaczenia i synonimy,
- deduplikacja między źródłami,
- mapowanie jednostek i nutrient IDs,
- wersjonowanie i aktualizacja katalogu,
- audyt licencyjny oraz wymagane atrybucje,
- strategia indeksowania wyszukiwania lokalnego.

