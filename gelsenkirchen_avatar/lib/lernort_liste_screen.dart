import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/lernort_screen.dart';
import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LernortListeScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Lernorte'),
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        FlatButton(
          textColor: Colors.white,
          color: Colors.blue,
          onPressed: () {
            testquery();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => LernortScreen()));
          },
          child: Text('Beispiel-Lernort'),
        ),
        FlatButton(
          textColor: Colors.white,
          color: Colors.grey,
          /*Aktion beim Drücken des Buttons muss noch ergänzt werden, wenn
          entsprechender Screen fertig ist. Codestück zum Springen in nächsten
          Screen beim Drücken des Button im nächsten Kommentar schon vorhanden.*/
          onPressed: () {
            testquery();
            //Folgende Meldung dient nur zum Testen
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Testmeldung'),
                  content: Text(
                      "Testmethode testinsert() wurde aufgerufen. Datensatz wurde aus der Datenbank gelesen und in der Konsole ausgegeben."),
                );
              },
            );
            /*Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ScreenName()));*/
          },
          child: Text('PHP-Skript testen'),
        )
      ])),
    );
  }
}

void testquery() async {
  var url = "http://zukunft.sportsocke522.de/getLernorte.php";
  var res = await http.get(url);

  //folgender Block wäre nötig um was in DBzu schreiben
  /* var data = {
    "email": "testemail",
    "benutzername": "testname",
    "passwort": "testpasswort",
  };
  var res = await http.post(url, body: data); */

  print(jsonDecode(res.body));

  /* if (jsonDecode(res.body) == "Account existiert bereits") {
    Fluttertoast.showToast(
        msg: "Der Benutzer existiert bereits", toastLength: Toast.LENGTH_SHORT);
  } else {
    if (jsonDecode(res.body) == "true") {
      Fluttertoast.showToast(
          msg: "Benutzer erstellt", toastLength: Toast.LENGTH_SHORT);
    } else {
      Fluttertoast.showToast(msg: "error", toastLength: Toast.LENGTH_SHORT);
    }
  } */
}
