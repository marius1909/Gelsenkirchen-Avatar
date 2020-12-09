import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/quiz/quizpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LearnQuiz extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LearnQuizState();
  }
}

class LearnQuizState extends State<LearnQuiz> {
  List data = [];
  void loadLernort() async {
    var url = "http://zukunft.sportsocke522.de/list_lernort.php";

    var res = await http.get(url);

    if (jsonDecode(res.body) == "Datensatz existiert nicht") {
    } else {
      setState(() {
        data = jsonDecode(res.body);
      });
    }
  }

  @override
  void initState() {
    //TODO: implement initState
    super.initState();
    loadLernort();
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
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Multiple Choice Quiz"),
        ),
        body: Center(
          child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: MaterialButton(
                        height: 50.0,
                        color: Colors.blueGrey,
                        onPressed: () {
                          //Navigator.of(context).push(MaterialPageRoute(
                          //  builder: (context) => QuizPage(1)));
                        },
                        child: new Text(
                          data[index]["name"],
                          style: new TextStyle(
                              fontSize: 18.0, color: Colors.white),
                        )),
                  ),
                );
              }),
        ),
      );
    }
  }
}
