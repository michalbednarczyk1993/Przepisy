# Wymagania MVP 0.1.0

Status: **zaakceptowany zakres produktu; implementacja wymaga ponownej weryfikacji po M0**.

## Cel

Użytkownik przechowuje własne przepisy lokalnie na telefonie i znajduje je bez połączenia z internetem.

## Przepis

Rekord MVP zawiera:

- wymagany tytuł,
- jedną kategorię,
- opcjonalną lokalną ścieżkę zdjęcia,
- składniki jako tekst wieloliniowy,
- przygotowanie jako tekst wieloliniowy,
- opcjonalne notatki,
- daty utworzenia i aktualizacji.

## Kategorie

- Użytkownik widzi listę kategorii i może dodać kategorię.
- Nazwa po usunięciu zewnętrznych spacji nie może być pusta.
- Unikalność nazwy nie zależy od wielkości liter.
- Kategorii przypisanej do przepisu nie można usunąć.
- Kategorie startowe: Śniadanie, Obiad, Kolacja, Deser, Przekąski, Azjatyckie i Do zrobienia.
- Kategoria przepisu jest wymagana.
- Formularz domyślnie wybiera `Do zrobienia`, jeżeli istnieje; w przeciwnym razie wybiera pierwszą dostępną kategorię.
- Jeżeli nie istnieje żadna kategoria, zapis przepisu jest zablokowany, a formularz kieruje użytkownika do utworzenia kategorii.
- Kategorię `Do zrobienia` można usunąć, jeżeli nie jest używana; nie jest specjalnym, nieusuwalnym rekordem systemowym.

## Widoki

### Lista przepisów

- tytuł `Moje przepisy`,
- wyszukiwarka po tytule,
- poziome filtry kategorii wraz z `Wszystkie`,
- karta ze zdjęciem lub placeholderem, tytułem i kategorią,
- przycisk dodawania dostępny jedną ręką,
- pusty stan dla braku przepisów i braku wyników.

### Szczegóły przepisu

- zdjęcie lub placeholder,
- tytuł i kategoria,
- składniki, przygotowanie i opcjonalne notatki,
- akcje edycji i usunięcia,
- potwierdzenie przed usunięciem.

### Dodawanie i edycja

- wspólny formularz z różnymi nagłówkami i etykietą zapisu,
- tytuł jest wymagany,
- składniki i przygotowanie mogą być puste,
- można wybrać zdjęcie z galerii; aparat jest opcjonalny w MVP,
- anulowanie wyboru zdjęcia nie zmienia formularza,
- edycja pokazuje istniejące dane i zdjęcie.

### Kategorie

- lista kategorii,
- dodawanie przez dialog,
- jasny komunikat przy próbie usunięcia kategorii używanej przez przepisy.

## Zdjęcia

- Po wyborze plik jest kopiowany do katalogu aplikacji.
- Baza przechowuje ścieżkę, nie dane binarne.
- Brak uprawnień, anulowanie i brak pliku nie mogą powodować awarii.
- Docelowo usunięcie lub zastąpienie zdjęcia usuwa nieużywany plik. Jeżeli nie wejdzie do MVP, jest jawnym długiem technicznym z Issue.

## Nawigacja

- `/recipes` — lista,
- `/recipes/new` — dodawanie,
- `/recipes/:id` — szczegóły,
- `/recipes/:id/edit` — edycja,
- `/categories` — kategorie.

Dolna nawigacja zawiera `Przepisy` i `Kategorie`. Formularze i szczegóły nie tworzą osobnych zakładek.

## Wymagania niefunkcjonalne

- Android i iOS od pierwszego wydania.
- Brak backendu, logowania i synchronizacji. Prywatny hosting testowego preview Flutter Web jest wyjątkiem opisanym w ADR-0006.
- Pełny podstawowy przepływ działa w trybie samolotowym.
- Dane pozostają po zamknięciu i ponownym uruchomieniu aplikacji.
- UI jest po polsku, opiera się na Material 3 i zachowuje czytelność przy systemowym skalowaniu tekstu.
- Błędy zapisu i odczytu są komunikowane bez utraty wprowadzonego formularza.

## Krytyczne scenariusze akceptacyjne

```gherkin
Scenario: Zapis i ponowne otwarcie przepisu
  Given użytkownik uruchomił aplikację bez internetu
  When doda przepis z tytułem, kategorią, składnikami i zdjęciem
  And zamknie i ponownie uruchomi aplikację
  Then przepis jest widoczny na liście
  And szczegóły oraz zdjęcie są dostępne
```

```gherkin
Scenario: Wyszukiwanie i filtrowanie
  Given istnieją przepisy w kilku kategoriach
  When użytkownik wybierze kategorię i wpisze fragment tytułu
  Then lista zawiera tylko przepisy spełniające oba filtry
```

```gherkin
Scenario: Ochrona używanej kategorii
  Given kategoria ma przypisany przepis
  When użytkownik spróbuje ją usunąć
  Then kategoria pozostaje w bazie
  And aplikacja wyświetla wyjaśnienie
```

## Poza zakresem MVP

Strukturalne składniki, skalowanie porcji, wartości odżywcze, katalog produktów, wiele zdjęć, eksport, import URL, OCR, lista zakupów, konta, synchronizacja, backend oraz publiczna lub pełnoprawnie wspierana wersja webowa. Prywatny preview testowy jest częścią M0/M1, a nie funkcją produktu.
