import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
          title: Text("Quizmasters"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              //Name von aktuellen Lernort
              Center(
                  child: Container(
                child: Text(
                  data['name'],
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              )),
              //Bilder
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  child: Image.network(
                    'https://img.republicworld.com/republic-prod/stories/promolarge/xxhdpi/wp6ojoyuh6fwdidy_1598513829.jpeg?tr=w-812,h-464',
                  ),
                  height: 170,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black, spreadRadius: 1),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        "Beschreibung des Minispiels bla bla",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
              //Belohnungen-Button
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1),
                child: SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                      color: Colors.orangeAccent,
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
                ),
              ),
              //Starten-Button
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1),
                child: SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                      color: Colors.orangeAccent,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                QuizPage(int.parse(data['quizID']))));
                      },
                      child: Text(
                        "Starten",
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      )),
                ),
              ),
              //Zurück-Button
              Padding(
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
              ),
            ],
          ),
        ),
      );
    }
  }
}
