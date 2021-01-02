import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/lernort.dart';
import 'package:gelsenkirchen_avatar/quiz/start_quiz.dart';
import 'package:imagebutton/imagebutton.dart';
import 'package:gelsenkirchen_avatar/screens/lernen_screen.dart';

class LernortScreen extends StatelessWidget {
  final Lernort l;

  LernortScreen({Key key, @required this.l}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomInset: false,
        //drawer: NavDrawer(),
        appBar: AppBar(
          /*NAME*/
          title: Text(l.name),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          /*TITELBILD*/
          /*TODO: Bild muss hier noch das Titelbild des entsprechenden Lernortes eingefügt werden.
          Dieses Bild dient als Platzhalter*/
          Container(
              child: Image.asset(
                  'assets/images/lernortPlaceholderTitelbild.jpg',
                  fit: BoxFit.fill)),
          SizedBox(height: 30),

          /*KATEGORIE*/
          /*Todo: - Hier muss noch der Kategoriename anstatt die KategorieId eingefügt werden
                  - linksbündig*/
          Container(
            child: Text("Kategorie: " + l.kategorieID.toString(),
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headline3),
            margin:
                EdgeInsets.only(left: 30.0, top: 0.0, right: 30.0, bottom: 0.0),
            alignment: Alignment(-1.0, 0.0),
          ),
          SizedBox(height: 10),

          /*ADRESSE*/
          /*Todo: - Hier muss noch die Adresse angegeben werden
                  - linksbündig*/
          Container(
            child: Text(
              "Adresse: ",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headline3,
            ),
            margin:
                EdgeInsets.only(left: 30.0, top: 0.0, right: 30.0, bottom: 0.0),
            alignment: Alignment(-1.0, 0.0),
          ),
          SizedBox(height: 10),

          /*ÖFFNUNGSZEITEN*/
          /*Todo: - Hier müssen noch die Öffnungszeiten angegeben werden
                  - linksbündig*/
          Container(
            child: Text(
              "Öffnungszeiten: ",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headline3,
            ),
            margin:
                EdgeInsets.only(left: 30.0, top: 0.0, right: 30.0, bottom: 0.0),
            alignment: Alignment(-1.0, 0.0),
          ),
          SizedBox(height: 20),

          /*BESCHREIBUNG*/
          Container(
              child: Text(
                l.beschreibung,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyText1,
                //style: TextStyle(fontSize: 17),
              ),
              margin: EdgeInsets.only(
                  left: 30.0, top: 0.0, right: 30.0, bottom: 0.0)),
          SizedBox(height: 40),
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
              "assets/buttons/Lernen_gelb_groß.png",
            ),
            unpressedImage: Image.asset("assets/buttons/Lernen_gelb_groß.png"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Lernen(l: l)));
            },
          ),
          SizedBox(height: 20),
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
              "assets/buttons/Spielen_gruen_groß.png",
            ),
            unpressedImage:
                Image.asset("assets/buttons/Spielen_gruen_groß.png"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => StartQuiz(l.id)));
            },
          ),
        ])));
  }
}
