# Produkty, warianty, jednostki i ustawienia

Status: **zaakceptowany kierunek M3; semantyka domyślnych wartości i nazewnictwo domeny wymagają decyzji**.

## Cel

Użytkownik może opisać faktycznie użyty produkt i jednostkę, a aplikacja ma wystarczające dane do konwersji i późniejszych obliczeń żywieniowych.

## Rekordy w bazie

Jednostki, miary domowe, definicje opakowań, produkty i warianty nie są enumami zaszytymi w UI. Są rekordami danych z możliwością migracji i edycji zgodnie z uprawnieniami danego typu.

Przykładowe jednostki:

- g, kg, ml, l, szt.,
- szklanka, łyżka, łyżeczka,
- kostka, karton, opakowanie, puszka.

## Warianty

- Jajko kurze: S, M, L, XL.
- Mleko: 0,5%, 2%, 3,2%, bez laktozy.
- Wariant może wpływać na masę sztuki, gęstość i profil żywieniowy.
- Produkt lub rodzina produktów może mieć wariant domyślny.

## Miary i opakowania

- Użytkownik może zmienić globalną definicję miary, np. `szklanka = 220 ml`.
- Definicja opakowania może być zależna od produktu lub wariantu, np. kostka masła = 200 g.
- Brak definicji oznacza brak możliwości konwersji, a nie wartość zero ani zgadywanie.
- Konwersja objętość ↔ masa wymaga gęstości właściwej dla produktu lub wariantu.

## Dwa poziomy zmiany

### Lokalna

Dotyczy jednego składnika przepisu, np. zamiana jajka S na M. Nie zmienia ustawienia globalnego.

### Globalna

Zmienia domyślne ustawienie aplikacji, np. domyślny wariant jajka lub objętość szklanki. Wpływ na już istniejące przepisy musi zostać rozstrzygnięty przed implementacją, ponieważ dynamiczna zmiana mogłaby po cichu zmienić wcześniejsze obliczenia.

## Interfejsy domenowe

UI korzysta z kontraktów, a nie z algorytmów konwersji:

```dart
abstract interface class ProductCatalog {}
abstract interface class QuantityConverter {}
abstract interface class RecipeIngredientRepository {}
```

Ostateczne sygnatury powstaną w ADR i planie implementacyjnym.

## Scenariusz akceptacyjny

```gherkin
Scenario: Lokalna zmiana wariantu
  Given domyślnym wariantem jajka jest S
  And przepis używa 2 jajek
  When użytkownik wybierze wariant M tylko w tym przepisie
  Then przepis używa 2 jajek M
  And globalny wariant domyślny pozostaje S
```

## Otwarte decyzje

- czy istniejący przepis przechowuje rozstrzygnięty wariant, czy dynamicznie korzysta z globalnego domyślnego,
- granica między `Product`, `ProductVariant` i pojęciem `Food`,
- które rekordy systemowe użytkownik może edytować lub usuwać,
- zachowanie przepisów po usunięciu wariantu lub definicji jednostki.

