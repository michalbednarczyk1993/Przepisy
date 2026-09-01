# ADR-0006: Prywatny Flutter Web preview w ChatGPT Sites

- Status: Accepted
- Data: 2026-09-01
- Decydenci: właściciel produktu + AI Architect
- Powiązane: #31, PR #3

## Kontekst

Właściciel produktu chce od początku szybko sprawdzać aplikację bez instalowania kolejnego buildu na telefonie. Produkt pozostaje prywatną aplikacją mobilną offline dla Androida i iOS. Potrzebujemy powierzchni testowej dostępnej w przeglądarce, ale nie chcemy tworzyć drugiej implementacji ani niejawnie dodawać backendu.

## Rozważane opcje

1. Tylko buildy Android/iOS — najmniej pracy, ale wolna pętla informacji zwrotnej.
2. Osobny prototyp webowy w innym frameworku — szybki wizualnie, ale dubluje kod i łatwo rozjeżdża się z aplikacją.
3. Flutter Web z tego samego projektu, publikowany prywatnie przez ChatGPT Sites — współdzieli UI i logikę, a różnice platformowe pozostają za adapterami.

## Decyzja

Wybieramy opcję 3. Od M0 utrzymujemy testowy target Flutter Web i prywatny preview w ChatGPT Sites. Jest to środowisko przeglądu i smoke testów, nie trzecia wspierana platforma produktu.

- kod domenowy, application i większość presentation pozostają wspólne,
- persistence webowe przechowuje dane lokalnie w przeglądarce i nie synchronizuje ich z telefonem,
- zdjęcia, uprawnienia i system plików mogą mieć adapter lub jawne ograniczenie webowe,
- publikacja zaczyna jako prywatna; zmiana dostępu wymaga Manual Approval,
- Android i iOS pozostają obowiązkowymi platformami UAT i wydania.

## Konsekwencje

- M0 obejmuje odtworzenie targetu Web, powtarzalny build i konfigurację Sites.
- CI powinno wykrywać regresje builda webowego.
- Preview przyspiesza ocenę układu i wspólnych przepływów, ale nie dowodzi poprawności zachowań platformowych.
- Stan przeglądarki może być krótkotrwały; preview musi mieć prosty sposób wyczyszczenia danych lub załadowania danych demonstracyjnych.
- Nie dodajemy backendu, konta, zdalnej bazy ani synchronizacji.

## Powiązane Issues

- [#31 — prywatny preview Flutter Web w ChatGPT Sites](https://github.com/michalbednarczyk1993/Przepisy/issues/31)
- [#10 — kompletny scaffold i powtarzalny build](https://github.com/michalbednarczyk1993/Przepisy/issues/10)
- [#14 — quality gates Flutter](https://github.com/michalbednarczyk1993/Przepisy/issues/14)
