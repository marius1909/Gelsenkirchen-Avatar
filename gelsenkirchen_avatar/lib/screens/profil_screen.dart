import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/Avatar.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';
import 'package:gelsenkirchen_avatar/data/freigeschaltet.dart';
import 'package:gelsenkirchen_avatar/widgets/ladescreen.dart';
import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'avatarbearbeiten_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
  TODO: (nicht bis S&T machbar) Anzahl an Errungenschaften laden
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
  int xp = 0;
  double prozent = 0;
  int level = 0;
  int anzahlErrungenschaften;
  TextEditingController namectrl;
  bool isEditable = false;

  List<String> alleFreigeschaltetenErrungenschaften = new List();

  //Typ des Avatars (1= Blau 2 = Gelb usw)
  int avatarTypID = 0;

  //Collectablesanpassung als ID (zurzeit 0 bis 7)
  int ausgeruesteteCollectablesID = 0;

//Default wird zurerst geladen damit kein error wenn Profil aufgerufen wird
  Image avatar;

//Variable um Ladescreen zu steuern
  var _asyncResult;

  @override
  void initState() {
    super.initState();

    ladeAsyncDaten().then((result) {
      setState(() {
        _asyncResult = result;
      });
    });

    namectrl = new TextEditingController();
    avatar =
        Image.asset(Avatar.getDefaultImagePath(0), width: 250, height: 250);
    List<Freigeschaltet> a = new List();
    Freigeschaltet.shared.gibObjekte().then((alleErrungenschaften) async {
      for (var i = 0; i < alleErrungenschaften.length; i++) {
        if (alleErrungenschaften[i].benutzerID == 9) {
          a.add(alleErrungenschaften[i]);
        }
      }
    });

    setState(() {
      level = 0;
    });
    Benutzer.shared.gibObjekte().then((alleBenutzer) async {
      //int levelTemp = await LoadInfo.loadUserLevel(widget.userID);Rausgenommen um durch den Benutzer auszutauschen der schon runtergeladen ist
      int xp = Benutzer.current.erfahrung;
      //BROKEN
      setState(() {
        level = berechneLevel(xp);
        prozent = berechnelvlProzent(xp);
      });
    });
  }

  /* Ändern des Namens im Zwischenspeicher */
  void changeSharedPreferences(String name) async {
    Map<String, dynamic> storedBenutzer = Map<String, dynamic>();

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    storedBenutzer = jsonDecode(sharedPreferences.getString("benutzer"));

    storedBenutzer["benutzer"] = name;

    sharedPreferences.setString("benutzer", jsonEncode(storedBenutzer));

    Benutzer.shared.setCurrent(storedBenutzer);
  }

  @override
  Widget build(BuildContext context) {
    alleFreigeschaltetenErrungenschaften.add(Avatar.getDefaultImagePath(0));
    if (_asyncResult == null) {
      return Ladescreen();
    } else {
      return Scaffold(
          drawer: NavDrawer(),
          appBar: AppBar(
            title: Text('Profil'),
          ),
          body: Stack(children: [
            /* BILD */
            Container(
              //padding: EdgeInsets.fromLTRB(15, 40, 15, 10),
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      image: new AssetImage(
                          "assets/images/Profil_Hintergrund.png"),
                      fit: BoxFit.cover)),
            ),
            SingleChildScrollView(
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
                          Flexible(
                              child: !isEditable
                                  ? Text(
                                      Benutzer.current.benutzer,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "Ccaps",
                                          fontSize: 35.0,
                                          color: Color(0xff0b3e99)),
                                    )
                                  : TextFormField(
                                      initialValue: spielername,
                                      autofocus: true,
                                      textInputAction: TextInputAction.done,
                                      onFieldSubmitted: (value) {
                                        setState(() => {
                                              isEditable = false,
                                              spielername = value,
                                              Benutzer.shared
                                                  .updateDatabaseWithID(
                                                      "benutzer",
                                                      value,
                                                      widget.userID),
                                              changeSharedPreferences(value)
                                            });
                                      })),
                          IconButton(
                            icon: Icon(
                              FlutterIcons.edit_faw5s,
                              color: Color(0xff999999),
                              size: 15,
                            ),
                            onPressed: () {
                              setState(() => {
                                    isEditable = true,
                                  });
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
                                  percent: prozent,
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
                          Text(
                              "Deine Errungenschaften: " +
                                  (anzahlErrungenschaften).toString(),
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
                      CarouselSlider.builder(
                          itemCount:
                              alleFreigeschaltetenErrungenschaften.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(6.0),
                              child: Image.asset(
                                  alleFreigeschaltetenErrungenschaften[index],
                                  height: 300),
                            );
                          },
                          options: CarouselOptions(
                            height: 100,
                            enlargeCenterPage: true,
                            autoPlay: false,
                            aspectRatio: 16 / 9,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            viewportFraction: 0.3,
                          ))

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
            ))
          ]));
    }
  }

  String getText() {
    return spielername;
  }

  Future<bool> ladeAsyncDaten() async {
    avatar = Image.asset(await Avatar.getImagePath(Benutzer.current.id),
        width: 250, height: 250);

    alleFreigeschaltetenErrungenschaften =
        await Avatar.getAlleErrungenschaftenPath(Benutzer.current.id);
    anzahlErrungenschaften = alleFreigeschaltetenErrungenschaften.length;
    return true;
  }
}

int berechneLevel(int xp) {
  int lvl = 0;
  if (xp < 30) {
    lvl = 1;
  } else if (xp < 51) {
    lvl = 2;
  } else {
    int minxp = 51;
    minxp = (minxp.toDouble() * 1.7).toInt();
    lvl = 3;
    while (xp >= minxp) {
      minxp = (minxp.toDouble() * 1.7).toInt();
      lvl++;
    }
  }
  return lvl;
}

double berechnelvlProzent(int xp) {
  double prozent = 0.0;
  if (xp < 30) {
    prozent = xp / 30;
  } else if (xp < 51) {
    prozent = (xp - 30) / (51 - 30);
  } else {
    int minxp = 51;
    int maxxp = (minxp.toDouble() * 1.7).toInt();
    prozent = (xp - minxp) / (maxxp - minxp);
    while (xp >= maxxp) {
      minxp = maxxp;
      maxxp = (minxp.toDouble() * 1.7).toInt();
      prozent = (xp - minxp) / (maxxp - minxp);
    }
  }
  return prozent;
}
