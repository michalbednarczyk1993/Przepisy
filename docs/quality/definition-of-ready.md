# Definition of Ready

Issue jest `READY FOR AI`, gdy:

- ma jeden jasno opisany rezultat,
- wskazuje użytkownika i problem albo techniczny powód zmiany,
- zawiera testowalne kryteria akceptacji,
- określa, co jest poza zakresem,
- wskazuje zależności i blokery,
- linkuje wymagania, ADR lub plan, których dotyczy,
- ma przypisaną klasę zmiany: AI autonomous, Product, Architecture lub Manual Approval,
- opisuje wymagane testy i ręczną weryfikację,
- nie zawiera nierozstrzygniętej decyzji potrzebnej do rozpoczęcia pracy.

Jeżeli analiza odkryje brak decyzji, Issue wraca do `AWAITING HUMAN DECISION` zamiast przechodzić do implementacji.

