# Data model

## Recipe
- `id` — klucz główny.
- `title` — wymagany tytuł.
- `categoryId` — wymagana relacja do kategorii.
- `imagePath` — opcjonalna lokalna ścieżka zdjęcia.
- `ingredients` — tekst wieloliniowy.
- `instructions` — tekst wieloliniowy.
- `notes` — opcjonalne prywatne notatki.
- `createdAt`, `updatedAt` — daty audytowe.

## Category
- `id` — klucz główny.
- `name` — wymagana, unikalna nazwa.
- `createdAt` — data utworzenia.

## Relacje
Jeden przepis należy do jednej kategorii. Jedna kategoria może mieć wiele przepisów.

## Decyzja o składnikach
Składniki pozostają tekstem w MVP, żeby dodawanie przepisu było szybkie i proste.

## Przyszłe rozszerzenia
Osobne encje składników, tagi, czasy przygotowania, porcje, wiele zdjęć i eksport/import danych.
