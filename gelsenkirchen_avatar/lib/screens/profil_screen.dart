import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';
import 'package:gelsenkirchen_avatar/data/freigeschaltet.dart';
import 'package:gelsenkirchen_avatar/screens/errungenschaften_screen.dart';
import 'package:gelsenkirchen_avatar/screens/profil_bearbeiten_screen.dart';
import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      loadName(alleBenutzer);
      loadUserLevel();
      loadErrungenschaften();
      loadAvatar(alleBenutzer);
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

/*
Lädt den Namen aus der DB um ihm im Screen anzuzeigen. 

TODO: Unsauber gelöst?
*/
  void loadName(List<Benutzer> alleBenutzer) {
    setState(() {
      spielername = alleBenutzer.firstWhere((benutzer) {
        return benutzer.id == widget.id_user;
      }).benutzer;
    });
  }

/* TODO: Placeholderfunktion um den Avatar zu laden und im Profil anzeigen zu lassen */

  void loadAvatar(List<Benutzer> alleBenutzer) {
    setState(() {
      avatar = Image.asset("assets/avatar/500px/DerBlaue_500px.png",
          width: 250, height: 250);
    });
  }

/*

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

  Future<void> loadUserLevel() async {
    var url = "http://zukunft.sportsocke522.de/user_score_level.php?id=" +
        widget.id_user.toString();
    var res = await http.get(url);
    if (jsonDecode(res.body) == "Datensatz existiert nicht") {
      print('Datensatz nicht gefunden');
    } else {
      setState(() {
        level = jsonDecode(res.body)['level'];
      });
    }
  }
}
