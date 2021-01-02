import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';

class NFCQuiz extends StatefulWidget {
  @override
  _NFCQuizState createState() => _NFCQuizState();
}

class _NFCQuizState extends State<NFCQuiz> {
  String ergebnisText = "";
  String loesungswort = "";
  String frage = "";
  List<String> tipps = new List();
  int anzahlAnGezeigtenTipps;

  //in sekunden
  int zeitZumLoesen;
  Timer timer;
  bool timerStarted = false;

  //wird false wenn neue Frage gestellt wird
  bool initComplete = false;
  bool frageAngezeigt = false;

  List<Flexible> buchstabenFelder;
  List<TextEditingController> alleTextController;

  Widget build(BuildContext context) {
    //init---------------
    if (!initComplete) {
      alleTextController = new List();
      buchstabenFelder = buildTextFields();
      zeitZumLoesen = 10;

      initComplete = true;
    } //init end-----------

    if (!timerStarted) {
      startTimer();
    }

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
  }

  void resetTimer() {}

  void startTimer() {
    int sekundenCounter = 10;

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (sekundenCounter >= 0) {
          zeitZumLoesen = sekundenCounter;
          sekundenCounter--;
        } else {
          pruefeErgebnis();
          timer.cancel();
        }
      });
    });
    timerStarted = true;
  }
}
