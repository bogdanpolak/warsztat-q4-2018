# Konfiguracja stanowiska warsztatowego 

##  Instalacja serwerów SQL i baz danych

1. (o ile konieczne) Zainstalowanie i konfiguracja serwera InterBase lub Firebird (do wyboru jeden z nich)
2. **Pobranie gotowej bazy danych**
	* [Foder OneDrive z plikami bazy danych](https://1drv.ms/f/s!An4rcuXGtj40-xWySBwS1XbG1ZXy)
	* **MAILING-DATABASE.IB** - baza InterBase (wersja ODS 15 - InterBase XE7 lub nowszy)
	* **MAILING-DATABASE.FDB** - baza Firebird (wersja 2.5)
2. (jeśli plik bazy nie działa poprawnie) Stworzenie pustej bazy danych InterBase / Firebird
	* Artykuł w serwisie reedit.com:
		* [serwer InterBase](https://www.reddit.com/user/BogdanPolakBSC/comments/9cymje/)
		* [serwer Firebird](https://www.reddit.com/user/BogdanPolakBSC/comments/9cyrh2/)
	* Skrypt tworzący bazę pustą bazę danych
		```sql
		create database '<folder z danymi>\MAILING-DATABASE.FDB' default character set UTF_8;
		```
3. Dodanie **definicji połączenia FireDAC** do bazy
	* W środowisku Delphi - Przez ```Data Explorer```
		* menu kontekstowe na odpowiednim serwerze (InterBase lub Firebird) w grupie FireDAC
		* ```Add New Connection ...```
	* Przez ```FireDAC Explorer```
	* **Uwaga!!** Przy ustawianiu parametrów połączenia proszę ustawić tablicę znaków: Character Set = ```UTF8```
	* Nazwa definicji połączenia
		* IB_MailingDB - InterBase 
		* FB_MailingDB - Firebird
4. (można pominąć) Sprawdzenie czy połączenie jest Unicode-owe.
	* Ustawienie ```CHARACTER SET = UTF8``` w połączeniach FireDAC oraz w konsoli administracyjnej
	* Uruchomienie skryptu (menu [Tools] -> [FireDAC Explorer] lub [FireDAC Connection Editor] -> zakładka [SQL Script]:
		* [FireDAC Explorer](http://docwiki.embarcadero.com/RADStudio/Tokyo/en/Setting_up_Connections_(FireDAC)#Using_the_FDExplorer_Utility)
		* [FireDAC Connection Editor](http://docwiki.embarcadero.com/RADStudio/Tokyo/en/Setting_up_Connections_(FireDAC)#Using_the_TFDConnection_Design-Time_Editor)
		```
		SET AUTOCOMMIT ON
		CREATE TABLE AAA (F1 VARCHAR(50) CHARACTER SET UTF8);
		INSERT INTO AAA VALUES ('Οὐχὶ ταὐτὰ παρίσταταί');
		SELECT * FROM AAA;
		DROP TABLE AAA;
		```
	* Na konsoli powinny pojawić się greckie słowa z tabeli AAA.

## Klient Git i konto na GitHub
		
1. **Konto na Github** (niezbędne do pracy w czasie warsztatów)
	* Sprawdzenie dostępu do aktualnego konta (login / hasło) lub założenie nowego konta
	* Założenie konta: https://github.com/join 
2. **Klient Git dla Windows** (instalacja)
	* Pobranie i instalacja Git dla Windows: https://git-scm.com/download/win
	* Zainstalowanie Manager'a autentykacji dla Git Windows: https://github.com/Microsoft/Git-Credential-Manager-for-Windows
		* Przydatny wtedy gdy konsola Windows "zapomina" dane logowania dla git-a.
		* Pobranie instlatora (EXE) ze strony: https://github.com/Microsoft/Git-Credential-Manager-for-Windows/releases/
		* Uruchomienie
	* Konfiguracja klienta Git z linii poleceń
		* Proszę wpisać swoje dane
		```sh
		git config --global user.email "you@example.com"
		git config --global user.name "Your Name"
		```
3. **Dodanie aliasów git-a**
	* Poniższe aliasy pozwalają wyświetlać historię rewizji repozytorium w postaci drzewa (bardzo wygodne)
	* Aby plik ```.gitconfig``` został stworzony niezbędne jest wykonanie polecenia ```git config --global ...``` opisanego w punkcie 2.
	* Modyfikacja pliku pliku .gitconfig
		* Lokalizacja: C:\Users\{{użytkownik}}
		* dodanie poniższych aliasów:
		```
		[alias]
			graph1 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all
			graph2 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all
			lg = !"git graph1"
		```
4. **Sklonowanie tego repozytorium**
	* Klonowanie pobiera całe repozytorium z GitHub i tworzy jego klona na dysku lokalnym w podkatalogu o takim samym jak nazwa repozytorium
	* Uruchomienie linii poleceń (konsoli Windows) - **CMD.EXE**
	* Przejście do folderu w którym mają być źródła projektu
		* polecenia: ```cd``` i ```dir```
		* ```git clone https://github.com/bogdanpolak/warsztat-q4-2018.git```

## Delphi

1. Wymagane jest przynamniej Delphi XE8 lub nowszej
2. Ustawienie opcji IDE dla Git-a:
	* Git Executable
	* Remote authentication data
	![](./assets/images/opcje-IDE-dla-Gita.png)
3. Instalacja ChromeTabs przez GetIt Package Manager:
	* menu: Tools -> GetIt Package Manager
	* ![](./assets/images/getit-manager.png)
4. Uruchomienie projektu sklonowanego w Delphi
	* Załadowanie pliku ```dpr``` z folderu ```project```
	* Skompilowanie projektu (zignorowanie wszystkich zbędnych properites)
	* Ustawienie definicji połączenia w unit-cie ```Data.Main.pas```
		*  ```FDConnection1.ConnectionDefName```:
			* **IB_MailingDB** - dla bazy Interbase
			* **FB_MailingDB** - dla bazy Firebird
	* Uruchomienie i sprawdzenie działania

