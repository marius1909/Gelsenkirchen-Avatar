import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/Avatar.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';
import 'package:gelsenkirchen_avatar/data/freigeschaltet.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gelsenkirchen_avatar/screens/profil_screen.dart';

import 'map_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime backbuttonpressedTime;
  var futureBenutzer =
      Benutzer.getBenutzer(Benutzer.current.email, Benutzer.current.passwort);
  final String spielername = Benutzer.current.benutzer;
  final int erfahrung = Benutzer.current.erfahrung;
  int level = 0;
  List freigeschaltetList = List();
  Image aktuellerAvatar;

  void initState() {
    //LoadInfo.testAvatarAenderung();

    /* Bis der richtige Avatar geladen ist, wird der Defautl Avatar angezeigt */
    aktuellerAvatar =
        Image.asset(Avatar.getDefaultImagePath(0), width: 100, height: 100);
    asyncInitState();
    var freigeschaltetFuture = Freigeschaltet.shared.gibObjekte();
    freigeschaltetFuture.then((freigeschaltet) {
      setState(() {
        freigeschaltetList = freigeschaltet
            .where((freigeschaltet) =>
                freigeschaltet.benutzerID == Benutzer.current.id &&
                freigeschaltet.ausgeruestet)
            .toList();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('GElernt!'),
        ),
        body: Stack(children: <Widget>[
          MapScreen(),
          Align(
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                /* HALBTRANSPARENTE BOX OBEN */
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    if (Benutzer.current?.id != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Profil(Benutzer.current.id)));
                    } else {
                      Fluttertoast.showToast(
                          msg: "Bitte melde dich an!",
                          toastLength: Toast.LENGTH_SHORT);
                    }
                  },
                  /* HALBTRANSPARENTE BOX OBEN */
                  child: Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            blurRadius: 20,
                            offset: Offset.zero,
                            color: Colors.grey.withOpacity(0.5))
                      ],
                    ),
                    margin: EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0.0),
                  ),
                ),

                /* SPIELERNAME */
                Container(
                  margin: EdgeInsets.fromLTRB(130.0, 50.0, 10.0, 0.0),
                  child: Text(
                    spielername,
                    style: Theme.of(context).textTheme.headline1,
                    textAlign: TextAlign.center,
                  ),
                ),
                /* LEVELANZEIGE */
                Container(
                    height: 22,
                    width: 200,
                    margin: EdgeInsets.fromLTRB(130.0, 80.0, 10.0, 0.0),
                    child: LinearPercentIndicator(
                        width: 200,
                        lineHeight: 22,
                        percent: berechnelvlProzent(erfahrung),
                        backgroundColor: Color(0xff0d4dbb),
                        progressColor: Color(0xff2d75f0),
                        center: Text(
                          "Level " + berechneLevel(erfahrung).toString(),
                          style: TextStyle(color: Colors.white),
                        ))),

                /* AVATAR */
                Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                    child: aktuellerAvatar),
              ],
            ),
          ),
          WillPopScope(
            onWillPop: onWillPop,
            child: Text(""),
          )
        ]));
  }

  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();

    //bifbackbuttonhasnotbeenpreedOrToasthasbeenclosed
    //Statement 1 Or statement2
    bool backButton = backbuttonpressedTime == null ||
        currentTime.difference(backbuttonpressedTime) > Duration(seconds: 3);

    if (backButton) {
      backbuttonpressedTime = currentTime;
      Fluttertoast.showToast(
          msg: "Doppelt drücken zum Schlißen",
          backgroundColor: Colors.black,
          textColor: Colors.white);
      return false;
    }
    return true;
  }

  //Lädt den aktuell ausgerüsteten Avatar des derzeitigen Benutzers
  void asyncInitState() async {
    aktuellerAvatar = Image.asset(
        await Avatar.getImagePath(Benutzer.current.id),
        width: 100,
        height: 100);
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

void benutzerUpdaten(String name, String passwort) {
  // ignore: unused_local_variable
  int a = 0;
}
