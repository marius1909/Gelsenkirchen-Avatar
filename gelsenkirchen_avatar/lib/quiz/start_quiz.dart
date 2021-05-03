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

  /* Lädt Daten für den Lernort aus der Datenbank */
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
          body: SingleChildScrollView(
              child: Column(children: [
            /* HEADLINE "QUIZ" */
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

            /* BESCHREIBUNG */
            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 40),
              child: Text(
                "In diesem klassischen Quiz werden dir spezielle Fragen zum Lernort, an dem du dich gerade befindest gestellt. Für die Beantwortung der Fragen hast du jeweils 30 Sekunden Zeit. Um eine Frage zu beantworten, klicke einfach auf die entsprechende Antwort. Ob deine Antwort richtig oder falsch war, siehst du an den roten oder grünen Symbolen am unteren Bildschirmrand. Ein rotes X bedeutet, dass die Antwort leider falsch war und du dafür keine Punkte bekommst. Ein güner Haken bedeutet, die Antwort war richtig und du bekommst eine gewisse Anzahl an Punkten gutgeschrieben.\nDrücke \"Start\" und erfahre wie viel du schon über den Lernort gelernt hast.",
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),

            /* SPIELEN-BUTTON */
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
          ])));
    }
  }
}

