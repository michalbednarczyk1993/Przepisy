# ADR-0002: Flutter i lokalny stack

- Status: Accepted
- Data: 2026-06-29
- Decydenci: właściciel produktu + AI Architect

## Kontekst

Android i iOS mają być obsługiwane od początku jednym kodem aplikacji.

## Decyzja

Używamy Fluttera i Darta, Material 3, Drift/SQLite, Riverpod, `go_router`, `image_picker` oraz `path_provider`. Zdjęcia zapisujemy jako pliki w katalogu aplikacji.

## Konsekwencje

- jeden projekt aplikacji dla dwóch platform,
- wymagane generowanie kodu Drift,
- build iOS wymaga środowiska macOS,
- konfiguracje uprawnień i cykl życia plików trzeba testować osobno na obu platformach.

