import 'dart:async';
import 'dart:convert';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';
import 'package:gelsenkirchen_avatar/suchspiel/suchspiel_art.dart';
import 'package:gelsenkirchen_avatar/suchspiel/suchspiel_hinweis.dart';
import 'package:gelsenkirchen_avatar/suchspiel/text_box.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:gelsenkirchen_avatar/suchspiel/scan_screen.dart';
import 'package:gelsenkirchen_avatar/screens/home_screen.dart';
import 'package:http/http.dart' as http;

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
  dynamic data;

  @override
  void initState() {
    super.initState();
    hinweis = SuchspielHinweis.alleHinweise[widget.art.loesungswort];
    derzeitigerHinweis = hinweis.derzeitigerHinweis + 1;
    maxHinweise = hinweis.hinweisAnzahl;
    aktuellerHinweistext = hinweis.naechsterHinweis();
    verbleibendeZeit = widget._sekundenProHinweis;
    erreichtePunkte = 30;
    getLernort();
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
                    //countDownTimer()
                  ],
                ),
                countDownTimer(),
              ]),
            ),
            /* HINWEIS */
            Container(
              //height: 500,
              padding: EdgeInsets.fromLTRB(15, 15, 15, 30),
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

                /* ANTWORT - TEXTBOXEN */

                TextBox(
                  length: hinweis.loesungsWortLaenge(),
                  boxSize: MediaQuery.of(context).size.width /
                          hinweis.loesungsWortLaenge() -
                      5,
                  onNoEmptyField: (antwort) {
                    if (hinweis.istLoesungswort(antwort)) {
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
                                  erreichtePunkte = (erreichtePunkte /
                                      hinweis.derzeitigerHinweis) as int;

                                  savePoint();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ScanScreen()));
                                },
                              ),
                              new FlatButton(
                                child: new Text("Beenden"),
                                onPressed: () {
                                  erreichtePunkte = erreichtePunkte ~/
                                      hinweis.derzeitigerHinweis;
                                  savePoint();
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
      width: MediaQuery.of(context).size.width / 4,
      height: MediaQuery.of(context).size.height / 4,
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

  Future<void> savePoint() async {
    var param = "?benutzerID=" +
        Benutzer.current.id.toString() +
        "&lernKategorieID=" +
        data['kategorieID'].toString() +
        "&erfahrungspunkte=" +
        (erreichtePunkte).toString() +
        "&lernortID=" +
        widget.art.lernortID.toString() +
        "&suchID=" +
        widget.art.suchID.toString();
    var url = "http://zukunft.sportsocke522.de/save_point.php" + param;
    final response = await http.get(url);
    final jsonData = jsonDecode(response.body);
    if (jsonData['status']) {
      Fluttertoast.showToast(
          msg: "Deine Punkte wurden gespeichert.",
          toastLength: Toast.LENGTH_SHORT);
    } else {
      Fluttertoast.showToast(
          msg: "Es gab ein Fehler beim Speichern deiner Punkte.",
          toastLength: Toast.LENGTH_SHORT);
    }

    //Benachrichtigung werden angezeigt, wenn Level von Spieler aufgestiegen wird
    if (calculateLevel(jsonData['total_point_new']) >
        calculateLevel(jsonData['total_point_old'])) {
      String showtext1;
      String showtext2;
      int belohnungsid;
      if (pointsNeededForNextLevel(jsonData['total_point_new']) == -1) {
        /* TODO: Belohnung anzeigen */
        showtext1 = "Glückwunsch!\nDu hast das Höchstlevel erreicht" +
            "\nDeine Belohnung: ...";
      } else {
        showtext1 =
            "Glückwunsch! Du Hast Level ${calculateLevel(jsonData['total_point_new'])} erreicht! \nDeine Belohnung:";
        showtext2 =
            "\nDu benötigst noch ${pointsNeededForNextLevel(jsonData['total_point_new'])} Punkte für Level ${calculateLevel(jsonData['total_point_new']) + 1}";

        belohnungsid = belohnung(
            calculateLevel(jsonData['total_point_new']), Benutzer.current.id);
      }

      /* Dialog für Levelaufstieg */
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:
                Text("Level Up!", style: TextStyle(color: Color(0xffff9f1c))),
            content: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text(showtext1),
                    SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      "assets/avatar/nachIDs/${belohnungsid}.png",
                      width: 200,
                      height: 100,
                    ),
                    Text(showtext2),
                  ],
                ),
              ),
              height: 250,
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                  Navigator.of(context).pop();
                },
              ),
            ],
            scrollable: true,
          );
        },
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  //Level von Spieler
  int calculateLevel(int totalPoints) {
    if (totalPoints >= 0 && totalPoints <= 29) {
      return 1;
    } else if (totalPoints >= 30 && totalPoints <= 50) {
      return 2;
    } else if (totalPoints >= 51 && totalPoints <= 85) {
      return 3;
    } else if (totalPoints >= 86 && totalPoints <= 145) {
      return 4;
    } else if (totalPoints >= 146 && totalPoints <= 247) {
      return 5;
    } else if (totalPoints >= 248 && totalPoints <= 420) {
      return 6;
    } else if (totalPoints >= 421 && totalPoints <= 714) {
      return 7;
    } else if (totalPoints >= 715 && totalPoints <= 1214) {
      return 8;
    } else if (totalPoints >= 1215) {
      return 9;
    }
    return 0;
  }

  //Berechnet, wie viele Punktzahl Spieler benötigt, um das nächse Level zu erreichen
  int pointsNeededForNextLevel(int totalPoints) {
    if (totalPoints >= 0 && totalPoints <= 29) {
      return 30 - totalPoints;
    } else if (totalPoints >= 30 && totalPoints <= 50) {
      return 51 - totalPoints;
    } else if (totalPoints >= 51 && totalPoints <= 85) {
      return 86 - totalPoints;
    } else if (totalPoints >= 86 && totalPoints <= 145) {
      return 146 - totalPoints;
    } else if (totalPoints >= 146 && totalPoints <= 247) {
      return 248 - totalPoints;
    } else if (totalPoints >= 248 && totalPoints <= 420) {
      return 421 - totalPoints;
    } else if (totalPoints >= 421 && totalPoints <= 714) {
      return 715 - totalPoints;
    } else if (totalPoints >= 715 && totalPoints <= 1214) {
      return 1215 - totalPoints;
    } else {
      return -1;
    }
  }

  void getLernort() async {
    var id = widget.art.lernortID;
    var url =
        "http://zukunft.sportsocke522.de/get_lernortID.php?id=" + id.toString();

    var res = await http.get(url);

    if (jsonDecode(res.body) == "Datensatz existiert nicht") {
      print('Datensatz nicht gefunden');
    } else {
      setState(() {
        data = jsonDecode(res.body);
        print(data);
      });
    }
  }
}

int belohnung(int lvl, int benutzer) {
  int belohungsid = 0;
  if (lvl == 2) {
    belohungsid = 7;
  } else if (lvl == 3) {
    belohungsid = 8;
  } else if (lvl == 4) {
    belohungsid = 9;
  } else if (lvl == 5) {
    belohungsid = 10;
  } else if (lvl == 6) {
    belohungsid = 11;
  } else if (lvl == 7) {
    belohungsid = 12;
  } else if (lvl == 8) {
    belohungsid = 13;
  } else if (lvl == 9) {
    belohungsid = 14;
  }
  freischalten(belohungsid, benutzer);
  return belohungsid;
}

void freischalten(int belohungsid, int benutzer) async {
  var param = "?benutzerID=" +
      benutzer.toString() +
      "&sammelID=" +
      belohungsid.toString();
  var url = "http://zukunft.sportsocke522.de/freischaltungenSetzen.php" + param;
  final response = await http.get(url);
}
