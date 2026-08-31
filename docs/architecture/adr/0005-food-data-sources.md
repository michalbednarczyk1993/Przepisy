# ADR-0005: Źródła danych żywieniowych

- Status: Accepted
- Data: 2026-07-07
- Decydenci: właściciel produktu + AI Architect

## Kontekst

Pełne bazy produktów są zbyt duże i niedopasowane do podstawowego offline'owego użycia w Polsce. Jednocześnie aplikacja ma docelowo obsługiwać makro, mikro i konkretne produkty sklepowe.

## Decyzja

- Budujemy wyselekcjonowany lokalny katalog ok. 3–5 tys. produktów generycznych, głównie na podstawie USDA FoodData Central i opcjonalnych europejskich uzupełnień.
- Open Food Facts służy do pobierania konkretnych produktów na żądanie; nie dołączamy całej bazy.
- Produkty użytkownika są trzecim źródłem.
- Każdy rekord zachowuje metadane pochodzenia.

## Konsekwencje

- podstawowe wyszukiwanie i kalkulacje działają offline,
- potrzebny jest osobny pipeline selekcji, tłumaczenia, deduplikacji i wersjonowania,
- przed dystrybucją wymagany jest audyt warunków wykorzystania każdego źródła,
- szczegółowa strategia selekcji pozostaje zadaniem discovery.

## Powiązane Issues

- [#28 — opracować pipeline polskiego katalogu 3–5 tys. produktów](https://github.com/michalbednarczyk1993/Przepisy/issues/28)
