import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:gelsenkirchen_avatar/screens/anmeldung_screen.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_validator/email_validator.dart';
import 'package:imagebutton/imagebutton.dart';

class Registrierung extends StatefulWidget {
  @override
  _RegistrierungState createState() => _RegistrierungState();
}

class _RegistrierungState extends State<Registrierung> {
  TextEditingController namectrl, emailctrl, passctrl, validatepassctrl;
  final _formKey = GlobalKey<FormState>();

  bool processing = false;

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
      "benutzername": namectrl.text,
      "passwort": passctrl.text,
    };

    var res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "Account existiert bereits") {
      Fluttertoast.showToast(
          msg: "Der Benutzer existiert bereits",
          toastLength: Toast.LENGTH_SHORT);
    } else {
      if (jsonDecode(res.body) == "true") {
        Fluttertoast.showToast(
            msg: "Benutzer erstellt", toastLength: Toast.LENGTH_SHORT);
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
        title: Text('Registrieren'),
        /*Farbcode in Hexadezimal*/
        backgroundColor: Color(0xfff2a03d),
      ),
      body: Form(
          key: _formKey,
          child: ListView(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Zuerst brauchen wir ein paar Infos von dir:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(
                    height: 30,
                  ),

                  /*BENUTZERNAME*/

                  TextFormField(
                    decoration: new InputDecoration(
                      /*Labeltext*/
                      labelText: "Gib einen Benutzernamen ein",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Bitte gib einen Benutzernamen an';
                      }
                      return null;
                    },
                    controller: namectrl,
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  /*EMAIL*/
                  TextFormField(
                    decoration: new InputDecoration(
                      /*Labeltext*/
                      labelText: "Gib deine Email-Adresse ein",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Bitte gib eine gültige Email Adresse an';
                      }
                      if (EmailValidator.validate(value)) {
                        return null;
                      }

                      //Die Textzeile ist zu lang um angezeigt zu werden.*/
                      return 'Bitte gib eine Email-Adresse im Format sample@example.com. ein';
                    },
                    keyboardType: TextInputType.emailAddress,
                    controller: emailctrl,
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  /*PASSWORT*/
                  TextFormField(
                    decoration: new InputDecoration(
                      /*Labeltext*/
                      labelText: "Gib ein Passwort ein",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Bitte gib ein Passwort an.';
                      }

                      passwortvalue = value;

                      return null;
                    },
                    controller: passctrl,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  /*PASSWORT WIEDERHOLEN*/
                  TextFormField(
                    decoration: new InputDecoration(
                      /*Labeltext*/
                      labelText: "Wiederhole das Passwort",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                    controller: validatepassctrl,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Bitte gib ein Passwort ein.';
                      }
                      if (value != passwortvalue) {
                        return 'Die Passwörter stimmen nicht überein.';
                      }

                      return null;
                    },
                    obscureText: true,
                  ),
                  SizedBox(height: 40),
                  ImageButton(
                    children: <Widget>[],
                    width: 302,
                    height: 91,
                    paddingTop: 5,
                    pressedImage: Image.asset(
                      "assets/buttons/Registrieren_dunkelblau_groß.png",
                    ),
                    unpressedImage: Image.asset(
                        "assets/buttons/Registrieren_dunkelblau_groß.png"),
                    onTap: () {
                      print('test');
                    },
                  ),
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
                              builder: (BuildContext context) => Anmeldung()));
                    },
                    child: Text(
                      "Du bist schon registriert? Hier geht's zur Anmeldung.",
                    ),
                  ),
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
