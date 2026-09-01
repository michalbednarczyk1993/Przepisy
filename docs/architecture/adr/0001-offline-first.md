# ADR-0001: Offline-first bez backendu

- Status: Accepted
- Data: 2026-06-29
- Decydenci: właściciel produktu + AI Architect

## Kontekst

Aplikacja jest prywatną książką kucharską i ma działać niezależnie od połączenia z internetem. Backend, konto i synchronizacja zwiększają koszt oraz nie są potrzebne w MVP.

## Decyzja

Dane podstawowe są przechowywane lokalnie. Aplikacja nie ma backendu, hostingu ani logowania w M0–M4. Późniejsza integracja z katalogiem sieciowym jest opcjonalnym źródłem danych, nie warunkiem działania.

## Konsekwencje

- szybkie i niezawodne użycie offline,
- brak synchronizacji między urządzeniami,
- potrzebna przyszła funkcja kopii zapasowej,
- migracje i integralność lokalnej bazy są krytyczne.

