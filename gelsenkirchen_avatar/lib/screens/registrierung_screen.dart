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
            msg: "Registrierung erfolgreich", toastLength: Toast.LENGTH_SHORT);
      } else {
        Fluttertoast.showToast(
            msg: "Registrierung fehlgeschlagen",
            toastLength: Toast.LENGTH_SHORT);
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
        /*Farbcode in Hexadezimal: Vor dem Hexadezimalcode "0xff" schreiben*/
        backgroundColor: Color(0xff0B3E99),
      ),
      body: Form(
          key: _formKey,
          child: ListView(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Zuerst brauchen wir ein paar Infos von dir:",
                      style: Theme.of(context).textTheme.headline3),
                  SizedBox(
                    height: 50,
                  ),

                  /*BENUTZERNAME*/

                  TextFormField(
                    decoration: new InputDecoration(
                      /*Prompt*/
                      labelText: "Benutzername",
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
                      /*Prompt*/
                      labelText: "Email",
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
                      /*Prompt*/
                      labelText: "Passwort",
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
                      /*Prompt*/
                      labelText: "Passwort wiederholen",
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
                    /* 302 x 91 sind die Originalmaße der Buttons */
                    width: 302 / 1.3,
                    height: 91 / 1.3,
                    paddingTop: 5,
                    /* PressedImage gibt ein Bild für den Button im gedrückten 
                    Zustand an. Bisher nicht implementiert, muss aber mit dem
                    Bild im normalen zustand angegeben werden. */
                    pressedImage: Image.asset(
                      "assets/buttons/Registrieren_dunkelblau_groß.png",
                    ),
                    unpressedImage: Image.asset(
                        "assets/buttons/Registrieren_dunkelblau_groß.png"),
                    onTap: () {
                      var valid = _formKey.currentState.validate();
                      if (!valid) {
                        return;
                      }

                      benutzerRegistrierung();
                    },
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
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: FlatButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Anmeldung()));
          },
          child: Text(
            "Du bist schon registriert? \n Hier geht's zur Anmeldung.",
            textAlign: TextAlign.center,
          ),
        ),
        elevation: 0,
      ),
    );
  }
}
