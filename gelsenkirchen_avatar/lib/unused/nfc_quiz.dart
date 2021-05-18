import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';

class NFCQuiz extends StatefulWidget {
  @override
  _NFCQuizState createState() => _NFCQuizState();
}

/*
toDo: 
1.Zurzeit 3 bool werte um die Korrekten daten anzuzeigen bzw. keine errors beim initialisieren zu haben, sollte einfacher/mit weniger gehen
2. Timer korrekt im erstem Frame starten, zurzeit hängt er ne sekunde hinterher
3. Punktestand
4. Löse einzelne buchstaben nach Zeit
5. Tipps nach Prozentsatz der abgelaufenen Zeit anzeigen und egal für welche Anzahl an Tipps

*/

class _NFCQuizState extends State<NFCQuiz> {
  //anzeige
  String ergebnisText = "";
  String loesungswort = "";
  String frage = "";

  int anzahlAnGezeigtenTipps;

  //timer
  int zeitZumLoesen; //in sekunden
  Timer timer;

  //bools zum korrekten anzeigen
  bool timerStarted = false;
  bool initComplete = false;
  bool frageAngezeigt = false;

  List<String> tipps = new List();
  List<Flexible> buchstabenFelder;
  List<TextEditingController> alleTextController;

  Widget build(BuildContext context) {
    //init---------------
    if (!initComplete) {
      alleTextController = new List();
      buchstabenFelder = buildTextFields();
      initComplete = true;
    } //init end-----------

    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('NFC QUIZ'),
      ),
      body: Column(
        children: [
          Text("" + zeitZumLoesen.toString()),
          FlatButton(
              color: Colors.blue,
              onPressed: () => neueFrage(),
              child: Text("Nächste Frage")),
          Text(frage, style: TextStyle(fontSize: 20)),
          Column(
            children: [
              if (frageAngezeigt)
                for (int i = 0; i < anzahlAnGezeigtenTipps; i++) Text(tipps[i])
            ],
          ),
          Row(
            children: [
              for (int i = 0; i < buchstabenFelder.length; i++)
                buchstabenFelder[i]
            ],
          ),
          FlatButton(
              color: Colors.blue,
              onPressed: () => pruefeErgebnis(),
              child: Text("Prüfe")),
          Text(ergebnisText)
        ],
      ),
    );
  }

//Erstellt beim aufrufen einer neuen Frage dynamisch die richtige anzahl an Textfelder
  List<Flexible> buildTextFields() {
    List<Flexible> temp = new List();

    for (int i = 0; i < loesungswort.length; i++) {
      TextEditingController controller = new TextEditingController();

      alleTextController.add(controller);

      temp.add(Flexible(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: new TextFormField(
                controller: controller,
                //folgendes funktioniert zurzeit nicht und ist ein known bug in dart
                //https://github.com/flutter/flutter/issues/67236
                //Es sollte verhindern das man mehr als einen Buchstaben eingibt
                maxLength: 1,
                maxLengthEnforced: true,
              ))));
    }

    return temp;
  }

//gleicht nacheinander alle TextFelder mit dem Buchstaben des Lösungsworts ab
  bool pruefeErgebnis() {
    bool wortGleich = true;

    if (loesungswort.isNotEmpty) {
      for (int i = 0; i < loesungswort.length; i++) {
        if (!(alleTextController[i].text == loesungswort[i])) {
          wortGleich = false;
        }
      }
    }

    if (wortGleich) {
      setState(() {
        ergebnisText = "Richtig";
      });
    } else {
      setState(() {
        ergebnisText = "Falsch";
      });
    }

    return wortGleich;
  }

//Timer
  void startTimer() {
    if (!(timer == null)) {
      timer.cancel();
    }

    int sekundenCounter = 20;

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (sekundenCounter >= 0) {
          zeitZumLoesen = sekundenCounter;
          sekundenCounter--;

          if (sekundenCounter >= 15) {
            anzahlAnGezeigtenTipps = 0;
          } else if (sekundenCounter >= 10) {
            anzahlAnGezeigtenTipps = 1;
          } else if (sekundenCounter >= 5) {
            anzahlAnGezeigtenTipps = tipps.length;
          }
        } else {
          pruefeErgebnis();
          timer.cancel();
        }
      });
    });
    timerStarted = true;
  }

  //dummy funktionen für Datenbank implementierung, neueFrage(String Frage, String Loesung, List<String> tipps)?
  //eventuell sekunden für Timer hier festlegen
  void neueFrage() {
    setState(() {
      tipps.clear();

      frage = "Wie heißt Baum X?";
      loesungswort = "Rotbuche";
      tipps.add("Es ist ein Baum von Gattung X");
      tipps.add("Der Baum ist Rot");
      tipps.add("Der Baum ist eine Buche");
    });

    anzahlAnGezeigtenTipps = tipps.length;

    timerStarted = false;
    frageAngezeigt = true;
    initComplete = false;

    startTimer();
    anzahlAnGezeigtenTipps = 0;
  }
}
