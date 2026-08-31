# ADR-0003: Tekstowe składniki w MVP

- Status: Accepted
- Data: 2026-06-29
- Decydenci: właściciel produktu + AI Architect

## Kontekst

Pierwsza wersja ma szybko dostarczyć użyteczny CRUD przepisów. Pełny model produktów i jednostek znacząco rozszerza zakres.

## Decyzja

W M1 składniki są przechowywane jako tekst wieloliniowy. Strukturalny `RecipeIngredient` pojawia się w M2 wraz z migracją bez utraty danych.

## Konsekwencje

- prostszy formularz i mniejszy zakres MVP,
- brak skalowania oraz kalkulacji w M1,
- migracja musi zachować oryginalny tekst,
- kod M1 nie może utrudniać późniejszego rozdzielenia modelu.

