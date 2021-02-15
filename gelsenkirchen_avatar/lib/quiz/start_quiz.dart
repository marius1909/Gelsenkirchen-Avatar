import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';
import 'package:gelsenkirchen_avatar/quiz/quizpage.dart';
import 'package:http/http.dart' as http;
import 'package:imagebutton/imagebutton.dart';

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
            backgroundColor: Color(0xffff9f1c),
            title: Text(
              //Name von aktuellen Lernort
              data['name'] + " - Quiz",
            ),
          ),
          body: Column(children: [
            Container(
              padding: EdgeInsets.fromLTRB(15, 40, 15, 40),
              child: Text(
                "Quiz",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Ccaps",
                    fontSize: 35.0,
                    color: Color(0xffff9f1c)),
              ),
            ),

            Container(
              //padding: EdgeInsets.all(15.0),
              padding: EdgeInsets.fromLTRB(15, 0, 15, 40),
              child: Text(
                "Ein Spiel besteht aus 10 Fragen mit je 4 Antwortmöglichkeiten, von denen jeweils nur eine richtig ist. Für die Beantwortung einer Frage steht ein Zeitfenster von 30 Sekunden zu Verfügung. Zum Auswählen der gewünschten Antwort muss der Teilnehmer auf das jeweilige Antwortfeld klicken. Anschließend werden die Ergebnisse unten links auf dem Bildschirm angezeigt. Je mehr Fragen Sie beantworten, desto schwieriger werden sie. Je schwieriger die Frage ist, desto mehr Punkte erhalten Sie für die richtige Antwort. Wenn Sie eine falsche Antwort geben, werden Ihrem Konto keine Punkte hinzugefügt. Ziel des Spiels ist es, so viele Fragen wie möglich korrekt zu beantworten und die Belohnungen zu gelangen.",
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            SizedBox(height: 40),

            //Belohnungen-Button (wird nicht mehr benötigt)
/*             Padding(
              padding: EdgeInsets.symmetric(vertical: 1),
              child: Container(
                  width: double.infinity,
                  //Wrap with Material
                  child: Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    clipBehavior: Clip.antiAlias,
                    child: MaterialButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        )),
                  )),
            ), */

            ImageButton(
                children: <Widget>[],
                /* 302 x 91 sind die Originalmaße der Buttons */
                width: 302 / 1.3,
                height: 91 / 1.3,
                paddingTop: 5,
                /* PressedImage gibt ein Bild für den Button im gedrückten 
                    Zustand an. Bisher nicht implementiert, muss aber mit dem
                    Bild im normalen zustand angegeben werden. */
                pressedImage: Image.asset(
                  "assets/buttons/Spielen_gelb_groß.png",
                ),
                unpressedImage:
                    Image.asset("assets/buttons/Spielen_gelb_groß.png"),
                onTap: () {
                  if (Benutzer.current?.id != null) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => QuizPage(
                              quizID: int.parse(data['quizID']),
                              benutzerID: Benutzer.current.id,
                              lernKategorieID: int.parse(data['kategorieID']),
                              lernortID: int.parse(data['id']),
                              title: data['name'],
                            )));
                  } else {
                    Fluttertoast.showToast(
                        msg: "Bitte melde dich an, um dieses Spiel zu spielen.",
                        toastLength: Toast.LENGTH_SHORT);
                  }
                })
          ]));
    }
  }
}
