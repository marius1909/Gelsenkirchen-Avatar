import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
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

  List<String> auswaehlbareAvatare = new List();
  List<List<int>> auswaehlbareAvatarePathIDs = new List();

  List<int> ausgewahlterAvatarPathIDs = [0];
  bool antwortErhalten = false;

  @override
  void initState() {
    super.initState();

    //Basisavatare laden
    auswaehlbareAvatare.add(Avatar.getDefaultImagePath(0));
    auswaehlbareAvatare.add(Avatar.getDefaultImagePath(1));
    auswaehlbareAvatare.add(Avatar.getDefaultImagePath(2));
    auswaehlbareAvatare.add(Avatar.getDefaultImagePath(3));
    auswaehlbareAvatarePathIDs.add([0]);
    auswaehlbareAvatarePathIDs.add([1]);
    auswaehlbareAvatarePathIDs.add([2]);
    auswaehlbareAvatarePathIDs.add([3]);
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
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Column(
                  children: [
                    CarouselSlider.builder(
                      itemCount: auswaehlbareAvatare.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(6.0),
                          child: Image.asset(auswaehlbareAvatare[index],
                              height: 300),
                        );
                      },
                      /* Slider-Eigenschaften */
                      options: CarouselOptions(
                          height: 250,
                          enlargeCenterPage: true,
                          autoPlay: false,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          viewportFraction: 0.6,
                          onPageChanged: (index, reason) {
                            setState(() {
                              ausgewahlterAvatarPathIDs =
                                  auswaehlbareAvatarePathIDs[index];
                            });
                          }),
                    ),
                    SizedBox(height: 10),
                    Icon(
                      FlutterIcons.arrow_upward_mdi,
                      size: 60,
                      color: Color(0xff0d4dbb),
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
                      onTap: () async {
                        Avatar.setAvatarFromPathIDs(
                                Benutzer.current.id, ausgewahlterAvatarPathIDs)
                            .then((bool result) {
                          setState(() {
                            print(result);
                            antwortErhalten = result;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        HomeScreen()));
                          });
                        });
                      },
                    ),
                  ],
                ),
              )
            ],
          ))
        ]));
  }

  Future<bool> ladeAsyncDaten() async {
    return true;
  }
}
