import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/Avatar.dart';
import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:imagebutton/imagebutton.dart';

// ignore: must_be_immutable
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

//TODO: (nicht bis S&T machbar) avatarTyp und ausgerüstete Collectables aus Datenbank laden

  //Typ des Avatars (1= Blau 2 = Gelb usw)
  int avatarTypID = 0;

  //Collectablesanpassung als ID (zurzeit 0 bis 7)
  int ausgeruesteteCollectablesID = 0;

//Default wird zurerst geladen damit kein error wenn Profil aufgerufen wird
  Image avatar = Image.asset(Avatar(0, 0).imagePath, width: 250, height: 250);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('Avatar auswählen'),
        ),
        body: Stack(children: [
          /* BILD */
          Container(
            //padding: EdgeInsets.fromLTRB(15, 40, 15, 10),
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image:
                        new AssetImage("assets/images/Profil_Hintergrund.png"),
                    fit: BoxFit.cover)),
          ),
          SingleChildScrollView(
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
                    SizedBox(height: 50),
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
                        "assets/buttons/Speichern_dunkelblau_groß.png",
                      ),
                      unpressedImage: Image.asset(
                          "assets/buttons/Speichern_dunkelblau_groß.png"),
                      onTap: () {
                        /* TODO: (nicht bis S&T machbar) Ausgewählten Avatar in DB Speichern (Lisa) */
                      },
                    ),
                  ],
                ),
              )
            ],
          ))
        ]));
  }
}
