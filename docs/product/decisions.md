# Rejestr decyzji produktowych

Ten rejestr zapisuje wiążące decyzje o zakresie i zachowaniu produktu. Zmiana techniczna trafia do ADR. Zmiana wcześniejszej decyzji nie usuwa historii — dodaje nowy wpis i wskazuje, co zastępuje.

## 2026-06-29 — Prywatna aplikacja offline bez konta

- Status: Accepted
- Decyzja: pierwsze wydania działają lokalnie, bez backendu, logowania, hostingu i synchronizacji.
- Konsekwencja: podstawowy przepływ nie może wymagać internetu; kopia zapasowa pozostaje przyszłym zakresem.

## 2026-06-29 — Android i iOS od początku

- Status: Accepted
- Decyzja: oba systemy są wspierane od pierwszego wydania MVP.
- Konsekwencja: UAT wydania obejmuje obie platformy, nawet jeżeli codzienny CI buduje Androida częściej.

## 2026-06-29 — Jedno zdjęcie na przepis w MVP

- Status: Accepted
- Decyzja: MVP przechowuje maksymalnie jedno zdjęcie przepisu.
- Konsekwencja: galeria wielu zdjęć jest poza M1; cykl życia pojedynczego pliku nadal musi być bezpieczny.

## 2026-06-29 — Składniki jako tekst w MVP

- Status: Accepted
- Decyzja: M1 przechowuje składniki jako tekst wieloliniowy.
- Konsekwencja: strukturalne składniki i skalowanie zaczynają się w M2 oraz wymagają bezstratnej migracji.

## 2026-07-07 — Stopniowy rozwój katalogu produktów

- Status: Accepted
- Decyzja: najpierw powstaje strukturalny model i lokalny katalog generyczny; produkty sklepowe z Open Food Facts są pobierane na żądanie w późniejszym etapie.
- Konsekwencja: cała baza Open Food Facts nie trafia do paczki aplikacji, a podstawowe gotowanie pozostaje offline.

## 2026-09-01 — Prywatny preview webowy od M0

- Status: Accepted
- Decyzja: ten sam projekt Flutter udostępnia prywatny target Web publikowany przez ChatGPT Sites do szybkich testów właściciela produktu.
- Konsekwencja: decyzja zastępuje wyłącznie część wcześniejszego zapisu „bez hostingu”. Nie dodajemy backendu, konta ani synchronizacji; Android i iOS pozostają platformami produktu i podstawą UAT. Szczegóły: [ADR-0006](../architecture/adr/0006-private-flutter-web-preview-in-chatgpt-sites.md) oraz [#31](https://github.com/michalbednarczyk1993/Przepisy/issues/31).

## Otwarte decyzje

- [#23 — wpływ globalnych ustawień na istniejące przepisy](https://github.com/michalbednarczyk1993/Przepisy/issues/23)
- [#24 — pojęcia Product, ProductVariant i Food](https://github.com/michalbednarczyk1993/Przepisy/issues/24)
- [#25 — nazwa modułu pricing lub nutrition](https://github.com/michalbednarczyk1993/Przepisy/issues/25)

