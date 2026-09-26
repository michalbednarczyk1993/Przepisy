# Prywatny preview Flutter Web

Preview służy do szybkiego sprawdzania wspólnego UI i przepływów MVP. Nie jest
platformą produktu i nie zastępuje testów ani UAT na Androidzie i iOS.

## Adres i dostęp

- docelowy adres: `https://przepisy-michal-preview.michal-bednarczyk199.chatgpt.site`,
- wdrożenie pozostaje prywatne,
- brak backendu, logowania i synchronizacji między urządzeniami.

## Dane lokalne

Drift otwiera SQLite w przeglądarce przez WebAssembly. W zależności od
możliwości przeglądarki dane są przechowywane w prywatnym systemie plików
origin albo IndexedDB. Dane nie są wysyłane do serwera aplikacji.

Ikona kolby na ekranie listy przepisów udostępnia dwie operacje testowe:

- **Wczytaj dane demo** — zastępuje bieżące dane dwoma przykładowymi przepisami,
- **Wyczyść dane** — usuwa przepisy i własne kategorie, po czym odtwarza
  kategorie startowe.

Obie operacje są dostępne wyłącznie w buildzie webowym i wymagają
potwierdzenia. Wyczyszczenie danych witryny przez przeglądarkę również usuwa
wszystkie przepisy preview.

## Różnice platformowe

| Obszar | Android / iOS | Prywatny Web preview |
| --- | --- | --- |
| Rekordy | lokalny plik SQLite | SQLite/Wasm w pamięci origin przeglądarki |
| Zdjęcia | pliki w katalogu aplikacji | data URL zapisany lokalnie w bazie preview |
| Aparat | natywne uprawnienia urządzenia | picker udostępniany przez przeglądarkę |
| Trwałość | dane aplikacji na urządzeniu | zależna od danych witryny i trybu przeglądarki |
| Synchronizacja | brak | brak |

Zdjęcia jako data URL są świadomym ograniczeniem preview. Nie zmieniają modelu
mobilnego i nie są rozwiązaniem docelowym dla publicznej aplikacji webowej.

## Powtarzalny build

Projekt wymaga wersji z `.flutter-version`. Po wygenerowaniu kodu Drift:

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
./tool/build_sites_preview.sh
```

Gotowy artefakt znajduje się w ignorowanym przez Git katalogu `dist/`.
Skrypt sprawdza obecność `index.html`, `sqlite3.wasm` i workera Drift. Ten sam
skrypt uruchamia CI, a `.openai/hosting.json` wskazuje `dist/` jako katalog
publikowany przez ChatGPT Sites.

## Smoke test po wdrożeniu

1. Wczytaj dane demo i odśwież stronę; oba przepisy muszą pozostać widoczne.
2. Dodaj przepis ze zdjęciem, otwórz szczegóły i edytuj nazwę.
3. Wyszukaj przepis i przefiltruj listę po kategorii.
4. Usuń przepis.
5. Wyczyść dane i potwierdź pustą listę oraz obecność kategorii startowych.

Wynik tego testu dotyczy wyłącznie preview. UAT mobilny pozostaje osobnym
warunkiem wydania.
