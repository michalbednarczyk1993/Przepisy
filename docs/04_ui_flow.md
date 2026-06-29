# UI flow

## Ekrany
- `/recipes` — lista przepisów z wyszukiwarką, chipami kategorii, kartami i pustym stanem.
- `/recipes/new` — formularz dodawania przepisu.
- `/recipes/:id` — szczegóły przepisu.
- `/recipes/:id/edit` — edycja przepisu.
- `/categories` — lista kategorii i usuwanie nieużywanych kategorii.

## Przepływy
Użytkownik startuje na liście, dodaje przepis przez FAB, zapisuje formularz, wraca do listy i może wejść w szczegóły. Z poziomu szczegółów można edytować lub usunąć przepis po potwierdzeniu.

## Puste stany
Lista przepisów pokazuje: „Brak przepisów. Dodaj pierwszy przepis.” Kategorie pokazują pusty stan, jeśli lista jest pusta.

## Walidacja
Tytuł przepisu jest wymagany. Kategoria domyślnie ustawia się na „Do zrobienia”, jeśli istnieje. Nazwa kategorii jest wymagana i unikalna bez względu na wielkość liter.
