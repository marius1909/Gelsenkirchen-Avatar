import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/memorykarte.dart';
import 'dart:async';
import 'package:gelsenkirchen_avatar/widgets/ladescreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class MemoryPage extends StatefulWidget {
  final int benutzerID;
  final int lernKategorieID;
  final int lernortID;
  final String title;
  final int memoryID;
  final String aufgabe;
  final int erfahrungspunkte;

  MemoryPage(
      {this.benutzerID,
      this.lernKategorieID,
      this.lernortID,
      this.title,
      this.memoryID,
      this.aufgabe,
      this.erfahrungspunkte});

  @override
  _MemoryPageState createState() => _MemoryPageState();
}

class _MemoryPageState extends State<MemoryPage> {
  int _previousIndex = -1;
  bool _flip = false;
  bool _start = false;
  bool _disposed = false;
  bool _wait = false;
  Timer _timer;
  int _timerstart = 8;
  int _paareUebrig;
  bool _isFinished;
  List<Memorykarte> karten;
  int _erfahrungspunkte;
  int _summePunkte;
  bool laedt = true;
  CountDownController _controller = CountDownController();

  List<bool> _cardFlips;
  List<GlobalKey<FlipCardState>> _cardStateKeys;

  /* Erstellt den Kartenrücken abhängig vom kartenInhalt */
  Widget getItem(int index) {
    String kartenInhalt = karten[index].kartenInhalt;
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey[200],
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 0.5,
                spreadRadius: 0.3,
                offset: Offset(2.0, 1),
              )
            ],
            borderRadius: BorderRadius.circular(5)),
        margin: EdgeInsets.all(4.0),
        child: karten[index].kartentyp == 1
            ? Image.network(kartenInhalt, fit: BoxFit.fill)
            : Container(
                alignment: Alignment.center,
                child: Text(
                  kartenInhalt,
                  textAlign: TextAlign.center,
                )));
  }

  /* Starten des Timers bis zum Start des Spiels */
  Widget countDownTimer() {
    return CircularCountDownTimer(
      duration: _timerstart,
      initialDuration: 0,
      controller: _controller,
      width: MediaQuery.of(context).size.width / 6,
      height: MediaQuery.of(context).size.height / 6,
      ringColor: Colors.grey[300],
      ringGradient: null,
      fillColor: Color(0xffe54b4b),
      fillGradient: null,
      backgroundColor: Color(0xffbb1b1b),
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
        startPunkteTimer();
        if (!_disposed)
          setState(() {
            _start = true;
            // _timer.cancel();
          });
      },
    );
  }

  /* Starten des Timers für die Punkteberechnung */
  startPunkteTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (!_disposed)
        setState(() {
          _summePunkte = _summePunkte - 10;
        });
    });
  }

  /* Erstellt eine Liste der verfügbaren Memorykarten für den Lernort */
  Future<List<Memorykarte>> getMemorykarten() async {
    var memoryID = widget.memoryID;
    // return Memorykarte.shared.gibObjekte();
    return Memorykarte.shared.sucheObjekt("memoryID", memoryID);
  }

  /* Wird ausgeführt beim Replay */
  void restart() {
    karten.shuffle();
    _cardFlips = getInitialItemState();
    _cardStateKeys = getCardStateKeys();
    _paareUebrig = (karten.length ~/ 2);

    _isFinished = false;
  }

  @override
  void initState() {
    super.initState();
    _erfahrungspunkte = widget.erfahrungspunkte;
    _summePunkte = _erfahrungspunkte;
    getMemorykarten().then((memory) {
      if (!_disposed)
        setState(() {
          karten = memory;
          restart();
        });
    });
  }

  /* Erstellt Liste zur Überprüfung welche Paare aus karten schon gefunden worden sind */
  List<bool> getInitialItemState() {
    List<bool> initialItemState = new List<bool>();

    for (int i = 0; i < karten.length; i++) {
      initialItemState.add(true);
    }

    return initialItemState;
  }

  /* Dient zum Mangament der States, also ob Karte umgedreht oder nicht */
  List<GlobalKey<FlipCardState>> getCardStateKeys() {
    List<GlobalKey<FlipCardState>> cardStateKeys =
        new List<GlobalKey<FlipCardState>>();

    for (int i = 0; i < karten.length; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }

    return cardStateKeys;
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /* Falls Daten aus Datenbank vorhanden, Memorykarten laden, sonst Ladescreen */
    if (karten == [] || karten == null) {
      return Scaffold(body: Ladescreen());
    } else {
      return _isFinished
          ? Scaffold(
              body: Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      restart();
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 200,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text(
                      "Replay",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                title: Text(widget.title + " - Memory"),
                backgroundColor: Color(0xffe54b4b),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
                          child: Column(children: [
                            /* Aufgabe des Memoryspiels */
                            Row(
                              children: [
                                Icon(FlutterIcons.feedback_mdi,
                                    size: 20, color: Color(0xffe54b4b)),
                                SizedBox(width: 10),
                                Flexible(
                                    child: Text(widget.aufgabe,
                                        textAlign: TextAlign.justify,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3)),
                              ],
                            ),
                            SizedBox(height: 20),
                            Container(
                                /* Falls Starttimer noch nicht abgelaufen, 
                                CountDownTimer anzeigen sonst übrige Paare anzeigen */
                                child: !_start
                                    ? countDownTimer()
                                    : Row(
                                        children: [
                                          Icon(
                                            FlutterIcons.apps_mdi,
                                            color: Color(0xffe54b4b),
                                          ),
                                          SizedBox(width: 10),
                                          Text("Paare Übrig: $_paareUebrig",
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3),
                                        ],
                                      )),
                          ])),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          /* Memorykarten */
                          itemBuilder: (context, index) => _start
                              ? FlipCard(
                                  key: _cardStateKeys[index],
                                  onFlip: () {
                                    if (!_flip) {
                                      _flip = true;
                                      _previousIndex = index;
                                    } else {
                                      _flip = false;
                                      if (_previousIndex != index) {
                                        /* Prüft, ob Karten zusammengehören */
                                        if (karten[_previousIndex].paarID !=
                                            karten[index].paarID) {
                                          _wait = true;
                                          /* Karten wieder umdrehen, falls Karten nicht zusammengehören */
                                          Future.delayed(
                                              const Duration(
                                                  milliseconds: 1500), () {
                                            _cardStateKeys[_previousIndex]
                                                .currentState
                                                .toggleCard();
                                            _previousIndex = index;
                                            _cardStateKeys[_previousIndex]
                                                .currentState
                                                .toggleCard();

                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 160), () {
                                              setState(() {
                                                _wait = false;
                                              });
                                            });
                                          });
                                        } else {
                                          /* Aktualisieren, der Liste welche Paare bereits gefunden worden sind */
                                          _cardFlips[_previousIndex] = false;
                                          _cardFlips[index] = false;
                                          print(_cardFlips);

                                          setState(() {
                                            _paareUebrig -= 1;
                                          });
                                          /* Falls alle Paare gefunden worden sind, Spiel beenden */
                                          if (_cardFlips
                                              .every((t) => t == false)) {
                                            _timer.cancel();
                                            if (_summePunkte < 50) {
                                              _summePunkte = 50;
                                            }
                                            print("Won");
                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 160), () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    // Dialog nach Beenden des Spiels
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text("Glückwunsch!",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xffe54b4b))),
                                                    content: Text(
                                                        "Du hast alle Paare richtig zugeordnet.\nDeine Punktzahl: $_summePunkte"),
                                                    actions: <Widget>[
                                                      new FlatButton(
                                                        child: new Text(
                                                            "Ohne Speichern beenden"),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop(true);
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                      new FlatButton(
                                                        child: new Text(
                                                            "Speichern und beenden"),
                                                        onPressed: () async {
                                                          // erfahrungspunkte = sumPunkte;
                                                          Navigator.of(context)
                                                              .pop(true);

                                                          Navigator.of(context)
                                                              .pop();
                                                          await savePoint();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            });
                                          }
                                        }
                                      }
                                    }
                                    setState(() {});
                                  },
                                  /* Verhalten der Memorykarten */
                                  flipOnTouch:
                                      _wait ? false : _cardFlips[index],
                                  direction: FlipDirection.HORIZONTAL,
                                  /* Umgedrehte Karte */
                                  front: Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffe54b4b),
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 0.5,
                                            spreadRadius: 0.3,
                                            offset: Offset(2.0, 1),
                                          )
                                        ]),
                                    margin: EdgeInsets.all(4.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Icon(FlutterIcons.help_outline_mdi,
                                          size: 35, color: Color(0xffffffff)),

                                      /* Image.asset(
                                          "assets/icons/Quiz_gelb_Icon.png",
                                          fit: BoxFit.fill), */
                                    ),
                                  ),
                                  /* Aufgedeckte Karte */
                                  back: getItem(index))
                              : getItem(index),
                          itemCount: karten.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
    }
  }

  //Punkte speichern
  Future<void> savePoint() async {
    var param = "?benutzerID=" +
        widget.benutzerID.toString() +
        "&lernKategorieID=" +
        widget.lernKategorieID.toString() +
        "&erfahrungspunkte=" +
        _summePunkte.toString() +
        "&lernortID=" +
        widget.lernortID.toString() +
        "&memoryID=" +
        widget.memoryID.toString();
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
        showtext1 = "Glückwunsch!\nDu hast das Höchstlevel erreicht" +
            "\nDeine Belohnung: ...";
      } else {
        showtext1 =
            "Glückwunsch! Du Hast Level ${calculateLevel(jsonData['total_point_new'])} erreicht! \nDeine Belohnung:";
        showtext2 =
            "\nDu benötigst noch ${pointsNeededForNextLevel(jsonData['total_point_new'])} Punkte für Level ${calculateLevel(jsonData['total_point_new']) + 1}";

        belohnungsid = belohnung(
            calculateLevel(jsonData['total_point_new']), widget.benutzerID);
      }

      /* Dialog für Levelaufstieg */
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:
                Text("Level Up!", style: TextStyle(color: Color(0xffe54b4b))),
            content: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text(showtext1),
                    SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      "assets/avatar/nachIDs/$belohnungsid.png",
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
  // ignore: unused_local_variable
  final response = await http.get(url);
}
