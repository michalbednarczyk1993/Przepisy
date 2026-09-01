# ADR-0002: Flutter i lokalny stack

- Status: Accepted
- Data: 2026-06-29
- Decydenci: właściciel produktu + AI Architect

## Kontekst

Android i iOS mają być obsługiwane od początku jednym kodem aplikacji. Ten sam projekt ma także wystawiać testowy target Flutter Web, aby właściciel mógł szybko oceniać wspólne przepływy w przeglądarce.

## Decyzja

Używamy Fluttera i Darta, Material 3, Drift/SQLite, Riverpod, `go_router`, `image_picker` oraz `path_provider`. Zdjęcia zapisujemy jako pliki w katalogu aplikacji. Granice prywatnego preview Flutter Web i hostingu w ChatGPT Sites określa [ADR-0006](0006-private-flutter-web-preview-in-chatgpt-sites.md); rozszerza on tę decyzję bez zmiany mobilnych platform docelowych.

## Konsekwencje

- jeden projekt aplikacji dla dwóch platform,
- wymagane generowanie kodu Drift,
- build iOS wymaga środowiska macOS,
- konfiguracje uprawnień i cykl życia plików trzeba testować osobno na obu platformach,
- target webowy wymaga osobnego adaptera persistence i jawnego opisu różnic platformowych.

