# Strategia testów

## Cel

Testy mają dowodzić zachowania opisanego w wymaganiach i chronić dane użytkownika. Nie służą wyłącznie zwiększaniu procentu coverage.

## Poziomy

### Testy domenowe

Szybkie testy jednostkowe bez Flutter UI i bazy:

- filtrowanie i walidacja,
- skalowanie porcji,
- konwersje ilości,
- obliczenia wartości odżywczych,
- rozróżnienie brakującej wartości od zera.

### Testy persistence

Testy Drift na izolowanej bazie:

- CRUD i relacje,
- unikalność kategorii bez względu na wielkość liter,
- blokada usunięcia używanej kategorii,
- migracje każdej wersji schematu,
- zachowanie danych przy migracji składników.

### Widget tests

- walidacja formularzy,
- stany loading/error/empty,
- wyszukiwanie i filtry,
- potwierdzenie usunięcia,
- prezentacja danych częściowych i ostrzeżeń.

### Integration tests

Krytyczne przepływy na aplikacji:

- dodanie → restart → odczyt → edycja → usunięcie,
- wybór i ponowne otwarcie zdjęcia,
- dodanie i ochrona kategorii,
- skalowanie przepisu,
- działanie podstawowe w trybie offline.

### Prywatny preview webowy

- Flutter Web służy do szybkich smoke testów wspólnego UI i przepływów,
- preview jest publikowany prywatnie przez ChatGPT Sites,
- dane testowe pozostają lokalne dla przeglądarki i mogą zostać wyczyszczone między wdrożeniami,
- różnice persistence, zdjęć i uprawnień są jawnie opisane,
- zielony preview nie zastępuje testów Android/iOS ani UAT na urządzeniach.

### Build i testy platformowe

- Android debug build w każdym PR,
- iOS build w środowisku macOS co najmniej przed wydaniem i przy zmianie konfiguracji platformy,
- ręczny smoke test na realnym urządzeniu przed UAT wydania.

## Quality gates

Docelowa kolejność CI:

1. pobranie zależności,
2. generowanie kodu i kontrola różnic,
3. `dart format --output=none --set-exit-if-changed .`,
4. `flutter analyze`,
5. `flutter test`,
6. build Android,
7. build Flutter Web,
8. właściwe skany zależności i bezpieczeństwa,
9. build iOS w odpowiednim jobie.

Próg coverage można ustawić dopiero po wiarygodnym baseline. Po wprowadzeniu nie wolno go obniżyć bez Manual Approval.

## Testy specyfikacji

Krytyczne kryteria zapisujemy w formie Given/When/Then. Test może być jednostkowy, widgetowy lub integracyjny, ale jego nazwa powinna pozwolić powiązać go z wymaganiem.

