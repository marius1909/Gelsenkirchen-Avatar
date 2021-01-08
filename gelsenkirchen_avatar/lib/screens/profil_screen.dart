import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';
import 'package:gelsenkirchen_avatar/data/freigeschaltet.dart';
import 'package:gelsenkirchen_avatar/screens/errungenschaften_screen.dart';
import 'package:gelsenkirchen_avatar/screens/profil_bearbeiten_screen.dart';
import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';

/*TODO: Richtiges Benutzerlevel laden
  TODO: Anzahl an Errungenschaften laden
*/

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  String spielername = "";
  int level = 0;
  int anzahlErrungenschaften = 0;

  @override
  Widget build(BuildContext context) {
    //wird immer wieder gecalled warum?
    //loadName();
    // loadErrungenschaften();

    print("Reload warum?");

    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('Profil'),
          //centerTitle: true,
          elevation: 0.0,
        ),
        body: Padding(
            padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Name',
                          style:
                              TextStyle(color: Colors.grey, letterSpacing: 1.8),
                        ),
                        SizedBox(height: 10.0),
                        new Text(
                          spielername,
                          style: TextStyle(
                            letterSpacing: 1.8,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 40.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Level',
                          style:
                              TextStyle(color: Colors.grey, letterSpacing: 1.8),
                        ),
                        SizedBox(height: 10.0),
                        /* TODO: Level des Spielers anzeigen (Lisa) */
                        Text(
                          level.toString(),
                          style: TextStyle(
                            letterSpacing: 1.8,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 40.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Errungenschaften',
                          style:
                              TextStyle(color: Colors.grey, letterSpacing: 1.8),
                        ),
                        SizedBox(height: 10.0),
                        new Text(
                          anzahlErrungenschaften.toString(),
                          style: TextStyle(
                            letterSpacing: 1.8,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Divider(
                  height: 50.0,
                  color: Colors.grey[800],
                ),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/profilbild.jpg'),
                  radius: 100,
                ),
                SizedBox(height: 10),
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
                          builder: (context) => ProfilBearbeiten()),
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
                )
              ],
            )));
  }

  String getText() {
    return spielername;
  }

/*
Lädt den Namen aus der DB um ihm im Screen anzuzeigen. 

TODO: Zeigt derzeit BENUTZER 0!
*/
  Future<void> loadName() async {
    var alleBenutzerFuture = await Benutzer.shared.gibObjekte();

    setState(() {
      spielername = alleBenutzerFuture[0].benutzer;
      //DUMMY
      level = 12;
    });
  }

/* TODO: Placeholderfunktion um den Avatar zu laden und im Profil anzeigen zu lassen */

  Future<void> loadAvatar() async {
    var alleBenutzerFuture = await Benutzer.shared.gibObjekte();

    setState(() {
      //Avatar
    });
  }

/*

TODO: Level laden
Lädt die Errungenschaften 
*/
  Future<void> loadErrungenschaften() async {
    var alleBenutzerFuture = await Benutzer.shared.gibObjekte();
    var freigeschalteteErrungenschaften =
        await Freigeschaltet.shared.gibObjekte();

    for (int i = 0; i < freigeschalteteErrungenschaften.length; i++) {}

    setState(() {
      //DUMMY
      anzahlErrungenschaften = 12;
    });
  }
}
