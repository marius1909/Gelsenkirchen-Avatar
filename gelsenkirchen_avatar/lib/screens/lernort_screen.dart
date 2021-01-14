import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/lernort.dart';
import 'package:gelsenkirchen_avatar/data/lern_kategorie.dart';
import 'package:gelsenkirchen_avatar/quiz/start_quiz.dart';
import 'package:imagebutton/imagebutton.dart';
import 'package:gelsenkirchen_avatar/screens/lernen_screen.dart';

/* TODO: Kategorieicon einfügen */
class LernortScreen extends StatelessWidget {
  final Lernort l;
  final String k;

  LernortScreen({Key key, @required this.l, @required this.k})
      : super(key: key);
  List<LernKategorie> lernKato = List();

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

          Container(child: getWidgetTitelbild(l)),
          /*KATEGORIE*/
          /*TODO: - Hier muss noch der Kategoriename anstatt die KategorieId eingefügt werden */

          Row(children: [
            /* KATEGORIE */
            /* TODO: Kategorieicon anzeigen (Lisa) */
            Text("Abenteuer", style: Theme.of(context).textTheme.bodyText1),
            /* TODO: Kategoriename aus DB anzeigen (Lisa) */
          ]),
          SizedBox(height: 10),

          Row(children: [
            /* ADRESSE */
            Text("Neidenburger Str. 43, 45897 Gelsenkirchen", style: Theme.of(context).textTheme.bodyText1),
            /* TODO: Adresse aus DB anzeigen (Lisa) */
          ]),
          SizedBox(height: 10),

          Row(children: [
            /* ADRESSE */
            Text("Mo - Fr: 7:00 - 21:30 Uhr\nSa: 7:30 - 18:00 Uhr", style: Theme.of(context).textTheme.bodyText1),
            /* TODO: Öffnungszeiten aus DB anzeigen (Lisa) */
          ]),
          SizedBox(height: 10),
          
          /*BESCHREIBUNG*/
          Text(
              '' + l.beschreibung,
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          SizedBox(height: 40),

          Divider(
            height: 50.0,
            color: Colors.grey[800],
          ),
          
          Container(
            child: getWidgetTabs(l, context),
          ),

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
              "assets/buttons/Lernen_blau_groß.png",
            ),
            unpressedImage: Image.asset("assets/buttons/Lernen_blau_groß.png"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Lernen(l: l)));
            },
          ),
          /* SizedBox(height: 20), */
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
              "assets/buttons/Spielen_dunkelblau_groß.png",
            ),
            unpressedImage:
                Image.asset("assets/buttons/Spielen_dunkelblau_groß.png"),
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

Widget getWidgetTitelbild(Lernort l) {
  if (l.titelbild.isEmpty) {
    return new Image.asset('assets/images/lernortPlaceholderTitelbild.jpg',
        fit: BoxFit.fill);
  } else {
    return new Image.network(l.titelbild, fit: BoxFit.fill);
  }
}

Widget getWidgetTabs(Lernort l, BuildContext context) {
  int anzahl = 0;
  bool text = false;
  bool videos = false;
  bool sounds = false;
  bool bilder = false;

  if (!l.beschreibung.isEmpty) {
    anzahl++;
    text = true;
  }
  if (!l.videos.isEmpty) {
    anzahl++;
    videos = true;
  }
  if (!l.sounds.isEmpty) {
    anzahl++;
    sounds = true;
  }
  if (!l.weitereBilder.isEmpty) {
    anzahl++;
    bilder = true;
  }
  if (anzahl > 0) {
    return DefaultTabController(
        length: 4,
        initialIndex: 0,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: TabBar(
                  labelColor: Color(0xffe54b4b),
                  unselectedLabelColor: Color(0xff0b3e99),
                  tabs: [
                    get_TabsTitel(
                      1,
                      true,
                    ),
                    get_TabsTitel(
                      2,
                      true,
                    ),
                    get_TabsTitel(
                      3,
                      true,
                    ),
                    get_TabsTitel(
                      4,
                      true,
                    ),
                  ],
                ),
              ),
              Container(
                  height: 400,
                  decoration: BoxDecoration(
                      /* border: Border(
                          top: BorderSide(color: Colors.grey, width: 0.5)) */),
                  child: TabBarView(children: <Widget>[
                    Container(
                      child: Center(
                        child: Text(
                          l.beschreibung.replaceAll('<br>', '\n'),
                          textAlign: TextAlign.justify,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: getWidgetVideos(l, context),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: getWidgetSound(l, context),
                      ),
                    ),
                    Container(
                        child: Center(
                          child: getWidgetWeitereBilder(l, context),
                        ),
                        height: 400),
                  ]))
            ]));
  }
}
