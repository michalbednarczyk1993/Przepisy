# Słownik

| Pojęcie | Znaczenie robocze |
| --- | --- |
| Przepis (`Recipe`) | Instrukcja przygotowania potrawy wraz ze składnikami i bazową liczbą porcji. |
| Składnik przepisu (`RecipeIngredient`) | Użycie produktu w konkretnym przepisie: produkt, wariant, ilość, jednostka, notatka i kolejność. Pojawia się po MVP. |
| Produkt (`Product`) | Rodzina lub pozycja katalogowa używana w przepisie, np. mleko, jajko, mąka. Dokładna granica wobec `Food` wymaga ADR. |
| Wariant produktu (`ProductVariant`) | Odmiana wpływająca na konwersję lub odżywianie, np. jajko M albo mleko 3,2%. |
| Jednostka (`Unit`) | Sposób zapisu ilości, np. g, ml, szt. |
| Miara domowa (`HouseholdMeasure`) | Konfigurowalna miara, np. szklanka, łyżka lub łyżeczka. |
| Definicja opakowania (`PackageDefinition`) | Przelicznik opakowania konkretnego produktu lub wariantu na jednostkę bazową. |
| Profil żywieniowy (`NutritionProfile`) | Zestaw wartości składników odżywczych dla określonej ilości produktu, zwykle 100 g lub 100 ml. |
| Składnik odżywczy (`Nutrient`) | Definicja wartości, np. energia, białko, wapń albo witamina B12. |
| Zmiana lokalna | Nadpisanie dotyczące jednego składnika w jednym przepisie. |
| Zmiana globalna | Zmiana ustawienia domyślnego aplikacji dla nowych lub nieustalonych użyć; dokładna semantyka historycznych przepisów wymaga decyzji. |
| Produkt generyczny | Ogólna pozycja katalogowa, niezwiązana z marką. |
| Produkt sklepowy | Konkretny produkt marki, opcjonalnie identyfikowany kodem EAN. |
| Produkt użytkownika | Pozycja utworzona i utrzymywana lokalnie przez użytkownika. |
| UAT | Test akceptacyjny wykonywany przez właściciela produktu z perspektywy użytkownika. |

