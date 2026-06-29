# Architecture

## Stos
Flutter, Dart, Material 3, Drift/SQLite, flutter_riverpod, go_router, image_picker i path_provider.

## Warstwy
- `persistence/` definiuje bazę Drift i tabele.
- `features/*/data/` zawiera repozytoria izolujące dostęp do danych.
- `features/*/domain/` zawiera proste modele i funkcje domenowe możliwe do testowania.
- `features/*/presentation/` zawiera ekrany i widgety.
- `core/` zawiera routing, motyw i wspólne widgety.
- `services/` zawiera zapis zdjęć.

## Dane
Dane są przechowywane lokalnie w SQLite przez Drift. Kategorie startowe są seedowane przy tworzeniu bazy.

## Zdjęcia
Zdjęcia wybrane przez `image_picker` są kopiowane do `recipe_images` w katalogu dokumentów aplikacji z nazwą `recipe_<timestamp>.<ext>`. W bazie zapisywana jest tylko ścieżka.

TODO: przy zmianie zdjęcia usuwać stary plik. TODO: przy usunięciu przepisu usuwać powiązane zdjęcie.

## Zasady rozwoju
Nowe funkcje dodajemy w istniejących feature'ach lub jako nowy feature. Logika biznesowa powinna trafiać do repozytoriów, serwisów albo domeny, a widgety mają głównie prezentować stan.
