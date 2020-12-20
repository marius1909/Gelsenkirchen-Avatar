import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:gelsenkirchen_avatar/screens/anmeldung_screen.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_validator/email_validator.dart';

class Registrierung extends StatefulWidget {
  @override
  _RegistrierungState createState() => _RegistrierungState();
}

class _RegistrierungState extends State<Registrierung> {
  TextEditingController namectrl, emailctrl, passctrl, validatepassctrl;
  final _formKey = GlobalKey<FormState>();

  bool processing = false;
  int rolleID = 1;

  @override
  void initState() {
    super.initState();
    namectrl = new TextEditingController();
    emailctrl = new TextEditingController();
    passctrl = new TextEditingController();
    validatepassctrl = new TextEditingController();
  }

  void benutzerRegistrierung() async {
    setState(() {
      processing = true;
    });

    var url = "http://zukunft.sportsocke522.de/registrierung.php";
    var data = {
      "email": emailctrl.text,
      "benutzer": namectrl.text,
      "passwort": passctrl.text,
      "rolleID": rolleID.toString()
    };

    var res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "Account existiert bereits") {
      Fluttertoast.showToast(
          msg: "Der Benutzer existiert bereits",
          toastLength: Toast.LENGTH_SHORT);
    } else {
      if (jsonDecode(res.body) == "true") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    WeiterleitenZurAnmeldungScreen()));
      } else {
        Fluttertoast.showToast(msg: "error", toastLength: Toast.LENGTH_SHORT);
      }
    }
    setState(() {
      processing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String passwortvalue;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Registrieren',
        ),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: Form(
          key: _formKey,
          child: ListView(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 80, 15, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Bitte gib ein Benutzernamen an';
                        }
                        return null;
                      },
                      controller: namectrl,
                      decoration: InputDecoration(
                          labelText: "Benutzername:",
                          labelStyle:
                              TextStyle(fontSize: 16, color: Colors.black))),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Bitte gib eine gültige Email Adresse an';
                        }
                        if (EmailValidator.validate(value)) {
                          return null;
                        }

                        return 'Keine gültige Email Adresse im Format sample@example.com.';
                      },
                      controller: emailctrl,
                      decoration: InputDecoration(
                          labelText: "Email:",
                          labelStyle:
                              TextStyle(fontSize: 16, color: Colors.black))),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Bitte gib ein Passwort an.';
                        }

                        passwortvalue = value;

                        return null;
                      },
                      controller: passctrl,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Passwort:",
                          labelStyle:
                              TextStyle(fontSize: 16, color: Colors.black))),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      controller: validatepassctrl,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Bitte gib ein Passwort an.';
                        }
                        if (value != passwortvalue) {
                          return 'Passwörter stimmen nicht überein';
                        }

                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Passwort wiederholen:",
                          labelStyle:
                              TextStyle(fontSize: 16, color: Colors.black))),
                  SizedBox(height: 40),
                  ButtonTheme(
                      padding: EdgeInsets.fromLTRB(145, 13, 145, 13),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.blueGrey[900])),
                      child: RaisedButton(
                        onPressed: () {
                          var valid = _formKey.currentState.validate();
                          if (!valid) {
                            return;
                          }

                          benutzerRegistrierung();
                        },
                        color: Colors.blueGrey[800],
                        child: Text(
                          "Registrieren",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[100]),
                        ),
                      )),
                  FlatButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Anmeldung()));
                      },
                      child: Text(
                        "Bereits registriert? Hier zur Anmeldung",
                        style: TextStyle(
                          color: Colors.blueGrey[900],
                        ),
                      )),
                  FormField(
                    initialValue: false,
                    builder: (FormFieldState formFieldState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!formFieldState.isValid)
                            Text(
                              formFieldState.errorText ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(
                                      color: Theme.of(context).errorColor),
                            ),
                        ],
                      );
                    },
                  )
                ],
              ),
            )
          ])),
    );
  }
}

class WeiterleitenZurAnmeldungScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Text(
                  "Super!",
                  style: TextStyle(fontSize: 40, color: Colors.grey[800]),
                  textAlign: TextAlign.center,
                )),
            Container(
              // color: Colors.red,
              child: Text(
                "Dein Account wurde erfolgreich angelegt",
                style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30),
            Container(
              // color: Colors.blue,
              padding: EdgeInsets.all(100),
              child: Image(
                width: 150,
                height: 150,
                image: AssetImage('assets/images/success.png'),
              ),
            ),
            Container(
              // color: Colors.grey,
              padding: EdgeInsets.fromLTRB(40, 80, 40, 80),
              child: RaisedButton(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Anmeldung()));
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  color: Color(0xff45d6a9),
                  child: Text(
                    "Zur Anmeldung",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            ),
          ],
        ),
      ),
    ));
  }
}
