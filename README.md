


<div>
<p>  
		 <h1 align="center">provinciApp</h1>
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
<br>
<br>

<p align="center">
<a href="#provinciapp"> <img style="float: right;" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/Home.png" width="15" height="15" Hspace="4"></a>
<a href="#introduzione"><img src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/FrecciaBack.png" width="15" height="15"></a>
</p>

## Struttura
Per evidenziare le caratteristiche della nostra applicazione è fondamentale distinguere cosa può 
essere effettuato con la connessione internet e cosa no. 

#### Online
La struttura online si presenta divisa in 3 partizioni: 
- <a href="#esplora">***Esplora***</a>
- <a href="#comuni">***Comuni***</a>
- <a href="#categorie">***Categorie***</a>
<br>
Nelle immagini seguenti si può notare che per scorrere da una macrocategoria all'altra è sufficiente premere sopra l'icona ad essa corrispondente. 
Ogni sezione offre una particolare funzionalità dell'applicazione, spiegata nella sezione apposita relativa all'utilizzo.

<br>
<br>
<br>

<p align="center">
	<img width="260" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/Esplora.PNG">
<img width="260" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/Comuni.PNG">
<img width="260" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/Categorie.PNG">

<br>
<br>

 E' opportuno, inoltre, notare come in ognuna di queste sezione siano presenti tre ulteriori pulsanti:

<p align="center">
	<img width="260" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/MainAppBar.PNG">
</p>
<br>
<br>

Analizzando gli stessi da sinistra verso destra:
- il primo ci permetterà di accedere ad alcune funzionalità  <a href="#extra">Extra</a>  quali Cronache Maceratesi, Groupon e The Fork;
- il secondo ci permette la  <a href="#geolocalizzazione">Geolocalizzazione</a> dell'utente;
- il terzo consente l'accesso da parte dell'utente alle <a href="#risorseoffline">Risorse Offline</a>.
<br>
<br>

#### Offline
La struttura offline presenta una sola partizione:

- <a href="#risorseoffline">Risorse Offline</a>
<br>

La macrocategoria in questione permette di visualizzare i dati che l'utente può decidere di scaricare mentre è presente la connessione dati, ma ai quali si può accedere senza quest'ultima. 
<p align="center">
<img  width="260" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/RisorseOffline.PNG">
</p>


<br>
<br>
<p align="center">
<a href="#provinciapp"> <img style="float: right;" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/Home.png" width="15" height="15" Hspace="4"></a>
<a href="#struttura"><img src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/FrecciaBack.png" width="15" height="15"></a>
</p>


## Utilizzo
In questa sezione viene illustrato come utilizzare provinciApp, mostrandone le varie funzionalità.
Importante è distinguere innanzitutto ciò che viene identificato come risultato di una ricerca. Gli elementi ricavati da quest'ultima possono essere di due tipi:
- **Pacchetti**:  Sono i risultati delle ricerche effettuate tramite: 
	- la barra apposita di  <a href="#esplora">Esplora</a>,;
	- il pulsante presente nella schermata principale in alto a destra per la <a href="#geolocalizzazione">Geolocalizzazione</a>;
	- tramite un Comune presente nella relativa schermata dei <a href="#comuni">Comuni</a>;
	- tramite una Categoria presente nella relativa schermata sulle <a href="#categorie">Categorie</a>.

Ogni Pacchetto presentato se premuto permetterà la visualizzazione di una serie di Risorse.
- **Risorse**: Sono i risultati delle ricerche effettuate tramite un Pacchetto. Nella schermata vengono resentati una serie di Pacchetti dovuti ad una precedente ricerca: premendo su uno di questi verrà visualizzata una lista di Risorse. Premendo su una Risorsa si accederà ad una schermata che presenta la visualizzazione dettagliata di quest'ultima.

Spiegati questi due termini fondamentali per la comprensione dello sviluppo dell'applicazione procediamo con le specifiche di ogni macropartizione.

#### *Esplora*

<p align="center"> <img width="260" src= 					"https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/Esplora.PNG">

Aperta l'applicazione, questa è la prima schermata che l'utente visionerà. 

In 'Esplora' è possibile effettuare delle ricerche tramite una parola chiave immessa nella barra apposita, e verranno restituiti se presenti i pacchetti inerenti alla parola chiave in una lista. Premendo sopra uno dei pacchetti presentati, verrà visualizzata in un'altra schermata la lista delle risorse contenute in esso. 

La schermata sotto la barra di ricerca risulterà vuota al primo utilizzo, ossia quando nessuna ricerca è stata effettuata, mentre si andrà a comporre di due a due sottosezioni relative alle ultime ricerche effettuate. 

L'utente vedrà quindi comparire: 
- *Ultime ricerche Pacchetti*: che mostrerà le ultime quattro ricerche dei Pacchetti (ovvero le ultime ricerche effettuate tramite la barra apposita in esplora, la geolocalizzazione, un comune o una categoria). Premendo su uno di essi verrà visualizzata una nuova schermata con l'elenco dei pacchetti relativi all'ultima ricerca selezionata.

- *Ultime ricerche Risorse*: mostrerà le ultime quattro ricerche effettuate sulle Risorse (ovvero le ultime liste di risorse visualizzate premendo sui pacchetti). Premendo su una di esse verrà visualizzata una nuova schermata con l'elenco delle risorse relative all'ultimo pacchetto ricercato.

#### *Comuni*

<p align="center"> <img width="260" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/Comuni.PNG">

La partizione  *Comuni* è costituita da tante cards quanti sono i comuni della provincia di macerata.

Premendo su una di queste cards si visualizzerà l'elenco dei pacchetti inerenti al proprio comune.

Per aggiornare questa schermata basta trascinarla verso il basso.

#### *Categorie*

<p align="center"> <img width="260" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/Categorie.PNG">

La partizione *Categorie* è costituita da diverse cards secondo il numero dellecategorie in cui sono raggruppati i pacchetti delle risorse della provincia di macerata.

Premendo su una di queste cards si visualizzerà l'elenco dei pacchetti inerenti alla categoria selezionata.

Per aggiornare questa schermata è sufficiente trascinarla verso il basso.

#### *Extra*

<p align="center">
  <img width="260" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/Extra.PNG">
  
Il primo pulsante in alto nell'appbar, partendo da sinistra è quello relativo agli *Extra*. 

L'idea che ci ha portato a decidere di inserire gli extra è stata quella di avere un'interazione più semplice e diretta da parte dell'utente rispetto ad alcune applicazioni che avrebbe già potuto conoscere, tra cui:
- *Cronache Maceratesi*;
- *Groupon*;
- *TheFork*;
- ...

Ogni extra rimanda alla pagina corrispondente: in questo modo l'utente non avrà più bisogno di avere diverse applicazioni all'interno del telefono, ma con più facilità potrà direttamente accedere ai vari servizi con maggiore semplicità (essendo qui accorpate)  e risparmiare spazio in memoria.

Il bottone Extra compare solamente se l'utente è online. Se al contrario risulta offline, esso non sarà presente: non appena ci si riconnette alla rete, (sarà sufficiente effettuare un refresh facendo scorrere la pagina verso il basso) il pulsante sarà nuovamente disponibile.

Gli Extra sono stati concepiti in maniera dinamica, ovvero è stata usata una costruzione specifica basata su un file json che contiene una lista di informazioni scritte in un modo prestabilito. 
Questo semplifica notevolmente la possibilità di aggiungere in qualunque momento ulteriori extra (è infatti sufficiente aggiungerlo seguendo il modello al seguente [url](https://raw.githubusercontent.com/GeremiaPompei/provinciApp-extra/main/extra.json) ).

#### *Geolocalizzazione*

Il secondo pulsante è utile alla *Geolocalizzazione*.

Al primo utilizzo verrà richiesto di consentire all'applicazione di accedere alla posizione corrente:

<p align="center">
	<img width="260" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/PermessiPosizione.PNG">

Una volta consentito l'accesso l'applicazione sfruttando la posizione attuale dell'utente mostrerà i risultati relativi alle informazioni presenti nell'area trovata.

<p align="center">
	<img width="260" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/LoadingPosizione.PNG">
<img width="260" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/RicercaPosizione.PNG">

#### *RisorseOffline*

Il secondo pulsante  ci permette di accedere alla schermata *offline*.

La presenza del pulsantino identificato dal `+` permette come descritto in precedenza di accedere alle informazioni anche senza una connessione internet: le stesse saranno accessibili all'utente nella sezione *Risorse Offline*.

<p align="center">
	<img width="260" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/RisorseOffline.PNG">

Se non è presente connessione ad internet sarà la stessa applicazione a forzare l'utilizzo della modalità offline: effettuata una qualsiasi ricerca in assenza di rete comparirà la seguente schermata:

<p align="center">
  <img width="260" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/RicercaOffline.PNG">

In questa sezione è possibile eliminare le risorse tramite il relativo pulsante `-`. La risorsa non scompare dalla sezione però fino ad un aggiornamento così da permettere all'utente di recuperare questa in caso di errore.

Per aggiornare le risorse offline basta trascinare la schermata verso il basso.

#### *Lista Pacchetti*

Una volta eseguita una ricerca tramite le *4 modalità*:

- Barra di ricerca in <a href="#esplora">Esplora</a>;
- Pulsante della <a href="#geolocalizzazione">Geolocalizzazione</a>;
- Pulsante relativo ad un Comune nella schermata <a href="#comuni">Comuni</a>;
- Pulsante relativo ad una Categoria nella schermata <a href="#categorie">Categorie</a>;

Si viene reindirizzati ad una schermata contenente la *lista dei pacchetti* inerenti alla ricerca.

Ognuno di questi pacchetti se premuto offre un'altra schermata relativa alle risorse inerenti al pacchetto selezionato.

É possibile eseguire una ricerca di una lista di pacchetti anche grazie alle ultime ricerche nella sezione *esplora*. In questo caso la ricerca risulterà immediata poiché sfrutterà la cache e non verrà fatta tramite internet.

<p align="center">
  <img width="260" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/ListaPacchetti.PNG">

#### *Lista Risorse*

Effettuata una ricerca tramite un pacchetto grazie alla singola pressione sul pulsante che lo identifica si verrà reindirizzati ad una nuova schermata che mostra la *lista delle risorse* ricercate.

Premendo poi su una di queste risorse si verrà reindirizzati ad una schermata relativa al dettaglio di quest'ultima.

Premendo invece sul bottone `+` a destra di ogni risorsa è possibile salvare quest'ultima offline nella <a href="#risorseoffline">sezione apposita</a> (con il pulsante `-` invece è possibile eliminarla dalla sezione offline).

É possibile eseguire una ricerca di una lista di risorse anche grazie alle ultime ricerche nella sezione *esplora*. In questo caso la ricerca risulterà immediata poiché sfrutterà la cache e non verrà fatta tramite internet.

<p align="center">
  <img width="260" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/ListaRisorse.PNG">

#### *Dettaglio Risorsa*

Arrivati ad una lista di risorse ricercate o alla schermata delle risorse offline basta premere su una di queste per visualizzare con una nuova schermata la risorsa nel dettaglio. In particolare verranno visualizzati:

- **Immagine** della risorsa;
- **Nome** della risorsa;
- **Descrizione** della risorsa ;
- **Info** relative ad ulteriori dati inerenti alla risorsa;
- **Telefono**, ovvero l'elenco dei numeri di telefono della risorsa;
- **Mappa**, ovvero una visualizzazione grafica della posizione della risorsa in una mappa;
- Il pulsante relativo all'**Email** per contattare tramite questa la risorsa;
- Il pulsante relativo alla **Posizione** per aprire la posizione della risorsa in un'altra app specifica per le mappe interna al dispositivo utilizzato;
- Il pulsante relativo al **Link** per visualizzare la risorsa nel proprio sito;
- Il pulsante relativo a **Condividi** per inviare il link della risorsa tramite social;

Non tutte le risorse presentano tali informazioni, infatti esse cambiano dal tipo di risorsa visualizzata.

Oltre a ciò in alto a destra è possibile visualizzare il pulsante `+` per salvare la risorsa offline (`-` se la risorsa è gia stata salvata).

<p align="center">
  <img width="260" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/DettaglioRisorsa1.PNG">
  <img width="260" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/DettaglioRisorsa2.PNG">
  <img width="260" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/DettaglioRisorsa3.PNG">
  <img width="260" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/DettaglioRisorsa4.PNG">

<p align="center">
<a href="#provinciapp"> <img style="float: right;" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/Home.png" width="15" height="15" Hspace="4"></a>
<a href="#utilizzo"><img src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/FrecciaBack.png" width="15" height="15"></a>
</p>


## Specifiche

#### Flutter

Lo sviluppo dell'applicazione è stato effettuato tramite l'utilizzo di **Flutter**, un framework open-source creato da Google per la creazione di interfacce native per iOS e Android.
**Dart** è il linguaggio che abbiamo scelto per il progetto, nato all'interno dell'IDE Intellij e simulato in opportuni dispositivi tramite *Android Studio* e *XCode*.

#### Layout

Il linguaggio utilizzato ci ha permesso di creare un layout molto versatile e moderno, sfruttando quelli che sono i colori della provincia di Macerata. 
Con un'ottima organizzazione dei dati a disposizione, l'applicazione risulta fluida ed intuibile fin dal primo utilizzo.

#### Cache

Il sistema di caching impostato permette di accedere con molta più facilità alle ultime ricerche effettuate: in questo modo è possibile accedere con maggiore velocità alle informazioni e senza la necessità di una connessione dati attiva.

#### Dimensione

La dimensione dell'applicazione è di circa 21Mb. 
La dimensione così ridotta  permette il download anche con la semplice connessione dati del proprio smartphone ed è allo stesso tempo completa di ogni informazione di cui l'utente può necessitare.

#### Offline

All'interno dell'applicazione è possibile scaricare alcuni elementi accessibili senza l'utilizzo della connessione ad internet.
I dati salvati sono reperibili nell'apposita sezione alla quale è possibile accedere come spiegato in precedenza.

#### Database

ProvinciApp sfrutta un database reso disponibile dalla stessa provincia di Macerata.
L'[API CKAN](https://ckan.org/portfolio/api/ "https://ckan.org/portfolio/api/") ci ha permesso di utilizzare i dati formato json e strutturarli nella forma più opportuna all'utilizzo dell'utente.


#### Gps

All'interno di **provinciApp** è possibile ricercare informazioni nel database della provincia di Macerata tramite la *geolocalizzazione*. 
Dopo aver dato il consenso all'utilizzo del gps, verrà individuata la posizione in cui si trova l'utente e il nome di quest'ultima verrà utilizzato per effettuare ricerca. 

#### Social

La funzionalità legata ai social consiste nella possibilità di condividere l'informazione cercata dall'utente nelle varie piattaforme social presenti all'interno del proprio smartphone.
Una volta condiviso l'evento, l'interazione sarà possibile attraverso un click sul link url.

<br>
<br>

<p align="center">
<a href="#provinciapp"> <img style="float: right;" src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/Home.png" width="15" height="15" Hspace="4"></a>
<a href="#specifiche"><img src="https://github.com/GeremiaPompei/provinciApp/blob/master/READMEImage/FrecciaBack.png" width="15" height="15"></a>
</p>

## Autori
- [*Geremia Pompei*](https://github.com/GeremiaPompei)
- [*Alex Pop*](https://github.com/axel2104)
- [*Lorenzo Longarini*](https://github.com/LorenzoLongarini)
 
