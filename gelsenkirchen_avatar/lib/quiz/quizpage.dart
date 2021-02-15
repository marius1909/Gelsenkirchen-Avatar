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
              /* displayDialog(
                  "Du bekommst für diese Frage leider keine Punkte. \n Möchtest du weiterspielen?"); */
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
        title: new Text("Die Zeit ist abgelaufen"),
        content: new Text(title),
        actions: [
          CupertinoDialogAction(
            //yes -> spielen weiter mit nächsten Frage -> Antwort von aktuellen Fragen ist automatisch falsch(keine Antwort bekommen)
            child: new Text("Ja"),
            onPressed: () {
              Navigator.of(context).pop(true);
              checkAnswer("aghdhgfahsdfhj");
            },
          ),
          CupertinoDialogAction(
            //no -> nicht weiter spielen -> zurück zur vorherigen Seite
            child: new Text("Nein"),
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
                      Icon(FlutterIcons.arrow_up_faw5s,
                          size: 20, color: Color(0xff98ce00)),
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
                        color: Color(0xffff9f1c),
                      ),
                      SizedBox(width: 10),
                      Text("Punktzahl: $sumPunkte",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline3),
                    ],
                  )
                ])),

            /* new Padding(padding: EdgeInsets.all(5.0)),
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
              ), */

            /* ZEIT */
            CircularCountDownTimer(
              duration: 31,
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

            /* Alte Zeitangabe */
            /* Expanded(
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
            ), */

            /* FRAGE */
            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 30),
              child: Text(
                data[positionFragen]['frage'],
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            /* new Padding(padding: EdgeInsets.all(5.0)),
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
              ), */

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

            /* BEEDEN - BUTTON */
            /* Expanded(
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
                      style: new TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ), */

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
    _controller.restart(duration: 31);
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
