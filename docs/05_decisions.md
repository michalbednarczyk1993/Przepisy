# Decision log

## 2026-06-29 — Aplikacja offline-first, bez backendu
Decyzja: Dane są lokalne na urządzeniu.
Kontekst: MVP ma być prywatne i szybkie do wdrożenia.
Konsekwencje: Brak synchronizacji między urządzeniami.

## 2026-06-29 — Flutter od początku na iOS i Android
Decyzja: Jeden kod UI dla dwóch platform.
Kontekst: Projekt ma od startu wspierać Android i iOS.
Konsekwencje: Unikamy rozwiązań webowych i platformowo specyficznych poza wymaganymi uprawnieniami.

## 2026-06-29 — SQLite/Drift jako lokalna baza
Decyzja: Trwałe dane są w SQLite przez Drift.
Kontekst: Model jest relacyjny i lokalny.
Konsekwencje: Potrzebne generowanie kodu Drift.

## 2026-06-29 — Jedno zdjęcie na przepis w MVP
Decyzja: `Recipe.imagePath` trzyma jedną ścieżkę.
Kontekst: MVP ma pozostać proste.
Konsekwencje: Galeria zdjęć trafia do backlogu.

## 2026-06-29 — Składniki jako tekst w MVP
Decyzja: Nie tworzymy encji Ingredient.
Kontekst: Szybkie wpisywanie jest ważniejsze niż strukturyzacja.
Konsekwencje: Brak automatycznych list zakupów w MVP.

## 2026-06-29 — Brak logowania w MVP
Decyzja: Aplikacja nie ma kont użytkowników.
Kontekst: Dane są prywatne i lokalne.
Konsekwencje: Brak autoryzacji i integracji chmurowej.
