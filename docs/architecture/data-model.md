# Model danych

## Model M1

```mermaid
erDiagram
    CATEGORY ||--o{ RECIPE : contains
    CATEGORY {
      int id PK
      string name UK
      datetime createdAt
    }
    RECIPE {
      int id PK
      int categoryId FK
      string title
      string imagePath
      string ingredients
      string instructions
      string notes
      datetime createdAt
      datetime updatedAt
    }
```

W MVP jeden przepis należy do jednej kategorii, a składniki są tekstem. Jest to świadome uproszczenie czasowe.

## Docelowy model koncepcyjny

Poniższy model wyznacza kierunek, ale nie jest jeszcze zatwierdzonym schematem Drift.

```mermaid
erDiagram
    RECIPE ||--o{ RECIPE_INGREDIENT : contains
    PRODUCT ||--o{ PRODUCT_VARIANT : offers
    PRODUCT o|--o{ RECIPE_INGREDIENT : optionally_matches
    PRODUCT_VARIANT o|--o{ RECIPE_INGREDIENT : overrides
    UNIT ||--o{ RECIPE_INGREDIENT : measures
    PRODUCT_VARIANT ||--o{ NUTRITION_VALUE : has
    NUTRIENT ||--o{ NUTRITION_VALUE : defines
    UNIT ||--o{ HOUSEHOLD_MEASURE : base_unit
    PRODUCT_VARIANT ||--o{ PACKAGE_DEFINITION : packaged_as
```

Planowane rekordy:

- `Recipe`,
- `RecipeIngredient`,
- `Product`,
- `ProductVariant`,
- `Unit`,
- `HouseholdMeasure` lub `UnitDefinition`,
- `PackageDefinition`,
- `Nutrient`,
- `NutritionProfile` / `NutritionValue`,
- metadane źródła danych.

W M2 `RecipeIngredient` może nie mieć jeszcze dopasowanego `Product`. Wtedy zachowuje wymaganą nazwę wpisaną przez użytkownika. Relacja z produktem staje się obowiązkowa tylko dla obliczeń, które rzeczywiście jej potrzebują; nie jest warunkiem zapisania przepisu.

## Wymagane własności modelu

- Ilości nie tracą precyzji przy skalowaniu.
- Historyczny przepis nie zmienia znaczenia po cichu po edycji ustawień lub katalogu.
- Usunięcie rekordu referencyjnego nie może uczynić przepisu nieczytelnym.
- Wartości odżywcze mają jawną ilość referencyjną i jednostkę.
- Każdy produkt z danych zewnętrznych przechowuje źródło i identyfikator pochodzenia.
- Brak wartości pozostaje `unknown`, nie `0`.

## Migracja składników tekstowych

Przejście M1 → M2 musi być bezstratne:

1. zachowujemy oryginalny tekst,
2. tworzymy rekordy tylko dla pozycji poprawnie rozpoznanych lub ręcznie zatwierdzonych,
3. nieparsowalne wiersze pozostają widoczne,
4. dopiero po potwierdzonej migracji można rozważyć usunięcie starego pola w późniejszej wersji.

## Otwarte decyzje blokujące schemat docelowy

Dyskusja i decyzje są prowadzone w powiązanych Issues. Wniosek, który zmienia architekturę, kończy się ADR przed implementacją schematu.

- [`Product` kontra `Food` i rola `ProductVariant` — #24](https://github.com/michalbednarczyk1993/Przepisy/issues/24),
- [snapshot wariantu kontra wpływ ustawień globalnych — #23](https://github.com/michalbednarczyk1993/Przepisy/issues/23),
- [reprezentacja ilości, ułamków i migracja składników — #22](https://github.com/michalbednarczyk1993/Przepisy/issues/22),
- [jednostki wymiarowe, miary, opakowania i konwersje zależne od produktu — #27](https://github.com/michalbednarczyk1993/Przepisy/issues/27),
- [wersjonowanie wbudowanego katalogu — #28](https://github.com/michalbednarczyk1993/Przepisy/issues/28),
- polityka usuwania i dezaktywacji rekordów użytych historycznie — część projektowania w [#22](https://github.com/michalbednarczyk1993/Przepisy/issues/22) i [#27](https://github.com/michalbednarczyk1993/Przepisy/issues/27).
