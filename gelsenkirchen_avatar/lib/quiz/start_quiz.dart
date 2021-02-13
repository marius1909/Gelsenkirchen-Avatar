import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';
import 'package:gelsenkirchen_avatar/quiz/quizpage.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class StartQuiz extends StatefulWidget {
  int id;

  StartQuiz(this.id);

  @override
  _StartQuizState createState() => _StartQuizState();
}

class _StartQuizState extends State<StartQuiz> {
  dynamic data;

//  var quiz = new Quiz();
//  @override
//  void initState() {
//    super.initState();
//    var future = Quiz.shared.getQuiz(widget.l.id);
//    future.then((data) {
//      setState(() {
//        quiz = data;
//      });
//    });
//  }
  void getLernort() async {
    var id = widget.id;
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

  void initState() {
    // TODO: implement initState
    super.initState();
    getLernort();
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Scaffold(
          body: new Container(
              margin: EdgeInsets.all(10.0),
              alignment: Alignment.topCenter,
              child: Center(child: CircularProgressIndicator())));
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            //Name von aktuellen Lernort
            data['name'],
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(15, 40, 15, 40),
              child: Text(
                "Quiz",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Ccaps",
                    fontSize: 35.0,
                    color: Color(0xff0b3e99)),
              ),
            ),

            Container(
              padding: EdgeInsets.all(15.0),
              //padding: EdgeInsets.fromLTRB(15, 40, 15, 40),
              child: Text(
                "Ein Spiel besteht aus 10 Fragen mit je 4 Antwortmöglichkeiten, von denen jeweils nur eine richtig ist. Für die Beantwortung einer Frage steht ein Zeitfenster von 30 Sekunden zu Verfügung. Zum Auswählen der gewünschten Antwort muss der Teilnehmer auf das jeweilige Antwortfeld klicken. Anschließend werden die Ergebnisse unten links auf dem Bildschirm angezeigt. Je mehr Fragen Sie beantworten, desto schwieriger werden sie. Je schwieriger die Frage ist, desto mehr Punkte erhalten Sie für die richtige Antwort. Wenn Sie eine falsche Antwort geben, werden Ihrem Konto keine Punkte hinzugefügt. Ziel des Spiels ist es, so viele Fragen wie möglich korrekt zu beantworten und die Belohnungen zu gelangen.",
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),

            //Bilder
            /* Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  child: Image.network(
                    'https://storage.needpix.com/rsynced_images/quiz-2074324_1280.png',
                  ),
                  height: 100,
                  width: double.infinity,
                ),
              ), */
            /* Expanded(
                child: Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: ListView(
                      children: [
                        Text(
                          "Ein Spiel besteht aus 10 Fragen mit je 4 Antwortmöglichkeiten, von denen jeweils nur eine richtig ist. Für die Beantwortung einer Frage steht ein Zeitfenster von 30 Sekunden zu Verfügung. Zum Auswählen der gewünschten Antwort muss der Teilnehmer auf das jeweilige Antwortfeld klicken. Anschließend werden die Ergebnisse unten links auf dem Bildschirm angezeigt. Je mehr Fragen Sie beantworten, desto schwieriger werden sie. Je schwieriger die Frage ist, desto mehr Punkte erhalten Sie für die richtige Antwort. Wenn Sie eine falsche Antwort geben, werden Ihrem Konto keine Punkte hinzugefügt. Ziel des Spiels ist es, so viele Fragen wie möglich korrekt zu beantworten und die Belohnungen zu gelangen.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ), */
            //Belohnungen-Button
            /*Padding(
                padding: EdgeInsets.symmetric(vertical: 1),
                child: Container(
                    width: double.infinity,
                    //Wrap with Material
                    child: Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)),
                      clipBehavior: Clip.antiAlias,
                      child: MaterialButton(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          color: Colors.green[400],
                          /*minWidth: 10.0,
                          height: 35,*/
                          onPressed: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) =>
                                  new CupertinoAlertDialog(
                                title: new Text("Anzeigen der Belohnungen"),
                                content: new Text("Loading....."),
                                actions: [
                                  CupertinoDialogAction(
                                    child: new Text("Yes"),
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Text(
                            "Belohnungen",
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white),
                          )),
                    )),
              ),*/
            //Starten-Button
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1),
              child: Container(
                  width: double.infinity,
                  child: Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    clipBehavior: Clip.antiAlias,
                    child: MaterialButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        color: Colors.green[400],
                        onPressed: () {
                          if (Benutzer.current?.id != null) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => QuizPage(
                                      quizID: int.parse(data['quizID']),
                                      benutzerID: Benutzer.current.id,
                                      lernKategorieID:
                                          int.parse(data['kategorieID']),
                                      lernortID: int.parse(data['id']),
                                      title: data['name'],
                                    )));
                          } else {
                            Fluttertoast.showToast(
                                msg: "Anmeldung fehlt!",
                                toastLength: Toast.LENGTH_SHORT);
                          }
                        },
                        child: Text(
                          "Starten",
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        )),
                  )),
            ),
            //Zurück-Button
            /*Padding(
                padding: EdgeInsets.symmetric(vertical: 1),
                child: SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                      color: Colors.orangeAccent,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Zurück",
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      )),
                ),
              ),*/
          ],
        ),
      );
    }
  }
}
