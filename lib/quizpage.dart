import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';

class QuizPage extends StatefulWidget {
  final int id;

  QuizPage(this.id);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Widget> punkteBehalten = [];

  Timer _timer;
  int _start = 30;

  int sumPunkte = 0;
  int positionFragen = 0;
  int punkteProFragen = 1;

  List data = [];
  List fragenList;

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

    if (positionFragen == data.length) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => new CupertinoAlertDialog(
          title: new Text("Finished"),
          content: new Text("Final Score: $sumPunkte"),
          actions: [
            CupertinoDialogAction(
              child: new Text("End"),
              onPressed: () => {
                Navigator.of(context).pop(true),
                Navigator.of(context).pop()
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

  void quizFragen() async {
    var quizid = widget.id;
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

  //Time
  void displayDialog(String title) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text("TIME'S UP"),
        content: new Text(title),
        actions: [
          CupertinoDialogAction(
            //yes -> play continue -> answer wrong(because they didn't answer)
            child: new Text("Yes"),
            onPressed: () {
              Navigator.of(context).pop(true);
              checkAnswer("aghdhgfahsdfhj");
            },
          ),
          CupertinoDialogAction(
            //no -> cancel game -> back to menu
            child: new Text("No"),
            onPressed: () =>
                {Navigator.of(context).pop(true), Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }

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

  void timerReset() {
    timerCancel();
    startTimer();
  }

  void timerCancel() {
    _timer.cancel();
    _start = 30;
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
              margin: const EdgeInsets.all(10.0),
              alignment: Alignment.topCenter,
              child: Center(child: CircularProgressIndicator())));
    } else {
      return Scaffold(
        body: new Container(
          margin: const EdgeInsets.all(5.0),
          alignment: Alignment.topCenter,
          child: new Column(
            children: <Widget>[
              //aktuelle Frage + Punkte
              new Padding(padding: EdgeInsets.all(5.0)),
              Expanded(
                child: Padding(
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
              ),

              //Zeit
              new Padding(padding: EdgeInsets.all(5.0)),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
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
              ),
              //Frage
              new Padding(padding: EdgeInsets.all(1.0)),
              Expanded(
                flex: 2,
                child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.blueAccent[400],
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
                        Navigator.pushReplacementNamed(context, '/');
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
}
