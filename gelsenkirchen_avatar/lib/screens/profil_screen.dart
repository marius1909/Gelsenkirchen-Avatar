import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';
import 'package:gelsenkirchen_avatar/screens/profil_bearbeiten_screen.dart';

class Profil extends StatelessWidget {
  String spielername;

  @override
  Widget build(BuildContext context) {
    loadName();

    return Scaffold(
        appBar: AppBar(
          title: Text('Profil'),
          centerTitle: true,
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
                          'NAME',
                          style:
                              TextStyle(color: Colors.grey, letterSpacing: 1.8),
                        ),
                        SizedBox(height: 10.0),
                        new Text(
                          //error with spielername
                          "name",
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
                        Text(
                          '8',
                          style: TextStyle(
                            letterSpacing: 1.8,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
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
                  color: Colors.grey[800],
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
                  color: Colors.grey[800],
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: () {
                    print(spielername);
                  },
                  child: Text(
                    "print name",
                    style: TextStyle(fontSize: 20.0),
                  ),
                )
              ],
            )));
  }

  String getText() {
    return spielername;
  }

  Future<void> loadName() async {
    print("s");
    var alleBenutzerFuture = await Benutzer.shared.gibObjekte();
    spielername = alleBenutzerFuture[0].benutzer;
  }
}
