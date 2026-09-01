# Plan: prywatny Flutter Web preview w ChatGPT Sites

- Issue: `#31`
- Status: accepted
- Owner: AI

## Cel i poza zakresem

Celem jest skrócenie pętli testowej przez prywatny preview wspólnych przepływów aplikacji w przeglądarce. Poza zakresem są: publiczna aplikacja webowa, backend, logowanie, synchronizacja danych oraz zastąpienie UAT Android/iOS.

## Stan obecny

Repozytorium wymaga jeszcze odtworzenia kompletnego scaffoldingu i zielonego buildu w #10. Nie ma zweryfikowanego targetu Web, adaptera persistence dla przeglądarki ani konfiguracji ChatGPT Sites.

## Proponowane rozwiązanie

- utrzymać jeden projekt Flutter/Dart i współdzielone warstwy domeny, application oraz presentation,
- uruchomić Flutter Web jako testowy target,
- odseparować persistence, zdjęcia i uprawnienia interfejsami infrastruktury,
- użyć lokalnego persistence przeglądarki zgodnego z możliwościami Drift Web albo jawnego adaptera testowego,
- zbudowany statyczny output umieszczać w katalogu obsługiwanym przez ChatGPT Sites,
- pierwsze wdrożenie utrzymać prywatne.

## Zmiany danych i migracja

Preview nie przenosi danych między telefonem a przeglądarką. Dane webowe są lokalne dla konkretnej przeglądarki. Schemat powinien zachować semantykę modelu mobilnego, ale migracje i ograniczenia silnika webowego muszą mieć osobne testy. Nie wolno udawać synchronizacji przez ręczne kopiowanie danych.

## Kroki implementacji

1. W #10 odtworzyć target Web i potwierdzić minimalny build.
2. Zweryfikować kompatybilność aktualnych zależności, zwłaszcza Drift, wyboru zdjęć i ścieżek plików.
3. Wprowadzić adaptery platformowe bez logiki warunkowej w widgetach.
4. Uruchomić podstawowy przepływ MVP z lokalnym stanem przeglądarki.
5. Dodać możliwość wyczyszczenia danych testowych lub załadowania zestawu demonstracyjnego.
6. Dodać konfigurację Sites, zbudować artefakt statyczny i opublikować prywatny URL.
7. Dodać build Web do CI oraz smoke test krytycznego przepływu, gdy scaffold będzie stabilny.
8. Udokumentować URL, znane różnice i procedurę aktualizacji preview.

## Ryzyka i rollback

- Niekompatybilna zależność webowa: zachować interfejs i użyć minimalnego adaptera tylko dla preview.
- Rozjazd zachowania: oznaczać różnice w PR i nie przenosić wyniku webowego na UAT platformowe.
- Utrata stanu przeglądarki: używać danych demonstracyjnych; preview nie jest miejscem trwałego przechowywania.
- Niepożądane udostępnienie: zatrzymać wdrożenie jako prywatne; szerszy dostęp wymaga Manual Approval.
- Rollback: wycofać deployment lub ostatnią wersję Sites bez zmiany danych mobilnych.

## Testy i UAT

- powtarzalny `flutter build web`,
- testy domenowe i widgetowe uruchamiane dla wspólnego kodu,
- smoke test dodanie → odczyt → edycja → usunięcie w przeglądarce,
- test odświeżenia strony i jawnego resetu danych,
- oddzielny UAT Android/iOS pozostaje wymagany.

## Dokumentacja do aktualizacji

- README i roadmapa,
- ADR-0006 i przegląd architektury,
- strategia testów,
- instrukcja wdrożenia oraz lista różnic platformowych powstała w #31.
