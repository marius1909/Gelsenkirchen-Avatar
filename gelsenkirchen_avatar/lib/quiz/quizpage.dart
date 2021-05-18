import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_icons/flutter_icons.dart';

class QuizPage extends StatefulWidget {
  final int benutzerID;
  final int lernKategorieID;
  final int lernortID;
  final int quizID;
  final String title;
  QuizPage(
      {this.benutzerID,
      this.lernKategorieID,
      this.lernortID,
      this.quizID,
      this.title});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  CountDownController _controller = CountDownController();
  final List<Widget> punkteBehalten = [];

  int _start = 31;

  int sumPunkte = 0;
  int positionFragen = 0;
  int punkteProFragen = 1;
  List data = [];
  List fragenList;
  int erfahrungspunkte;
  int level;
  
  /* Lädt Daten für Quiz aus der Datenbank */
  void quizFragen() async {
    var quizid = widget.quizID;
    var url = "http://zukunft.sportsocke522.de/quiz.php";
    var body = {"quizID": quizid.toString()};

    var res = await http.post(url, body: body);

    if (jsonDecode(res.body) == "Datensatz existiert nicht") {
      print('Datensatz nicht gefunden');
    } else {
      setState(() {
        data = jsonDecode(res.body);
        print(data);
      });
    }
  }

//Benachrichtigung erhalten, wenn Zeit abgelaufen ist

  void displayDialog(String title) {
    /* Dialog, der erscheint, wenn die Zeit abgelaufen ist */
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Die Zeit ist abgelaufen",
              style: TextStyle(color: Color(0xffff9f1c))),
          content: Text(title),
          actions: <Widget>[
            new FlatButton(
              //ja -> spielen weiter mit nächsten Frage -> Antwort von aktuellen Fragen ist automatisch falsch(keine Antwort bekommen)
              child: new Text("Ja"),
              onPressed: () {
                Navigator.of(context).pop(true);
                checkAnswer("aghdhgfahsdfhj");
              },
            ),
            new FlatButton(
              //nein -> nicht weiter spielen -> zurück zur vorherigen Seite
              child: new Text("Nein"),
              onPressed: () => {
                Navigator.of(context).pop(true),
                Navigator.of(context).pop()
              },
            ),
          ],
        );
      },
    );
  }

  void initState() {
    super.initState();
    quizFragen();
  }

  @override
  Widget build(BuildContext context) {
    if (data == [] || data.length == 0 || data == null) {
      return Scaffold(
          body: new Container(
              margin: const EdgeInsets.all(5.0),
              alignment: Alignment.topCenter,
              child: Center(child: CircularProgressIndicator())));
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title + " - Quiz"),
          backgroundColor: Color(0xffff9f1c),
        ),
        body: Column(
          children: <Widget>[
            /* FRAGENNUMMER UND PUNKTZAHL */
            Container(
                padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
                child: Column(children: [
                  Row(
                    children: [
                      Icon(FlutterIcons.help_outline_mdi,
                          size: 20, color: Color(0xffee8b00)),
                      SizedBox(width: 10),
                      Text("Frage: ${positionFragen + 1}",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline3),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(
                        FlutterIcons.coin_mco,
                        color: Color(0xffee8b00),
                      ),
                      SizedBox(width: 10),
                      Text("Punktzahl: $sumPunkte",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline3),
                    ],
                  )
                ])),

            /* TIMER */
            CircularCountDownTimer(
              duration: _start,
              initialDuration: 0,
              controller: _controller,
              width: MediaQuery.of(context).size.width / 4,
              height: MediaQuery.of(context).size.height / 4,
              ringColor: Colors.grey[300],
              ringGradient: null,
              fillColor: Color(0xffffae3c),
              fillGradient: null,
              backgroundColor: Color(0xffee8b00),
              backgroundGradient: null,
              strokeWidth: 10.0,
              strokeCap: StrokeCap.round,
              textStyle: TextStyle(
                  fontSize: 33.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
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

                displayDialog(
                    "Du bekommst für diese Frage leider keine Punkte. \n Möchtest du weiterspielen?");
              },
            ),

            /* FRAGE */
            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 30),
              child: Text(
                data[positionFragen]['frage'],
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  /* ANTWORT 1 */
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 5, 5, 5),
                      child: RaisedButton(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5)),
                        textColor: Colors.white,
                        color: Color(0xffff9f1c),
                        splashColor: Color(0xffc47300),
                        child: Text(
                          data[positionFragen]['antwort'][0],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          setState(() {
                            checkAnswer(data[positionFragen]['antwort'][0]);
                          });
                        },
                      ),
                    ),
                  ),
                  /* ANTWORT 2 */
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 5, 15, 5),
                      child: RaisedButton(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5)),
                        textColor: Colors.white,
                        color: Color(0xffff9f1c),
                        splashColor: Color(0xffc47300),
                        child: Text(
                          data[positionFragen]['antwort'][1],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          setState(() {
                            checkAnswer(data[positionFragen]['antwort'][1]);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  /* ANTWORT 3 */
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 5, 5, 5),
                      child: RaisedButton(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5)),
                        textColor: Colors.white,
                        color: Color(0xffff9f1c),
                        splashColor: Color(0xffc47300),
                        child: Text(
                          data[positionFragen]['antwort'][2],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          setState(() {
                            checkAnswer(data[positionFragen]['antwort'][2]);
                          });
                        },
                      ),
                    ),
                  ),
                  /* ANTWORT 4 */
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 5, 15, 5),
                      child: RaisedButton(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5)),
                        textColor: Colors.white,
                        color: Color(0xffff9f1c),
                        splashColor: Color(0xffc47300),
                        child: Text(
                          data[positionFragen]['antwort'][3],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          setState(() {
                            checkAnswer(data[positionFragen]['antwort'][3]);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /* ICONS FÜR RICHTIGE ODER FALSCHE ANTWORTEN */
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: punkteBehalten,
              ),
            ),
          ],
        ),
      );
    }
  }

  //prüfen ob Antwort richtig oder falsch war. Wenn richtig -> Punkte bekommen
  void checkAnswer(String value) {
    if (data[positionFragen]['antwort'][4] == value) {
      punkteBehalten.add(Icon(Icons.check, color: Colors.green));
      sumPunkte = sumPunkte + positionFragen * 2 + punkteProFragen;
    } else {
      punkteBehalten.add(Icon(Icons.close, color: Colors.red));
    }
    positionFragen++;
    punkteProFragen++;
    _controller.restart(duration: _start);
    //wenn keine Frage mehr...
    if (positionFragen == data.length) {
      /* Dialog für Beendigung des Quizes */
      /*Punktzahl zeigen und Spieler können Punktzahl speichern, wenn sie wollen*/ 
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Glückwunsch!",
                style: TextStyle(color: Color(0xffff9f1c))),
            content: Text(
                "Du hast alle Fragen beantwortet.\nDeine Punktzahl: $sumPunkte"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Ohne Speichern beenden"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("Speichern und beenden"),
                onPressed: () async {
                  erfahrungspunkte = sumPunkte;
                  Navigator.of(context).pop(true);
                  await savePoint();
                },
              ),
            ],
          );
        },
      );
      _controller.pause();
      positionFragen = 0;
      punkteProFragen = 1;
    }
  }

  //Punkte speichern in der Datenbank 
  Future<void> savePoint() async {
    var param = "?benutzerID=" +
        widget.benutzerID.toString() +
        "&lernKategorieID=" +
        widget.lernKategorieID.toString() +
        "&erfahrungspunkte=" +
        erfahrungspunkte.toString() +
        "&lernortID=" +
        widget.lernortID.toString() +
        "&quizID=" +
        widget.quizID.toString();
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
    /*Level und Belohnungen anzeigen*/ 
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

/* Lädt Daten für die Belohnung aus der Datenbank */
void freischalten(int belohungsid, int benutzer) async {
  var param = "?benutzerID=" +
      benutzer.toString() +
      "&sammelID=" +
      belohungsid.toString();
  var url = "http://zukunft.sportsocke522.de/freischaltungenSetzen.php" + param;
  // ignore: unused_local_variable
  final response = await http.get(url);
}
