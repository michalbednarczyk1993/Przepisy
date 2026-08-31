# Strukturalne składniki i skalowanie

Status: **zaakceptowany kierunek M2; szczegóły modelu i migracji wymagają ADR przed implementacją**.

## Cel

Użytkownik zapisuje składniki jako uporządkowane rekordy i skaluje przepis z liczby porcji bazowych do docelowych.

## Model roboczy

`RecipeIngredient` zawiera co najmniej:

- identyfikator przepisu,
- produkt lub tymczasową nazwę,
- ilość,
- jednostkę,
- opcjonalny wariant,
- opcjonalną notatkę,
- kolejność.

`Recipe` otrzymuje bazową liczbę porcji większą od zera.

## Reguła skalowania

```text
ilość docelowa = ilość bazowa × porcje docelowe / porcje bazowe
```

Przykład: 200 g mąki dla 4 porcji daje 300 g dla 6 porcji.

## Wymagania

- Składniki zachowują kolejność użytkownika.
- Ilość może reprezentować typowe ułamki kuchenne bez utraty precyzji przez binarny `double`.
- Prezentacja może zaokrąglać, ale przechowywana wartość nie może narastać od kolejnych zmian liczby porcji.
- Skalowanie zawsze wychodzi od wartości bazowej.
- Tekstowe składniki istniejących przepisów nie mogą zniknąć podczas migracji.
- Nieparsowalny wiersz pozostaje dostępny jako tekst do ręcznego uporządkowania.
- Jednostek nie konwertujemy automatycznie tylko dlatego, że liczba po skalowaniu jest duża; reguły prezentacji muszą być osobne.

## Scenariusz akceptacyjny

```gherkin
Scenario: Skalowanie przepisu bez zmiany danych bazowych
  Given przepis ma 4 porcje i 200 g mąki
  When użytkownik wybierze 6 porcji
  Then aplikacja pokazuje 300 g mąki
  And w bazie nadal zapisane jest 200 g jako ilość bazowa
```

## Otwarte decyzje

- typ liczbowy ilości i sposób zapisu ułamków,
- strategia migracji tekstu do rekordów,
- czy od M3 składnik bez dopasowanego produktu pozostaje wspieranym stanem docelowym, czy tylko przejściowym stanem migracji; w M2 zapis bez produktu jest dozwolony,
- zasady zaokrąglania i formatowania.
