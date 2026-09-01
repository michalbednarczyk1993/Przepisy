# Bezpieczeństwo i prywatność

## Model zagrożeń dla obecnego zakresu

Aplikacja przechowuje prywatne treści i zdjęcia lokalnie. Nie ma uwierzytelnienia ani backendu. Najważniejsze ryzyka to utrata lub uszkodzenie danych, niejawna transmisja, niepotrzebne uprawnienia, podatne zależności i błędny cykl życia plików.

## Zasady

- Nie dodajemy sekretów do repozytorium ani aplikacji klienckiej.
- Nie dodajemy analityki, crash reportingu ani telemetrii bez Product i Manual Approval.
- Uprawnienia aparatu i galerii są minimalne, opisane i testowane na obu platformach.
- Dane przepisu i lokalne ścieżki nie trafiają do logów produkcyjnych.
- Integracja sieciowa ma jawny cel, timeout, obsługę offline i opis prywatności.
- Dane z zewnętrznego katalogu są traktowane jako niezaufane wejście.
- Aktualizacje zależności przechodzą testy oraz automatyczny skan znanych podatności.
- Operacja usunięcia danych wymaga potwierdzenia i nie może usuwać rekordów poza swoim zakresem.
- Migracje są testowane na kopii danych ze starszej wersji.

## Przed M5

Przed włączeniem skanowania EAN lub Open Food Facts należy dopisać analizę przepływu danych, wymaganych uprawnień, informacji przekazywanych do API i zachowania przy braku sieci.

## Zgłaszanie problemów

Do czasu skonfigurowania prywatnego kanału nie umieszczamy w publicznym Issue sekretów, prywatnych danych użytkownika ani pełnych treści lokalnej bazy. Issue może opisywać reprodukcję na danych testowych.

