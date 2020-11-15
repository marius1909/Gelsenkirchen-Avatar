import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';
import 'package:gelsenkirchen_avatar/screens/registrierung_screen.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gelsenkirchen_avatar/screens/home_screen.dart';

class Anmeldung extends StatefulWidget {
  @override
  _AnmeldungState createState() => _AnmeldungState();
}

class _AnmeldungState extends State<Anmeldung> {
  TextEditingController namectrl, emailctrl, passctrl;
  bool processing = false;
  Benutzer angemeldeterBenutzer;
  String benutzername;

  @override
  void initState() {
    super.initState();
    emailctrl = new TextEditingController();
    passctrl = new TextEditingController();
  }

  void benutzerLogin() async {
    setState(() {
      processing = true;
    });

    var url = "http://zukunft.sportsocke522.de/anmeldung.php";
    var data = {
      "email": emailctrl.text,
      "passwort": passctrl.text,
    };

    var res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "Account existiert nicht") {
      print("Hallo das existiert nicht");
      Fluttertoast.showToast(
          msg: "Der angegebene Benutzer existiert nicht",
          toastLength: Toast.LENGTH_SHORT);
    } else {
      if (jsonDecode(res.body) == "Falsches Passwort") {
        Fluttertoast.showToast(
            msg: "Falsches Passwort", toastLength: Toast.LENGTH_SHORT);
      } else {
        print(jsonDecode(res.body));
        Map data = jsonDecode(res.body);
        angemeldeterBenutzer = Benutzer(
            id: data['result'][0]['id'],
            benutzername: data['result'][0]['benutzername']);

        // Navigator.pushReplacementNamed(context, '/home',
        //     arguments: angemeldeterBenutzer);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
      }
    }

    setState(() {
      processing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[600],
        body: SafeArea(
            child: ListView(children: [
          Padding(padding: EdgeInsets.fromLTRB(30, 90, 30, 0)),
          Column(children: [
            CircleAvatar(
                backgroundImage: AssetImage('assets/images/wink.png'),
                radius: 130),
            Padding(
                padding: EdgeInsets.fromLTRB(15, 110, 15, 0),
                child: Column(children: [
                  TextFormField(
                      controller: emailctrl,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                                color: Colors.blueGrey[900], width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                                color: Colors.blueGrey[900], width: 2),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          labelText: "Email:",
                          labelStyle:
                              TextStyle(fontSize: 16, color: Colors.black))),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      controller: passctrl,
                      obscureText: true,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                                color: Colors.blueGrey[900], width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                                color: Colors.blueGrey[900], width: 2),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          labelText: "Passwort:",
                          labelStyle:
                              TextStyle(fontSize: 16, color: Colors.black))),
                  SizedBox(height: 40),
                  ButtonTheme(
                      padding: EdgeInsets.fromLTRB(120, 13, 120, 13),
                      child: RaisedButton(
                        onPressed: benutzerLogin,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.blueGrey[900])),
                        color: Colors.blueGrey[800],
                        child: Text(
                          "Anmelden",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[100]),
                        ),
                      )),
                  FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Registrierung()));
                      },
                      child: Text(
                        "Noch kein Account? Hier registrieren",
                        style: TextStyle(
                          color: Colors.grey[100],
                        ),
                      ))
                ]))
          ])
        ])));
  }
}
