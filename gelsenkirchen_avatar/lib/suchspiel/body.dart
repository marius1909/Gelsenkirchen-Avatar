import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gelsenkirchen_avatar/suchspiel/suchspiel_art.dart';
import 'package:gelsenkirchen_avatar/suchspiel/suchspiel_hinweis.dart';
import 'package:gelsenkirchen_avatar/suchspiel/text_box.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:gelsenkirchen_avatar/suchspiel/scan_screen.dart';
import 'package:gelsenkirchen_avatar/screens/home_screen.dart';

class Body extends StatefulWidget {
  Body({this.art});

  final SuchspielArt art;
  final int _sekundenProHinweis = 20;

  State<StatefulWidget> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Timer timer;
  SuchspielHinweis hinweis;
  int derzeitigerHinweis;
  int maxHinweise;
  String aktuellerHinweistext;
  int verbleibendeZeit;
  int erreichtePunkte;
  CountDownController _controller = CountDownController();

  @override
  void initState() {
    super.initState();
    hinweis = SuchspielHinweis.alleHinweise[widget.art];
    derzeitigerHinweis = hinweis.derzeitigerHinweis + 1;
    maxHinweise = hinweis.hinweisAnzahl;
    aktuellerHinweistext = hinweis.naechsterHinweis();
    verbleibendeZeit = widget._sekundenProHinweis;
    erreichtePunkte = 30;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR-Suchspiel"),
        //title: Text("Was wird gesucht?"),
        backgroundColor: Color(0xff98ce00),
      ),
      body: SizedBox.expand(
          child: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /* HINWEISANZAHL */
            Container(
              padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
              child: Column(children: [
                Row(
                  children: [
                    Icon(FlutterIcons.announcement_mdi,
                        size: 20, color: Color(0xff7fad00)),
                    SizedBox(width: 10),
                    Text("Hinweis: $derzeitigerHinweis von $maxHinweise",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline3),
                    /* ZEIT */
                    Spacer(),
                    countDownTimer()
                  ],
                ),
              ]),
            ),
            /* HINWEIS */
            Container(
              //height: 500,
              padding: EdgeInsets.fromLTRB(15, 40, 15, 30),
              child: Text(
                aktuellerHinweistext,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),

            /* Alter Hinweis-Text */
            /* Padding(
              padding: EdgeInsets.all(20),
              child: Text(aktuellerHinweistext, textScaleFactor: 1.25),
            ), */

            /* ANTOWRT */
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Antwort:",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff98ce00)),
                  /* textScaleFactor: 2.0, */
                ),
                SizedBox(
                  height: 20,
                ),
                /* TODO: Den Abstand der Boxen evtl. ein wenig erhöhen (Lisa) */
                /* ANTWORT - TEXTBOXEN */

                TextBox(
                  length: hinweis.loesungsWortLaenge(),
                  boxSize: MediaQuery.of(context).size.width /
                          hinweis.loesungsWortLaenge() -
                      5,
                  onNoEmptyField: (antwort) {
                    if (hinweis.istLoesungswort(antwort)) {
                      /* TODO: Punkte vergeben?! (Lisa) */
                      /* Dialog, der angezeigt wir, wenn die richtige Antwort eingegeben wurde */
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Glückwunsch!",
                                style: TextStyle(color: Color(0xff7fad00))),
                            content: Text("Das war die richtige Antwort!"),
                            actions: <Widget>[
                              new FlatButton(
                                child: new Text("Weiterspielen"),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ScanScreen()));
                                },
                              ),
                              new FlatButton(
                                child: new Text("Beenden"),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()));
                                },
                              ),

                              /* Folgende Buttons für das Speichern der Punkte */
                              /* new FlatButton(
                                child: new Text("Ohne Speichern beenden"),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Suchspiel()));
                                },
                              ),
                              new FlatButton(
                                child: new Text("Speichern und beenden"),
                                onPressed: () {},
                              ), */
                            ],
                          );
                        },
                      );

                      /* ALTER ScoreScreen */
                      /* Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ScoreScreen()),
                      ); */
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
      )),
    );
  }

  Widget countDownTimer() {
    return CircularCountDownTimer(
      duration: widget._sekundenProHinweis,
      initialDuration: 0,
      controller: _controller,
      width: MediaQuery.of(context).size.width / 16,
      height: MediaQuery.of(context).size.height / 16,
      ringColor: Colors.grey[300],
      ringGradient: null,
      fillColor: Color(0xff98ce00),
      fillGradient: null,
      backgroundColor: Color(0xff7fad00),
      backgroundGradient: null,
      strokeWidth: 10.0,
      strokeCap: StrokeCap.round,
      textStyle: TextStyle(
          fontSize: 33.0, color: Colors.white, fontWeight: FontWeight.bold),
      textFormat: CountdownTextFormat.S,
      isReverse: true,
      isReverseAnimation: false,
      isTimerTextShown: true,
      autoStart: true,
      onStart: () {
        print('Countdown Started');
      },
      onComplete: () {
        print('Countdown Ended');
        String neuerHinweis = hinweis.naechsterHinweis();
        if (neuerHinweis != null) {
          setState(() {
            derzeitigerHinweis++;
            aktuellerHinweistext = neuerHinweis;
          });
          _controller.restart(duration: widget._sekundenProHinweis);
        }
      },
    );
  }
}
