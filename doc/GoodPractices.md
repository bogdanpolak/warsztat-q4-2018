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
* GitHub, GitLub, itd - opakowanie do Git-a
    * GitHub, GitLab, etc.
    * Issues - zgłoszenia, dyskusje, koncepcje, cytaty kodu
    * Dokumentacja kodu - pliki `Markdown` (MD)
    * Strony Wiki - dynamiczne dokumenty np. status, roadmap, robocze dokumenty
    * Tylko dla zespołu programistycznego
    * Wewnętrzne kompendium programistów
* Przeglądy kodu źródłowego
    * Przeglądamy commit-y
    * Jeden pisze drugi sprawdza
    * Pair Programming - jedno z wymagań metodyki XP

Zobacz także:

* Praca z gałęziami w Git [zobacz artykuł](./WorkingWithBranches.md)
* Issues w GitHub [zobacz artykuł](./ProjectManagment-GitHub.md)

# Czysty kod

* Zasady ustalone przez zespół
* Nie odrywaj koła na nowo
    * Czysty kod wujka Bob-a
    * Wiele inspirujących książek i blogów
* Nie naśladuj ślepo
* Lepiej mniej zasad stosowanych przez wszystkich
* Presja czasu
    * Często musisz iść na skróty
    * Zostaw ślad - TODO w kodzie 

Wujek Bob - Robert C. Martin
    * Doświadczony programista
    * Mentor i trener
    * Doradca w wielu firmach programistycznych
    * Współautor Agile Manifesto
        * W 2001 r. 17 programistów spotkało się w ośrodku w Snowbird (Rocky Mountains, Salt Lake County), aby omówić te lekkie metody budowy systemów informatycznych, między innymi Kent Beck, Ward Cunningham, Jeff Sutherland, Ken Schwaber, Jim Highsmith, Alistair Cockburn i Bob Martin. Wspólnie opublikowali Agile Manifesto. 

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

Polecam:
* Książka: Refactoring - Improving the Design of Existing Code
   * autorzy: Martin Fowler, Kent Beck, John Brant, William Opdyke, Don Roberts, Erich Gamma
   * [Tłumaczenie na polski (Helion)](https://helion.pl/ksiazki/refaktoryzacja-ulepszanie-struktury-istniejacego-kodu-martin-fowler-kent-beck-john-brant-william-opdy,refukv.htm)


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

### Zasady S.O.L.I.D.

![(c) Mohit Rajput - mohitrajput987 Apr 30 '17 https://dev.to/mohitrajput987/coding-best-practices-part-1-naming-conventions--class-designing-principles](https://res.cloudinary.com/practicaldev/image/fetch/s--VIyIhNNs--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://s11.postimg.org/r5n293c4z/SOLID.jpg)

1. SRP = Single Responsibility Principle
    * Klasa powinna być odpowidzialna za jedną rzecz
2. OCP = Open/Close Principle
    * Klasa musi być otwarta na rozbudowę, ale zamknięta na poprawę dobrego kodu
    * Podejrzane: wielopoziomowe if-ów / casów
    * Rozwiązania OOP: abstrakcja, polimorfizm, fabryki
    * Użycie wzorca Fabryki Abstrakcyjnej
        * dostęp do wielu fabryk przez jeden interfejs (klasę abstrakcyjną)
        * dostęp do wyprodukowanych obiektów przez wspólny interfejs lub klasę abstrakcyjną
        * [przykład w C++](https://sourcemaking.com/design_patterns/abstract_factory/cpp/before-after)
        * [przykład w C# / Java](https://refactoring.guru/design-patterns/abstract-factory)
        * [przykład w Delphi](https://www.devfields.com/design-patterns-abstract-factory-pattern/)
3. LSP = Liskov Substition Principle
    * Poprawnie zbudowane drzewo dziedziczenia nie wymaga nadpisywania metod ojca, w celu poprawnego działania algorytmu
    * ```TKwadrat != class(TProstokąt)```
        * zobacz jak działa metoda WyliczPole
    * poprawnie: 
        ```
        TKwadrat = class(TFigure)
        TProstokąt = class(TFigure)
        ```
4. ISP = Interface Segreation Principle
    * Podziel interfejsy na mniejsze (spójne dziedzinowo)
5. DIP = Dependency Invertion Principle
    * Klasy z dwóch różnych warstw separuj interfejsami
    * Przykład: Klasy dziedzinowe (realizujące funkcjonalność) oraz klasy składujące dane (zbiory danych).
    * Jeśli klasa warstwy wyższej tworzy obiekty warstwy niższej to można zastosować: IoC = Inversion of Control
    * Trzech muszkieterów: DIP, IoC, DI (Dependency Injection)

### Prawo Demeter

LoD = Law of Demeter

[Prezentacja na slideshare.net](https://www.slideshare.net/vladimirtsukur/law-of-demeter-objective-sense-of-style)


