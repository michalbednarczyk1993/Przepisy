# Project instructions

## Misja

Buduj prostą i szybką aplikację użytkową, ale zachowuj wyraźnie wydzieloną domenę. Nie dodawaj funkcji spoza zaakceptowanej roadmapy i bieżącego Issue.

## Źródła prawdy

- produkt i priorytety: `docs/product/`,
- wymagania: `docs/requirements/`,
- architektura: `ARCHITECTURE.md`, `docs/architecture/` i zaakceptowane ADR,
- jakość: `docs/quality/`,
- plan bieżącej zmiany: GitHub Issue oraz, dla większej pracy, `docs/plans/active/`.

Jeżeli źródła są sprzeczne, nie zgaduj. Zatrzymaj implementację i utwórz Issue typu decyzja. Zaakceptowane ADR ma pierwszeństwo w sprawach technicznych, a zaakceptowane wymaganie — w zachowaniu produktu.

## Workflow

- Nigdy nie commituj bezpośrednio do `master`.
- Każda zmiana musi wskazywać GitHub Issue.
- Jedno logiczne zadanie = jedna gałąź = jeden PR.
- Nie łącz refaktoryzacji niezwiązanej z celem zadania.
- PR powinien być mały, odwracalny i możliwy do niezależnego review.
- Nie merguj własnego PR-a bez niezależnego review AI przeprowadzonego w świeżym kontekście i zielonego CI.
- Nie merguj zmian wymagających Product, Architecture lub Manual Approval bez jawnej decyzji właściciela.

## Klasy zmian

- **AI autonomous**: mały refactoring, testy, dokumentacja, drobny bugfix bez zmiany zachowania produktu.
- **Product approval**: nowa funkcja lub zmiana UX.
- **Architecture approval**: model domenowy, baza, framework, granice modułów lub sposób integracji.
- **Manual approval**: bezpieczeństwo, dane użytkownika, sekrety, infrastruktura produkcyjna, destrukcyjna migracja albo obniżenie quality gate.

## Reguły techniczne

- Flutter i Dart są jedynym stosem aplikacji. Testowy target Flutter Web i publikacja przez ChatGPT Sites podlegają ADR-0006; nie wolno tworzyć równoległej implementacji produktu w innym frameworku.
- Dane są lokalne w SQLite przez Drift; zdjęcia są plikami lokalnymi, a baza przechowuje ścieżki.
- UI nie może zawierać logiki przeliczania ilości, wariantów ani wartości odżywczych.
- Moduły domenowe komunikują się przez jawne interfejsy, np. `ProductCatalog`, `QuantityConverter`, `NutritionCalculator` i repozytoria.
- Każda zmiana schematu bazy wymaga migracji i testu migracji.
- Nie edytuj ręcznie plików generowanych. W szczególności `app_database.g.dart` musi powstać z generatora Drift.
- Każdy bugfix wymaga testu regresyjnego, chyba że Issue jawnie uzasadnia brak możliwości jego napisania.
- Aktualizuj dokumentację, gdy zmienia się produkt, model danych, architektura, UX albo proces.

## Weryfikacja przed PR

Uruchom, o ile środowisko obsługuje Flutter:

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
flutter build apk --debug
```

Build iOS uruchamiaj na macOS. Jeżeli środowisko nie pozwala wykonać wymaganego kroku, nie deklaruj sukcesu: zapisz brak w PR i pozostaw zadanie nieukończone albo skieruj je do właściwego joba CI.

## Zakaz obchodzenia jakości

Nie wolno wyłączać testów, linterów, skanów, reguł ochrony gałęzi ani obniżać progów jakości w celu uzyskania zielonego CI. Taka zmiana zawsze wymaga osobnego Issue i Manual Approval.

## Definition of Done

Stosuj `docs/quality/definition-of-done.md`. Skrót:

- kryteria akceptacji są spełnione,
- testy i analiza statyczna przechodzą,
- migracje i pliki generowane są poprawne,
- dokumentacja jest aktualna,
- niezależne review nie ma blokujących uwag,
- UAT jest zaakceptowany, jeśli dotyczy.

