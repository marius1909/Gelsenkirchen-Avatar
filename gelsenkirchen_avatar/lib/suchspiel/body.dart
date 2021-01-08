import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gelsenkirchen_avatar/suchspiel/score_screen.dart';
import 'package:gelsenkirchen_avatar/suchspiel/suchspiel_art.dart';
import 'package:gelsenkirchen_avatar/suchspiel/suchspiel_hinweis.dart';
import 'package:gelsenkirchen_avatar/suchspiel/text_box.dart';

class Body extends StatefulWidget {
  Body({this.art});

  final SuchspielArt art;

  State<StatefulWidget> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Timer timer;
  SuchspielHinweis hinweis;
  int derzeitigerHinweis;
  int maxHinweise;
  String aktuellerHinweistext;
  int verbleibendeZeit;

  @override
  void initState() {
    super.initState();
    hinweis = SuchspielHinweis.alleHinweise[widget.art];
    derzeitigerHinweis = hinweis.derzeitigerHinweis + 1;
    maxHinweise = hinweis.hinweisAnzahl;
    aktuellerHinweistext = hinweis.naechsterHinweis();
    verbleibendeZeit = 10;
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Was wird gesucht?"),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  "Hinweis: $derzeitigerHinweis von $maxHinweise",
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
                Row(children: [Icon(Icons.timer), Text("$verbleibendeZeit")]),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(aktuellerHinweistext, textScaleFactor: 1.25),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Antwort:",
                  textScaleFactor: 2.0,
                ),
                SizedBox(
                  height: 20,
                ),
                TextBox(
                  length: hinweis.loesungsWortLaenge(),
                  boxSize: MediaQuery.of(context).size.width / hinweis.loesungsWortLaenge() - 5,
                  onNoEmptyField: (antwort) {
                    if (hinweis.istLoesungswort(antwort)) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ScoreScreen()),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void startTimer() {
    if (!(timer == null)) {
      timer.cancel();
    }

    int sekundenCounter = 10;

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        verbleibendeZeit = sekundenCounter;
        sekundenCounter--;
      });

      if (verbleibendeZeit == 0) {
        timer.cancel();

        String neuerHinweis = hinweis.naechsterHinweis();

        if (neuerHinweis != null) {
          derzeitigerHinweis++;
          aktuellerHinweistext = neuerHinweis;
          startTimer();
        }
      }
    });
  }
}
