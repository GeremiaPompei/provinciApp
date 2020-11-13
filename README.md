
<div>
<p>  
	<font color="blu"> 
		 <h1 align="center">provinciApp</h1>
	</font>
</p>

<p align="center">
  <img width="260" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/logo_provinciApp.PNG">

<p align="center">
<a href="#introduzione">Introduzione</a>&nbsp•
<a href="#struttura">Struttura</a>&nbsp•
<a href="#utilizzo">Utilizzo</a>&nbsp•
<a href="#specifiche">Specifiche</a>&nbsp•
<a href="#autori">Autori</a>
</p>
<br>
<br>
</div>


## Introduzione

<h4 align = "left"> Cos'è?</h4>

```
provinciApp è la nostra idea di applicazione per la provincia di Macerata
secondo il concorso "Un'app per la provincia di Macerata".
Il progetto nasce da tre giovani studenti con molta voglia di impegnarsi
e mettersi in gioco.
Lo sviluppo dell'applicazione nasce dalla base dei requisiti richiesti dal
concorso, arricchiti dalle nostre idee e competenze al fine di creare qualcosa 
di  articolato ma intuitivo, tale da essere fruibile da ogni fascia di età. 
 ```
                                                                                                                                              
  
#### Obiettivi del concorso  
  *L’applicazione mobile dovrà presentare le seguenti caratteristiche tecniche:*  
  ```
• dovrà essere realizzata con linguaggio open source secondo modalità 
“cross-platform”, funzionando correttamente su dispositivi basati sia su 
sistema operativo iOS (versione 6 o superiore) che su Android (versione 3.2
 o superiore);  
```

```
• layout grafico progettato e realizzato per dispositivi mobile sia di tipo 
smartphone sia di tipo tablet;  
```
```
• dovrà utilizzare un sistema di caching delle informazioni multimediali per 
ottimizzare i tempi e le modalità di reperimento dei dati;  
```
```
• avere una dimensione al download compatibile con l’installazione via 3G;  
```
```
• funzionare anche in modalità off-line;  
```
```
• dovrà basarsi sull’utilizzo degli Opendata della provincia di Macerata, 
pubblicati e reperibili al link 'http://dati.provincia.mc.it', e potrà trattarsi
 di un’applicazione per la rappresentazione di dati geo-riferiti.
```

*Saranno ritenuti motivo di maggiore punteggio:*
```
• l’utilizzo dei sensori del dispositivo mobile (GPS, bussola, accelerometro, 
fotocamera, ecc.);  
```
```
• l’interoperabilità con il mondo dei social network: possibilità di interazione 
con le APP social presenti sui device, all’interno delle community di 
appassionati;  
```
```
• l’ottimizzazione dei tempi di risposta necessari ad un utilizzo
 dell’applicazione in mobilità minimizzando il consumo di banda mobile internet 
 e/o saturazione dell’accesspoint nel caso di wi-fi pubblico.
```

<a href="#provinciapp"> <img style="float: right;" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/Home.png" width="15" height="15" Hspace="4"></a>
<a href="#introduzione"><img src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/FrecciaBack.png" width="15" height="15"></a>


## Struttura
Per evidenziare le caratteristiche della nostra applicazione è fondamentale distinguere cosa può essere effettuato con la connessione internet e cosa no. 

#### Online: 
- <a href="#esplora">Esplora</a>
- <a href="#comuni">Comuni</a>
- <a href="#categorie">Categorie</a>


#### Offline:
- <a href="#risorseoffline">RisorseOffline</a>

<a href="#provinciapp"> <img style="float: right;" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/Home.png" width="15" height="15" Hspace="4"></a>
<a href="#struttura"><img src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/FrecciaBack.png" width="15" height="15"></a>


## Utilizzo
In questa sezione viene illustrato come utilizzare provinciApp, mostrandone le varie funzionalità.
Per cominciare è bene fare una distinzione tra funzionamento online e funzionamento offline, in quanto alcune funzionalità dell'applicazione non possono essere eseguite senza una connessione ad internet. Nonostante questo, la sezione offline permette comunque di accedere ad informazioni salvate in precedenza.

Se presente la connessione ad internet all'apertura dell'applicazione, ci ritroveremo automaticamente alla schermata online. Quest'ultima è organizzata in tre sezioni le quali hanno in comune un'appbar in alto all'interno della quale è presente il nome della sezione singola e tre ulteriori pulsanti:

#### *Esplora*

<p align="center">
	<img width="260" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/Esplora.PNG">

#### *Comuni*

<p align="center">
	<img width="260" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/Comuni.PNG">

#### *Categorie*

<p align="center">
	<img width="260" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/Categorie.PNG">


Il primo pulsante è utile alla **geolocalizzazione**. Al primo utilizzo verrà richiesto di consentire all'applicazione di accedere alla posizione corrente:

<p align="center">
	<img width="260" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/PermessiPosizione.PNG">

Una volta consentito l'accesso per ogni altro utilizzo il consenso di utilizzo della posizione non sarà più richiesto. A questo punto l'applicazione sfruttando la posizione attuale dell'utente mostrerà i risultati relativi alle informazioni presenti nell'area trovata.

<p align="center">
	<img width="260" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/LoadingPosizione.PNG">
<p align="center">
	<img width="260" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/RicercaPosizione.PNG">

Il secondo pulsante  ci permette di accedere alla schermata **offline**.  (La sezione è spiegata nello specifico [qui](https://github.com/GeremiaPompei/mc/blob/master/README.md#lista-di-elementi-scaricati))

#### *RisorseOffline*

<p align="center">
	<img width="260" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/RisorseOffline.PNG">

Se non è presente connessione ad internet sarà la stessa applicazione a forzare l'utilizzo della modalità offline: effettuata una qualsiasi ricerca in assenza di rete comparirà la seguente schermata:

<p align="center">
  <img width="260" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/RicercaOffline.PNG">

Cliccando sul pulsante 'Offline' si accederà alla schermata offline ([qui](https://github.com/GeremiaPompei/mc/blob/master/README.md#lista-di-elementi-scaricati)). 

<a href="#provinciapp"> <img style="float: right;" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/Home.png" width="15" height="15" Hspace="4"></a>
<a href="#utilizzo"><img src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/FrecciaBack.png" width="15" height="15"></a>


## Specifiche


#### Api
[0]:https://github.com/GeremiaPompei/mc/blob/master/README.md#api
L'applicazione fornisce dati resi disponibili da un database appartenente alla provincia di Macerata a cui è possibile accedere tramite l'API CKAN: [https://ckan.org/portfolio/api/](https://ckan.org/portfolio/api/ "https://ckan.org/portfolio/api/").

#### Flutter
[1]:https://github.com/GeremiaPompei/mc/blob/master/README.md#flutter
Lo sviluppo dell'applicazione è stato effettuato tramite l'utilizzo di **Flutter**, un framework open-source creato da Google per la creazione di interfacce native per iOS e Android.
**Dart** è il linguaggio che abbiamo scelto per il progetto, nato all'interno dell'IDE Intellij e simulato con Android Studio e XCode.

#### Layout
[2]:https://github.com/GeremiaPompei/mc/blob/master/README.md#layout
Il linguaggio utilizzato ci ha permesso di creare un layout molto versatile e moderno, sfruttando quelli che sono i colori della provincia di Macerata, inoltre i dati organizzati secondo le informazioni del database sono stati organizzati in modo tale rendere semplice la fruizione degli stessi.

#### Cache
[3]:https://github.com/GeremiaPompei/mc/blob/master/README.md#cache
Il sistema di caching impostato permette di accedere con molta più facilità alle ultime ricerche effettuate: in questo modo è possibile accedere alle informazioni con velocità maggiore e senza la necessità di una connessione dati attiva.

#### Dimensione
[4]:https://github.com/GeremiaPompei/mc/blob/master/README.md#dimensione
La dimensione dell'applicazione è di circa 21Mb, ad indicare come, sebbene essa possegga una grande quantitità di dati frubili dall'utente, sia molto leggera e facilmente scaricabile con la sola connessione dati del proprio smartphone.

#### Offline
[5]:https://github.com/GeremiaPompei/mc/blob/master/README.md#offline
All'interno dell'applicazione è possibile scaricare alcuni elementi ai quali è poi possibile accedere senza l'utilizzo della connessione ad internet. I dati salvati possono essere reperibili nell'apposita sezione alla quale è possibile accedere tramite il pulsante 'Offline' in alto a destra.

#### Database
[6]:https://github.com/GeremiaPompei/mc/blob/master/README.md#database
L'organizzazione dei dati segue il modello del database fornito, dal quale è possibile reperire le informazioni che verranno elaborate in modo dinamico dall'applicazione.

#### Gps
[7]:https://github.com/GeremiaPompei/mc/blob/master/README.md#gps
All'interno di **provinciApp** è possibile ricercare informazioni nel database della provincia di Macerata tramite la *geolocalizzazione* che, dopo aver dato il consenso all'uso del gps, trova la posizione in cui si trova l'utente e il nome di questa che viene utilizzato per la ricerca. Tale funzione velocizza la ricerca dell'utente se questo si trova direttamente nel comune  in cui voleva effettuare quest'ultima.

#### Social
[8]:https://github.com/GeremiaPompei/mc/blob/master/README.md#social
La funzionalità legata ai social consiste nella possibilità di condividere l'informazione cercata dall'utente nelle varie piattaforme social presenti all'interno del proprio smartphone.
Una volta condiviso l'evento, l'interazione sarà possibile attraverso un click sul link url.

<a href="#provinciapp"> <img style="float: right;" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/Home.png" width="15" height="15" Hspace="4"></a>
<a href="#specifiche"><img src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/FrecciaBack.png" width="15" height="15"></a>

## Autori
- [*Geremia Pompei*](https://github.com/GeremiaPompei)
- [*Alex Pop*](https://github.com/axel2104)
- [*Lorenzo Longarini*](https://github.com/LorenzoLongarini)
 
