import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz/quizpage.dart';

class LearnQuiz extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LearnQuizState();
  }
}

class LearnQuizState extends State<LearnQuiz> {
  List data = [];

  void LoadLernort() async {
    print("LoadLernort");
    var url = "http://zukunft.sportsocke522.de/list_lernort.php";

    var res = await http.get(url);

    if (jsonDecode(res.body) == null) {
      print("error");
    } else {
      print("success");

      setState(() {
        data = jsonDecode(res.body);
      });
    }

    print("done");
  }

  @override
  void initState() {
    // TODO: implement initState
    print("initState");
    super.initState();
    LoadLernort();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
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
          backgroundColor: Colors.blue,
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
                        color: Colors.blue[50],
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  QuizPage(int.parse(data[index]["id"]))));
                        },
                        child: new Text(
                          data[index]["name"],
                          style: new TextStyle(
                            fontSize: 18.0,
                          ),
                        )),
                  ),
                );
              }),
        ),
      );
    }
  }
}
