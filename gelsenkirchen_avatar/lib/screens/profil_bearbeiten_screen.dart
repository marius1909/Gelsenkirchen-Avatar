import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';

import 'avatarbearbeiten_screen.dart';

class ProfilBearbeiten extends StatefulWidget {
  int id_user;

  ProfilBearbeiten(this.id_user);

  @override
  _ProfilBearbeitenState createState() => _ProfilBearbeitenState();
}

class _ProfilBearbeitenState extends State<ProfilBearbeiten> {
  String aktuellerName = "";
  String nameSchonVergebenTextMessage = "";
  bool nameSchonVergeben = false;
  TextEditingController neuerNameController = new TextEditingController();
  bool initComplete = false;
  AssetImage avatar;

  @override
  void initState() {
    super.initState();
    Benutzer.shared.gibObjekte().then((alleBenutzer) {
      loadName(alleBenutzer);
      loadAvatar(alleBenutzer);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profil bearbeiten'),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Padding(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Aktueller Name',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              letterSpacing: 1.8),
                        ),
                        SizedBox(height: 10.0),
                        Text(aktuellerName),
                        SizedBox(height: 15.0),
                        Text(
                          'Neuer Name',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              letterSpacing: 1.8),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 200,
                              child: TextFormField(
                                controller: neuerNameController,
                              ),
                            ),
                            new IconButton(
                                icon: Icon(Icons.check_box),
                                onPressed: () =>
                                    aendereName(neuerNameController.text)),
                            Text(
                              nameSchonVergebenTextMessage,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
                      child: IconButton(
                        icon: Icon(Icons.edit, color: Colors.white),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
                SizedBox(height: 100),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: avatar,
                      radius: 50,
                    ),
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.black),
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
                SizedBox(height: 100),
                FlatButton(
                  color: Colors.blue[800],
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.black,
                  onPressed: () {},
                  child: Text(
                    "Speichern",
                    style: TextStyle(fontSize: 25.0),
                  ),
                )
              ],
            )));
  }

/* Lädt namen aus der Datenbank um ihn im Screen anzuzeigen
*/

  void loadName(List<Benutzer> alleBenutzer) {
    setState(() {
      aktuellerName = alleBenutzer.firstWhere((benutzer) {
        return benutzer.id == widget.id_user;
      }).benutzer;
    });
  }

/*Funktion zum ändern des Benutzernamens
TODO: Neuen Namen in Datenbank speichern php

Geht alle Benutzernamen in der DB durch und prüft ob schon vergeben
Wenn schon vergeben wird setState nicht aufgerufen
*/

  Future<void> aendereName(String name) async {
    var alleBenutzerFuture = await Benutzer.shared.gibObjekte();
    for (int i = 0; i < alleBenutzerFuture.length; i++) {
      if (name == alleBenutzerFuture[i].benutzer) {
        setState(() {
          nameSchonVergeben = true;
        });
      }
    }

    if (!nameSchonVergeben) {
      //Speicher neuen Namen in Datenbank TODO!

      setState(() {
        aktuellerName = name;
        nameSchonVergebenTextMessage = "";
        nameSchonVergeben = false;
      });
    } else {
      setState(() {
        nameSchonVergebenTextMessage = "Name schon \n vergeben";

        nameSchonVergeben = false;
      });
    }
  }

//Placeholder methode um Avatar zu laden
  void loadAvatar(List<Benutzer> alleBenutzer) {
    setState(() {
      avatar = AssetImage("assets/avatar/500px/DerBlaue_500px.png");
    });
  }
}
