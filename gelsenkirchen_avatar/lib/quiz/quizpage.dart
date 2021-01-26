import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';

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
  final List<Widget> punkteBehalten = [];

  Timer _timer;

  //Erst testen mit 10sec
  int _start = 10;

  int sumPunkte = 0;
  int positionFragen = 0;
  int punkteProFragen = 1;
  List data = [];
  List fragenList;
  int erfahrungspunkte;
  int level;

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
        startTimer();
      });
    }
  }

  //set Time
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start == 1) {
            setState(() {
              timer.cancel();
              displayDialog("Do you want to continue?");
            });
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

//Benachrichtigung erhalten, wenn Zeit abgelaufen ist

  void displayDialog(String title) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text("TIME'S UP"),
        content: new Text(title),
        actions: [
          CupertinoDialogAction(
            //yes -> spielen weiter mit nächsten Frage -> Antwort von aktuellen Fragen ist automatisch falsch(keine Antwort bekommen)
            child: new Text("Yes"),
            onPressed: () {
              Navigator.of(context).pop(true);
              checkAnswer("aghdhgfahsdfhj");
            },
          ),
          CupertinoDialogAction(
            //no -> nicht weiter spielen -> zurück zur vorherigen Seite
            child: new Text("No"),
            onPressed: () =>
                {Navigator.of(context).pop(true), Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }

  void timerReset() {
    timerCancel();
    startTimer();
  }

  void timerCancel() {
    _timer.cancel();
    _start = 10;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void initState() {
    // TODO: implement initState
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
          title: Text(widget.title),
        ),
        body: new Container(
          margin: const EdgeInsets.only(top: 1),
          alignment: Alignment.topCenter,
          child: new Column(
            children: <Widget>[
              //aktuelle Frage + Punkte
              new Padding(padding: EdgeInsets.all(5.0)),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Container(
                  alignment: Alignment.centerRight,
                  child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text("Question ${positionFragen + 1}",
                            style: new TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w700)),
                        new Text(
                          "Score: $sumPunkte",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ]),
                ),
              ),
              //Zeit
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Center(
                    child: Text(
                      "$_start",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
              ),
              //Frage
              new Padding(padding: EdgeInsets.all(5.0)),
              Expanded(
                flex: 2,
                child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.blue[400],
                      ),
                      child: Center(
                        child: Text(
                          data[positionFragen]['frage'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    )),
              ),
              //Antwort 1
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          textColor: Colors.white,
                          color: Colors.blue[400],
                          child: Text(
                            data[positionFragen]['antwort'][0],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              checkAnswer(data[positionFragen]['antwort'][0]);
                            });
                          },
                        ),
                      ),
                    ),
                    //Antwort 2
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          textColor: Colors.white,
                          color: Colors.blue[400],
                          child: Text(
                            data[positionFragen]['antwort'][1],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
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
              //Antwort 3
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          textColor: Colors.white,
                          color: Colors.blue[400],
                          child: Text(
                            data[positionFragen]['antwort'][2],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              checkAnswer(data[positionFragen]['antwort'][2]);
                            });
                          },
                        ),
                      ),
                    ),
                    //Antwort 4
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          textColor: Colors.white,
                          color: Colors.blue[400],
                          child: Text(
                            data[positionFragen]['antwort'][3],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
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
              //Quit-Button
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: new MaterialButton(
                      minWidth: 240.0,
                      height: 30.0,
                      color: Colors.red[300],
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: new Text(
                        "Quit",
                        style:
                            new TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),

              //Icons
              Expanded(
                child: Row(
                  children: punkteBehalten,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  //prüfen ob Antwort richtig oder falsch war
  void checkAnswer(String value) {
    if (data[positionFragen]['antwort'][4] == value) {
      punkteBehalten.add(Icon(Icons.check, color: Colors.green));
      sumPunkte = sumPunkte + positionFragen * 2 + punkteProFragen;
    } else {
      punkteBehalten.add(Icon(Icons.close, color: Colors.red));
    }
    positionFragen++;
    punkteProFragen++;
    timerReset();
//wenn keine Frage mehr...
    if (positionFragen == data.length) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => new CupertinoAlertDialog(
          title: new Text("Finished"),
          content: new Text("Final Score: $sumPunkte"),
          actions: [
            CupertinoDialogAction(
              child: new Text("Exit Game"),
              onPressed: () => {
                Navigator.of(context).pop(true),
                Navigator.of(context).pop()
              },
            ),
            CupertinoDialogAction(
              child: new Text("Save Your Score"),
              onPressed: () async {
                erfahrungspunkte = sumPunkte;
                Navigator.of(context).pop(true);
                await savePoint();
              },
            ),
          ],
        ),
      );
      _timer.cancel();
      positionFragen = 0;
      punkteProFragen = 1;
    }
  }

////Punkte speichern
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
      Fluttertoast.showToast(msg: "Success", toastLength: Toast.LENGTH_SHORT);
    } else {
      Fluttertoast.showToast(msg: "Error", toastLength: Toast.LENGTH_SHORT);
    }

    //Benachrichtigung werden angezeigt, wenn Level von Spieler aufgestiegen wird

    if (CalculatorLevel(jsonData['total_point_new']) >
        CalculatorLevel(jsonData['total_point_old'])) {
      String showtext;
      if (CalculatorPointLevelUp(jsonData['total_point_new']) == -1) {
        showtext = "You have reached max level";
      } else {
        showtext =
            "You still need ${CalculatorPointLevelUp(jsonData['total_point_new'])} points for Level ${CalculatorLevel(jsonData['total_point_new']) + 1}";
      }
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => new CupertinoAlertDialog(
          title: Center(
            child: RichText(
              text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 30),
                  children: <TextSpan>[
                    TextSpan(
                        text: "Level Up",
                        style:
                            TextStyle(color: Colors.red, fontFamily: 'Langar'))
                  ]),
            ),
          ),
          content: Column(
            children: [
              Text("Your Reward ..."),
              Padding(padding: EdgeInsets.only(top: 20)),
              Text(showtext),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              child: new Text("Back"),
              onPressed: () {
                Navigator.of(context).pop(true);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    } else {
      Navigator.of(context).pop();
    }
  }

//Level von Spieler
  int CalculatorLevel(total_point) {
    if (total_point >= 0 && total_point <= 29) {
      return 1;
    } else if (total_point >= 30 && total_point <= 50) {
      return 2;
    } else if (total_point >= 51 && total_point <= 85) {
      return 3;
    } else if (total_point >= 86 && total_point <= 145) {
      return 4;
    } else if (total_point >= 146 && total_point <= 247) {
      return 5;
    } else if (total_point >= 248 && total_point <= 420) {
      return 6;
    } else if (total_point >= 421 && total_point <= 714) {
      return 7;
    } else if (total_point >= 715 && total_point <= 1214) {
      return 8;
    } else if (total_point >= 1215) {
      return 9;
    }
  }

//Berechnet, wie viele Punktzahl Spieler benötigt, um das nächse Level zu erreichen
  int CalculatorPointLevelUp(total_point) {
    if (total_point >= 0 && total_point <= 29) {
      return 30 - total_point;
    } else if (total_point >= 30 && total_point <= 50) {
      return 51 - total_point;
    } else if (total_point >= 51 && total_point <= 85) {
      return 86 - total_point;
    } else if (total_point >= 86 && total_point <= 145) {
      return 146 - total_point;
    } else if (total_point >= 146 && total_point <= 247) {
      return 248 - total_point;
    } else if (total_point >= 248 && total_point <= 420) {
      return 421 - total_point;
    } else if (total_point >= 421 && total_point <= 714) {
      return 715 - total_point;
    } else if (total_point >= 715 && total_point <= 1214) {
      return 1215 - total_point;
    } else if (total_point >= 1215) {
      return -1;
    }
  }
}
