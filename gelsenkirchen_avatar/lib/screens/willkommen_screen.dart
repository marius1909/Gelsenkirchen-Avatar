import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';
import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';
import 'package:imagebutton/imagebutton.dart';
import 'avatarauswahl_screen.dart';

class WillkommenScreen extends StatelessWidget {
  final String spielername = Benutzer.current.benutzer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('GElernt!'),
        ),
        body: Stack(children: [
          /* BILD */
          Container(
            //padding: EdgeInsets.fromLTRB(15, 40, 15, 10),
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new AssetImage(
                        "assets/images/Foerderturm_Hintergrund.png"),
                    fit: BoxFit.cover)),
          ),
          SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /* WILLKOMMEN - HEADLINE */
              Container(
                padding: EdgeInsets.fromLTRB(15, 40, 15, 10),
                child: Text(
                  "Willkommen bei",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Ccaps",
                      fontSize: 35.0,
                      color: Color(0xff0b3e99)),
                ),
              ),
              /* LOGO */
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Image.asset('assets/images/Gesamtlogo_xxhdpi.png',
                    width: 250, fit: BoxFit.fill),
              ),
              SizedBox(height: 40),

              /* HEADLINE */
              Text(
                "GElernt! ist DIE Education-App für Gelsenkirchen!",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(height: 25),

              /* BESCHREIBUNG */
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 50),
                child: Text(
                    'Hier kannst du jede Menge interessante Lernorte in ganz Gelsenkirchen entdecken und erkunden und dabei viele spannende Sachen über Naturwissenschaften, Geschichte, Kultur und vieles mehr lernen. Dein neu erlangtes Wissen kannst du anschließend in spaßigen Minispielen wie einem Quiz, einem Memoryspiel und einem interaktiven QR-Suchspiel auf die Probe stellen. Mit jedem neuen Level, dass du durchs Spielen freischalten kannst, erhälst du coole Items, mit denen du deinen Avatar aufhübschen und individualisieren kannst.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1),
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
                    "assets/buttons/LosGehts_dunkelblau_groß.png",
                  ),
                  unpressedImage: Image.asset(
                      "assets/buttons/LosGehts_dunkelblau_groß.png"),
                  /* Weiterleiten zur Avatarauswahl */
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                Avatarauswahl(Benutzer.current.id)));
                  })
            ],
          ))
        ]));
  }
}
