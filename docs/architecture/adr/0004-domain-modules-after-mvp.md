# ADR-0004: Moduły domenowe po MVP

- Status: Accepted
- Data: 2026-07-07
- Decydenci: właściciel produktu + AI Architect

## Kontekst

Skalowanie, konwersje i wartości odżywcze nie powinny trafić do widgetów ani jednego ogólnego serwisu. Inspiracją jest podział archetypowy, ale nie kopiowanie kodu z zewnętrznego projektu.

## Decyzja

Po MVP wydzielamy moduły:

- `product` — produkty i warianty,
- `quantity` — ilości, jednostki, miary, opakowania i konwersje,
- `pricing` — roboczo kalkulacje wartości odżywczych i ostrzeżenia o brakach.

Moduły publikują interfejsy, z których korzystają use case'y i UI.

## Konsekwencje

- domena może rosnąć bez rozlewania logiki po widgetach,
- granice encji i nazwa `pricing` wymagają doprecyzowania przed implementacją,
- nie wprowadzamy tych modułów do MVP tylko „na zapas”.

