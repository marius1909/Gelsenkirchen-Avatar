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

/*
  TODO: Anzahl an Errungenschaften laden
*/

class Profil extends StatefulWidget {
  // ignore: non_constant_identifier_names
  int id_user;

  Profil(this.id_user);

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  String spielername = "";
  int level = 0;
  int anzahlErrungenschaften = 0;

  Image avatar;

  @override
  void initState() {
    super.initState();
    Benutzer.shared.gibObjekte().then((alleBenutzer) {
      setState(() {
        spielername = loadInfo.loadName(alleBenutzer, widget.id_user);
        anzahlErrungenschaften = loadInfo.loadErrungenschaften(alleBenutzer);
        avatar = loadInfo.loadAvatar(alleBenutzer);
      });
      //BROKEN
      setState(() async {
        level = await loadInfo.loadUserLevel(widget.id_user);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                /* TODO: Im Profil richtigen Avatar anzeigen, der dem Profil zugeordnet ist (Lisa) 
                Marius an Lisa: avatar wird nun in loadAvatar geladcen*/
                avatar,
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
                )
              ],
            )));
  }

  String getText() {
    return spielername;
  }
}
