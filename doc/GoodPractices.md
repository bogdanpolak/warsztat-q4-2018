# Dobre praktyki programowania

1. Praca zespołowa [czytaj](#praca-zespołowa)
2. Czysty kod [czytaj](#czysty-kod)
3. Solidny kod [czytaj](#solidny-kod)
4. Kod pokryty testami [czytaj](#kod-pokryty-testami)

# Praca zespołowa

* Git - wspólne repozytorium
    * Dokumentowanie historii zmian
    * Zostawiaj ślad po tym co robisz
    * Przy całodziennym kodowaniu - min. 10 rewizji (commit-ów)
    * Oznaczanie commit-ów do przeglądu
* Git++ - rozszerzenia Git-a
    * GitHub, GitLab, etc.
    * Issues - zgłoszenia, dyskusje, koncepcje, cytaty kodu
    * Dokumentacja kodu - pliki `Markdown` (MD)
    * Strony Wiki - dynamiczne dokumenty np. status, roadmap, robocze dokumenty
    * Tylko dla zespołu programistycznego
    * Wewnętrzne kompendium programistów
* Przeglądy kodu źródłowego
    * Przeglądamy commit-y
    * Jeden pisze drugi sprawdza (zmieniamy się)
    * Pair Programming - jedno z wymagań metodyki Agile XP

Zobacz także:

* [Nauka Git-a](./GitLearn.md)
* [Praca z gałęziami w Git](./WorkingWithBranches.md)
* [Issues w GitHub](./ProjectManagment-GitHub.md)

# Czysty kod

* Zasady ustalone przez zespół
* Nie odrywaj koła na nowo
    * Czysty kod wujka Bob-a
    * Wiele inspirujących książek i blogów
* Nie naśladuj ślepo
* Pomyślcie o automatycznym formatowaniu kodu
    * Może jednak domyślne ustawienia formatera dostępnego w RAD Studio są możliwe do przyjęcia?
* Lepiej mniej zasad stosowanych przez wszystkich
* Presja czasu
    * Często musisz iść na skróty
    * Zostaw ślad - TODO w kodzie 

**Wujek Bob - Robert C. Martin**

* Doświadczony programista
* Mentor i trener
* Doradca w wielu firmach programistycznych
* Współautor Agile Manifesto
    * 2001, ośrodku w Snowbird (Rocky Mountains, Salt Lake County)
    * 17 programistów, między innymi Kent Beck, Ward Cunningham, Jeff Sutherland, Ken Schwaber, Jim Highsmith, Alistair Cockburn i Bob Martin
    * Omawiali nowe metody projektowania i budowy systemów informatycznych, nazywane zwinne (agile)

Zobacz także:

* Przykładowa konwencja nadawania nazw [zobacz artykuł](./NamingConvetion.md)
    * Naming Convention
    * Code Style Guide
* Czysty kod wg wujka Bob-a [zobacz artykuł](./RobertMartinCleanCode.md)

**DRY - `Don't Repeat Yourself`**

* Unikaj kopiuj-wklej
* Uogólniaj rozwiązanie
    * zamiast: zmienna1, zmienna2, zmienna3
    * tablica lub lista
    * odnajduj podobne wzorce i buduj reużywalne moduły
* W metodach używaj mniej niż 5 wyrażeń warunkowych IF / WHILE
    * szczególnie gdy niewiele się różnią zarówno pod kątem warunku, jak i tego co jest wykonywane jeśli warunek jest prawdziwy
* Separacja logiki
    * Wydzielaj logikę na zewnątrz (do klasy lub przynajmniej do funkcji)
    * Staraj się wstrzykiwać wszelkie zależności do klasy (Prawo Demeter)

**Złe zapachy kodu**

Nie programuj zawsze w ten sam sposób. Ucz się i eksperymentuj z nowymi sposobami kodowania.  Naucz się rozpoznawać zapachy kodu: kiedy śmierdzi, a kiedy ma miły zapach.

Warto przeczytać:

* Refactoring - Improving the Design of Existing Code
   * autorzy: Martin Fowler, Kent Beck, John Brant, William Opdyke, Don Roberts, Erich Gamma
   * [Tłumaczenie na polski (Helion)](https://helion.pl/ksiazki/refaktoryzacja-ulepszanie-struktury-istniejacego-kodu-martin-fowler-kent-beck-john-brant-william-opdy,refukv.htm)
* Clean Code: A Handbook of Agile Software Craftsmanship
    * autor: Robert C. Martin
    * [Tłumaczenie na polski (Helion)](https://helion.pl/ksiazki/czysty-kod-podrecznik-dobrego-programisty-robert-c-martin,czykov.htm)

# Solidny kod

* Dobre praktyki
* MVC
* Separacja warstw
* Częste używanie interfejsów
* Praktyki opracowane i spisane przez zespół
* Gotowce traktuj jako wskazówki (nie rób kopuj-wklej)
* Inspiracje
    * Prawo Demeter
    * S.O.L.I.D.

**Architekt na pokładzie**

Warto zająć się solidnym kodem od samego początku. Budowanie jednolitych praktyk jest jednak trudniejsze niż budowanie zasad czystego kodu, gdzie szybciej można znaleźć wspólne zasady. W przypadku projektowania solidnego kodu konieczny będzie architekt, który przekona (zachęci) resztę zespołu do swoich rozwiązań, ale równocześnie to osoba, która będzie otwarta na rozwiązania alternatywne lub uproszczone.

Zobacz także:

* Zasady S.O.L.I.D. [zobacz artykuł](/RobertMartinSOLIDPrinceples.md)
* Prawo Demeter [prezentacja na slideshare.net](https://www.slideshare.net/vladimirtsukur/law-of-demeter-objective-sense-of-style)

# Kod pokryty testami

TBD

### Testowanie

* Testuj kod często
* Postaraj się, aby robiły to za Ciebie automaty
    * Testy jednostkowe
        * DUnitX
        * TestInsight (Stefan Glienke) [link](https://bitbucket.org/sglienke/testinsight/wiki/Home)
    * Testy integracyjne
        * DUnitX
    * Testy akceptacyjne
        * Nagrywanie i odtwarzanie
        * Ranorex Studio - [link](https://www.ranorex.com/windows-desktop-test-automation/)
        * Smartbear TestComplete - [link](https://smartbear.com/product/testcomplete/)
* Czasami warto popracować w TDD
    * Krótkie cykle:
        1. Piszę prosty test
        2. Piszę kod spełniający ten test
        3. Refaktoryzuję kod test i kod produkcyjny

