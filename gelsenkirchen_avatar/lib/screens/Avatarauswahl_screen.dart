import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/Avatar.dart';
import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:imagebutton/imagebutton.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';

import 'home_screen.dart';

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

  @override
  void initState() {
    print(Benutzer.current.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("auswahl");
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('Avatar auswählen'),
        ),
        body: Stack(children: [
          /* BILD */
          Container(
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
                child: Text("Zu Beginn, wähle bitte deinen Avatar aus:",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline3),
              ),
              /* SLIDER MIT BASISAVATAREN */
              Container(
                padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                child: Column(
                  children: [
                    CarouselSlider(
                      items: [
                        FlatButton(
                          onPressed: () {
                            Avatar.setAvatarFromPathIDs(
                                Benutzer.current.id, [0]);
                          },
                          child: Container(
                            margin: EdgeInsets.all(6.0),
                            child: Image.asset(Avatar.getDefaultImagePath(0),
                                height: 300),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            Avatar.setAvatarFromPathIDs(
                                Benutzer.current.id, [1]);
                          },
                          child: Container(
                            margin: EdgeInsets.all(6.0),
                            child: Image.asset(Avatar.getDefaultImagePath(1),
                                height: 300),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            Avatar.setAvatarFromPathIDs(
                                Benutzer.current.id, [2]);
                          },
                          child: Container(
                            margin: EdgeInsets.all(6.0),
                            child: Image.asset(Avatar.getDefaultImagePath(2),
                                height: 300),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            Avatar.setAvatarFromPathIDs(
                                Benutzer.current.id, [3]);
                          },
                          child: Container(
                            margin: EdgeInsets.all(6.0),
                            child: Image.asset(Avatar.getDefaultImagePath(3),
                                height: 300),
                          ),
                        )
                      ],

                      /* Slider-Eigenschaften */
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    HomeScreen()));
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
