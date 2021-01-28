import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/Avatar.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';

import 'map_screen.dart';

class HomeScreen extends StatelessWidget {
  final String spielername = Benutzer.current.benutzer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /* drawer für den Menü-Button statt dem Zurück-Button */
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('GElernt!'),
        ),
        body: Stack(children: <Widget>[
          MapScreen(),
          Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
                //color: Color(0xffe54b4b),
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            margin: EdgeInsets.only(
                left: 10.0, top: 40.0, right: 10.0, bottom: 0.0),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                /* TODO: Auf dem Homescreen richtigen Avatar anzeigen, der dem Profil zugeordnet ist (Lisa) */
                /* TODO: Durch Klick auf Avatar soll man zum Profil gelangen (Lisa) */
                child: Image.asset(Avatar(0, 0).imagePath,
                    width: 100, height: 100),
              ),
              /* TODO: Unter dem Name soll ein Balken für das Level angezeigt werden (Lisa) */
              /* TODO: Name soll aus der DB geholt und angezeigt werden. */
              Text(
                spielername,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.headline1,
              ),
            ],
          ),
          /* TODO: Levelanzeige. (Wird außerdem noch im Profil gebraucht) (Lisa) */
          /* Die Levelanzeige hab ich aus Zeitgründen und für die Screenshots
          für das Show & Tell Plakat etwas unschön implementiert.
          Sie sollte später noch so platziert werden, dass sie auch auf andern
          Displays richtig angezeit wird. */
          Container(
              padding: EdgeInsets.fromLTRB(143, 85, 20, 20),
              child: LinearPercentIndicator(
                width: 200,
                lineHeight: 22,
                percent: 0.7,
                backgroundColor: Color(0xff0d4dbb),
                progressColor: Color(0xff2d75f0),
                //leading: Text("Level 1 "),
                center: Text(
                  "Level 1",
                  style: TextStyle(color: Colors.white),
                ),
              ))
        ]));
  }
}
