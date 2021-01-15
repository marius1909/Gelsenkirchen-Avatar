import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';
import 'package:gelsenkirchen_avatar/screens/rank_kategorie_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScoreBoard extends StatefulWidget {
  int id_user;

  ScoreBoard(this.id_user);

  @override
  _ScoreBoardState createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  dynamic data;
  int total_point;
  int level;

  Future<void> LernKategories() async {
    var url = "http://zukunft.sportsocke522.de/user_score_level.php?id=" +
        widget.id_user.toString();
    var res = await http.get(url);
    if (jsonDecode(res.body) == "Datensatz existiert nicht") {
      print('Datensatz nicht gefunden');
    } else {
      setState(() {
        data = jsonDecode(res.body)['data'];
        total_point = jsonDecode(res.body)['total_point'];
        level = jsonDecode(res.body)['level'];
        print(data);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LernKategories();
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
          /*NAME*/
          title: Text("Scoreboard for QUIZ"),
        ),
        body: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      children: <TextSpan>[
                        TextSpan(text: "Congratulations, "),
                        TextSpan(
                            text: " ${Benutzer.current.benutzer == null || Benutzer.current.benutzer == "" ? Benutzer.current.email : Benutzer.current.benutzer}! ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        children: <TextSpan>[
                          TextSpan(text: "You have reached level "),
                          TextSpan(
                              text: level.toString(),
                              style: TextStyle(color: Colors.red)),
                          TextSpan(text: " with total score: "),
                          TextSpan(
                              text: total_point.toString(),
                              style: TextStyle(color: Colors.red)),
                          //TextSpan(text: " score"),
                        ]),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 6.0,
                    clipBehavior: Clip.antiAlias,
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              child: Text(
                            data[index]['name'].toString(),
                            style: TextStyle(fontSize: 16.0),
                          )),
                          Spacer(),
                          Container(
                            child: Text(
                              " Your Score : " +
                                  data[index]['erfahrungspunkte'].toString(),
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    RankKategorieScreen(
                                        int.parse(data[index]['id']),
                                        widget.id_user,
                                        data[index]['name'].toString())));
                      },
                    ),
                  ),
                );
              },
              padding: EdgeInsets.all(0.0),
            ))
          ],
        ),
      );
    }
  }
}
