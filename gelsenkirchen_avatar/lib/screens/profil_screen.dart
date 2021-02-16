import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/Avatar.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';
import 'package:gelsenkirchen_avatar/data/freigeschaltet.dart';
import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';
import 'package:gelsenkirchen_avatar/data/loadInfo.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'avatarbearbeiten_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:percent_indicator/percent_indicator.dart';

/*
  TODO: Anzahl an Errungenschaften laden
*/

class Profil extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final int userID;

  Profil(this.userID);

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
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
        LoadInfo.getFreigeschalteteErrungenschaften(widget.userID);
    setState(() {
      level = 0;
    });
    Benutzer.shared.gibObjekte().then((alleBenutzer) async {
      setState(() {
        spielername = LoadInfo.loadName(alleBenutzer, widget.userID);
        anzahlErrungenschaften = a.length;

        avatar = LoadInfo.loadUserAvatarImage(
            widget.userID, avatarTypID, ausgeruesteteCollectablesID);
      });

      int levelTemp = await LoadInfo.loadUserLevel(widget.userID);
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
          title: Text('Profil'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(15, 40, 15, 40),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /* Icon-Button nur da, damit Name zentriert ist */
                      IconButton(
                        icon: Icon(
                          FlutterIcons.edit_faw5s,
                          color: Color(0xff999999).withOpacity(0),
                          size: 15,
                        ),
                        onPressed: () {},
                      ),
                      Text(
                        spielername,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Ccaps",
                            fontSize: 35.0,
                            color: Color(0xff0b3e99)),
                      ),
                      IconButton(
                        icon: Icon(
                          FlutterIcons.edit_faw5s,
                          color: Color(0xff999999),
                          size: 15,
                        ),
                        onPressed: () {
                          /* TODO: Funktionalität zum Ändern des Benutzernamens */
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Container(
                      height: 22,
                      width: 200,
                      color: Colors.blue[50],
                      child: Align(
                          alignment: Alignment(0, 0),
                          child: LinearPercentIndicator(
                              width: 200,
                              lineHeight: 22,
                              /* TODO: Richtigen Fortschritt des Levels anzeigen (Lisa) */
                              percent: 0.7,
                              backgroundColor: Color(0xff0d4dbb),
                              progressColor: Color(0xff2d75f0),
                              center: Text(
                                "Level: " + level.toString(),
                                style: TextStyle(color: Colors.white),
                              ))),
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /* Icon-Button nur da, damit Name zentriert ist */
                      IconButton(
                        icon: Icon(
                          FlutterIcons.edit_faw5s,
                          color: Color(0xff999999).withOpacity(0),
                          size: 15,
                        ),
                        onPressed: () {},
                      ),
                      avatar,
                      /* TODO: Das Icon muss tiefer (Lisa) */
                      IconButton(
                        icon: Icon(
                          FlutterIcons.edit_faw5s,
                          color: Color(0xff999999),
                          size: 15,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Avatarbearbeiten()),
                          );
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 70),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /* "AnzahlErrungenschaften + 4", weil jeder ja von Beginn an 4 zur Auswahl hat */
                      Text(
                          "Deine Errungenschaften: " +
                              (anzahlErrungenschaften + 4).toString(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline3),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  CarouselSlider(
                    /* TODO: Müsste mit allen freigeschalteten Errungenschaften gefüllt werden (Lisa) */
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
                      height: 100,
                      enlargeCenterPage: true,
                      autoPlay: false,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 0.3,
                    ),
                  ),

                  /* FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(8.0),
                    splashColor: Colors.blueAccent,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProfilBearbeiten(widget.id_user)),
                      );
                    },
                    child: Text(
                      "Profil bearbeiten",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(8.0),
                    splashColor: Colors.blueAccent,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ErrungenschaftenScreen()),
                      );
                    },
                    child: Text(
                      "Errungenschaften",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ) */
                ],
              ),
            )
          ],
        )));
  }

  String getText() {
    return spielername;
  }
}
