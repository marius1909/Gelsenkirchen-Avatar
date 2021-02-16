import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/Avatar.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';
import 'package:gelsenkirchen_avatar/data/freigeschaltet.dart';
import 'package:gelsenkirchen_avatar/screens/errungenschaften_screen.dart';
import 'package:gelsenkirchen_avatar/screens/profil_bearbeiten_screen.dart';
import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gelsenkirchen_avatar/data/loadInfo.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Avatarauswahl extends StatefulWidget {
  // ignore: non_constant_identifier_names
  int id_user;

  Avatarauswahl(this.id_user);

  @override
  _AvatarauswahlState createState() => _AvatarauswahlState();
}

class _AvatarauswahlState extends State<Avatarauswahl> {
  String spielername = "";
  int level = 0;
  int anzahlErrungenschaften = 0;

//TODO: avatarTyp und ausgerüsteteCollectables aus Datenbank laden

  //Typ des Avatars (1= Blau 2 = Gelb usw)
  int avatarTypID = 0;

  //Collectablesanpassung als ID (zurzeit 0 bis 7)
  int ausgeruesteteCollectablesID = 0;

//Default wird zurerst geladen damit kein error wenn Profil aufgerufen wird
  Image avatar = Image.asset(Avatar(0, 0).imagePath, width: 250, height: 250);

  @override
  void initState() {
    super.initState();
    List<Freigeschaltet> a =
        loadInfo.getFreigeschalteteErrungenschaften(widget.id_user);
    setState(() {
      level = 0;
    });
    Benutzer.shared.gibObjekte().then((alleBenutzer) async {
      setState(() {
        spielername = loadInfo.loadName(alleBenutzer, widget.id_user);
        anzahlErrungenschaften = a.length;

        avatar = loadInfo.loadUserAvatarImage(
            widget.id_user, avatarTypID, ausgeruesteteCollectablesID);
      });

      int levelTemp = await loadInfo.loadUserLevel(widget.id_user);
      //BROKEN
      setState(() {
        level = levelTemp;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('Avatar auswählen'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
                padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
                child: Flexible(
                  child: Text("Zu Beginn, wähle bitte deinen Avatar aus:",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline3),
                )),
            Container(
              padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Column(
                children: [
                  CarouselSlider(
                    items: [
                      //1. Bild im Slider
                      Container(
                        margin: EdgeInsets.all(6.0),
                        child: Image.asset(Avatar(0, 0).imagePath),
                      ),

                      //2. Bild im Slider
                      Container(
                        margin: EdgeInsets.all(6.0),
                        child: Image.asset(Avatar(1, 0).imagePath),
                      ),

                      //3. Bild im Slider
                      Container(
                        margin: EdgeInsets.all(6.0),
                        child: Image.asset(Avatar(2, 0).imagePath),
                      ),

                      //4. Bild im Slider
                      Container(
                        margin: EdgeInsets.all(6.0),
                        child: Image.asset(Avatar(3, 0).imagePath),
                      ),
                    ],

                    //Slider Eigenschaften
                    options: CarouselOptions(
                      height: 300,
                      enlargeCenterPage: true,
                      autoPlay: false,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 0.6,
                    ),
                  ),
                  /* TODO: Speichern-Button austauschen. In Bearbeitung von Lisa (Lisa) */
                  FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(8.0),
                    splashColor: Colors.blueAccent,
                    onPressed: () {
                      /* TODO: Avatar-Speichern-Funktion (Lisa) */
                    },
                    child: Text(
                      "Speichern",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            )
          ],
        )));
  }