# JustReadIt

# Web aplikacija

## Ukratko

Cilj je da se napravi aplikacija koja će omogućiti korisnicima da brže čitaju internet sadržaj u boji.

Servis koji će spojiti Instapaper https://www.instapaper.com i Spritz http://www.spritzinc.com. (Inače takav servis već postoji - http://www.readsy.co/).

## Funkcionalnost

### Korisnici

Aplikacija treba da omogući korisnicima da se registruju i uloguju sa emailom i šifrom. Pored toga korisnik treba da ima username. Nije potreban email confirmation. Koristi Devise gem. 

### Čitanje

Aplikacija treba da omogući korisnicima da pejstuju URL, podese brzinu čitanja i da nakon klika na “Read!” krene stream reči.

U toku čitanja korisniku treba da budu dostupne komande “Pause” i “Resume”.

#### Čitanje u boji

Pored izbora brzine čitanja korisnik treba da ima izbor da li će se reči prikazivati kao:

- crni tekst na beloj pozadini
- tekst random boje iz Semaphore logoa (zelena, crvena, crna)

### Arhitektura aplikacije

#### 1 - User interface - Rails aplikacija 

Treba da uključuje sledeću funkcionalnost:

- UI
- Download stranica sa zadatog URL-a
- Izdvajanje teksta iz stranice. Ova funkcionalnost treba dobro da funkcionise za jedan tip sajta koji sadrzi dosta sadržaja za čitanje, npr. Medium.com, za ostale može samo da izdvaja tekst iz h1-h6 i p tagova.
- Snimanje URL-a i extraktovanog testa u bazu. Sve treba da bude vezano za korisnika.
- Javno listanje svih URL-ova koje su ljudi “čitali”
- Slanje teksta reč po reč u mikroservis za farbanje teksta
- Zbog arhitekture aplikacije tempo pristizanja reči verovatno neće biti idealan. Ignorisati to. Važan je da tempo slanja iz Rails aplikacije (pogledaj https://github.com/jmettraux/rufus-scheduler).
- Farbanje određenog slova i specifično pozicioniranje reči kao na Spritz-u ignorisati

#### 2 - Farbanje teksta - Sinatra aplikacija

Prima tekst, menja mu boju i šalje ga u mikroservis za strimovanje teksta

#### 3 - Strimovanje teksta korisniku

Sinatra aplikacija koja prima ofarbani tekst reč po reč i šalje ga korisniku u browser uz pomoć websocket-a. Koristiti Pusher https://pusher.com.

## Napomene

Tri aplikacije za međusobnu komunikaciju treba da koriste JSON API.

U kodu, komentarima, commit porukama itd koristi isključivo engleski jezik.

Kod treba čuvati u open source GitHub repozitorijumima. Molim te pošalji nam linkove do repozitorijuma kada kreneš sa radom.

Aplikacija treba da koristi Ruby 2, Rails 4, jQuery, AngularJS ili neku treću JS biblioteku i PostgreSQL.

Koristi Twitter Bootstrap i aplikacije deploy-uj na Heroku.

Aplikaciju treba pokriti Cucumber scenarijima i RSpec testovima.

Glavne reference su:
http://api.rubyonrails.org
http://guides.rubyonrails.org
http://www.sinatrarb.com

Pored toga korisno je pogledati nešto sa http://railscasts.com.

Slobodno nas kontaktiraj ako imaš neka pitanja.
# JustReadIt
