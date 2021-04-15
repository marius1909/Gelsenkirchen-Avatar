import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/memorykarte.dart';
import 'dart:async';
import 'package:gelsenkirchen_avatar/widgets/ladescreen.dart';
import 'package:gelsenkirchen_avatar/widgets/utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:flutter_advanced_networkimage/provider.dart';

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
  int _time = 8;
  int _paareUebrig;
  bool _isFinished;
  List<Memorykarte> karten;
  int _erfahrungspunkte;
  int _summePunkte;
  bool laedt = true;

  List<bool> _cardFlips;
  List<GlobalKey<FlipCardState>> _cardStateKeys;

  /* Erstellt den Kartenrücken abhängig vom kartenInhalt */
  Widget getItem(int index) {
    String kartenInhalt = karten[index].kartenInhalt;
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey[100],
            boxShadow: [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 3,
                spreadRadius: 0.8,
                offset: Offset(2.0, 1),
              )
            ],
            borderRadius: BorderRadius.circular(5)),
        margin: EdgeInsets.all(4.0),
        child: karten[index].kartentyp == 1
            ?
            // CachedNetworkImage(
            //     imageUrl: kartenInhalt,
            //     placeholder: (context, kartenInhalt) => Ladescreen(),
            //     errorWidget: (context, kartenInhalt, error) =>
            //         new Icon(Icons.error),
            //   )
            Image.network(kartenInhalt, fit: BoxFit.fill)
            // AdvancedNetworkImage(kartenInhalt, useDiskCache: true)
            : Container(
                alignment: Alignment.center,
                child: Text(
                  kartenInhalt,
                  textAlign: TextAlign.center,
                )));
  }

  /* Starten des Timers */
  startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (!_disposed)
        setState(() {
          _time = _time - 1;
          _summePunkte = _summePunkte - 5;
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
    startTimer();
    karten.shuffle();
    _cardFlips = getInitialItemState();
    _cardStateKeys = getCardStateKeys();
    _time = 8;
    _paareUebrig = (karten.length ~/ 2);

    _isFinished = false;
    /* Zeit bis zum Umdrehen der Karten */
    Future.delayed(const Duration(seconds: 8), () {
      if (!_disposed)
        setState(() {
          _start = true;
          // _timer.cancel();
        });
    });
  }

  // Future ladeBilder() async {
  //   setState(() {
  //     laedt = true;
  //   });

  //   await Future.wait(karten.map((karte) {
  //     if (karte.kartentyp == 1) Utils.cacheImage(context, karte.kartenInhalt);
  //   }).toList());

  //   setState(() {
  //     laedt = false;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _erfahrungspunkte = widget.erfahrungspunkte;
    _summePunkte = _erfahrungspunkte;
    getMemorykarten().then((memory) {
      if (!_disposed)
        setState(() {
          karten = memory;
          // ladeBilder();

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
                backgroundColor: Color(0xff093582),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Text(widget.aufgabe,
                          style: Theme.of(context).textTheme.headline1),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: _time > 0
                            ? Text(
                                '$_time',
                                style: Theme.of(context).textTheme.headline3,
                              )
                            : Text(
                                'Paare Übrig: $_paareUebrig',
                                style: Theme.of(context).textTheme.headline3,
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
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
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text("Glückwunsch!",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xffff9f1c))),
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
                                                          // TODO: Muss noch um Funktion zum Speichern der Punkte ergänzt werden (Alex)
                                                          Navigator.of(context)
                                                              .pop();
                                                          await savePoint();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );

                                              // setState(() {
                                              //   _isFinished = true;
                                              //   _start = false;
                                              // });
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
                                  front: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black45,
                                            blurRadius: 3,
                                            spreadRadius: 0.8,
                                            offset: Offset(2.0, 1),
                                          )
                                        ]),
                                    margin: EdgeInsets.all(4.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Image.asset(
                                          "assets/icons/Quiz_gelb_Icon.png",
                                          fit: BoxFit.fill),
                                    ),
                                  ),
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
      String showtext;
      if (pointsNeededForNextLevel(jsonData['total_point_new']) == -1) {
        /* TODO: (nicht bis S&T machbar) Belohnung anzeigen */
        showtext = "Glückwunsch!\nDu hast höchstes Level erreicht" +
            "\nDeine Belohnung: ...";
      } else {
        showtext =
            "Du benötigst noch ${pointsNeededForNextLevel(jsonData['total_point_new'])} Punkte für Level ${calculateLevel(jsonData['total_point_new']) + 1}";
      }

      /* Dialog für Levelaufstieg */
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:
                Text("Level Up!", style: TextStyle(color: Color(0xffff9f1c))),
            content: Text(showtext),
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                  Navigator.of(context).pop();
                },
              ),
            ],
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
