import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/quiz/start_quiz.dart';

class LernortScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Beispiel-Lernort'),
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("In Bearbeitung"),
        RaisedButton.icon(
          textColor: Colors.white,
          color: Colors.blue,

          /*Aktion beim Drücken des Buttons muss noch ergänzt werden, wenn
          entsprechender Screen fertig ist. Codestück zum Springen in nächsten
          Screen beim Drücken des Button im nächsten Kommentar schon vorhanden.*/
          onPressed: () {
            /*Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ScreenName()));*/
          },
          icon: Icon(Icons.book),
          label: Text('Lernen'),
        ),
        RaisedButton.icon(
          textColor: Colors.white,
          color: Colors.blue,

          /*Aktion beim Drücken des Buttons muss noch ergänzt werden, wenn
          entsprechender Screen fertig ist. Codestück zum Springen in nächsten
          Screen beim Drücken des Button im nächsten Kommentar schon vorhanden.*/
          onPressed: () {           
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => StartQuiz(1)));
          },
          icon: Icon(Icons.videogame_asset),
          label: Text('Spielen'),
        ),
      ])),
    );
  }
}
