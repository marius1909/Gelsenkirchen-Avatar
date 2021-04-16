import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/Avatar.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';
import 'package:gelsenkirchen_avatar/screens/errungenschaften_screen.dart';
import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';
import 'package:gelsenkirchen_avatar/data/loadInfo.dart';

class Freund extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final Benutzer freund;
  final int level;
  Freund(this.freund, this.level);

  @override
  _FreundState createState() => _FreundState();
}

class _FreundState extends State<Freund> {
  int anzahlErrungenschaften = 0;

//TODO: (nicht bis S&T machbar) avatarTyp und ausgerüsteteCollectables aus Datenbank laden
  //Typ des Avatars (1= Blau 2 = Gelb usw)
  int avatarTypID = 2;

  //Collectablesanpassung als ID (zurzeit 0 bis 7)
  int ausgeruesteteCollectablesID = 0;

//DefaultAvatar wird zurerst geladen damit kein error wenn Profil das erste mal aufgerufen wird
  Image avatar = Image.asset(Avatar(0, 0).imagePath, width: 250, height: 250);

  @override
  void initState() {
    super.initState();
    // Benutzer.shared.gibObjekte().then((alleBenutzer) {
    //   setState(() {
    //     spielername = LoadInfo.loadName(alleBenutzer, widget.id_user);
    //     // anzahlErrungenschaften =
    //     // LoadInfo.getFreigeschalteteErrungenschaften(widget.id_user).length;
    //     avatar = LoadInfo.loadUserAvatarImage(
    //         widget.id_user, avatarTypID, ausgeruesteteCollectablesID);
    //   });
    //   //BROKEN
    //   setState(() async {
    //     level = await LoadInfo.loadUserLevel(widget.id_user);
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text("Freund"),
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
                          widget.freund.benutzer,
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
                        /* Level des Spielers anzeigen */
                        Text(
                          widget.level.toString(),
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
}
