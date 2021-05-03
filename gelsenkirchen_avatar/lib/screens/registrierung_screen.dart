import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/screens/anmeldung_screen.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_validator/email_validator.dart';
import 'package:imagebutton/imagebutton.dart';
import 'package:gelsenkirchen_avatar/screens/willkommen_screen.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';

class Registrierung extends StatefulWidget {
  @override
  _RegistrierungState createState() => _RegistrierungState();
}

class _RegistrierungState extends State<Registrierung> {
  TextEditingController namectrl, emailctrl, passctrl, validatepassctrl;
  final _formKey = GlobalKey<FormState>();

  bool processing = false;
  int rolleID = 1;
  int erfahrung = 0;

  @override
  void initState() {
    super.initState();
    namectrl = new TextEditingController();
    emailctrl = new TextEditingController();
    passctrl = new TextEditingController();
    validatepassctrl = new TextEditingController();
  }

  /* Nach Validation, Anlegen des neuen Benutzer mit den angegeben Daten in Datenbank */
  void benutzerRegistrierung() async {
    setState(() {
      processing = true;
    });

    var url = "http://zukunft.sportsocke522.de/registrierung.php";
    var data = {
      "email": emailctrl.text,
      "benutzer": namectrl.text,
      "passwort": passctrl.text,
      "rolleID": rolleID.toString(),
      "erfahrung": erfahrung.toString()
    };

    var res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "Account existiert bereits") {
      Fluttertoast.showToast(
          msg: "Der Benutzer existiert bereits",
          toastLength: Toast.LENGTH_SHORT);
    } else {
      if (jsonDecode(res.body) == "true") {
        /*NICHT LÖSCHEN die Variable futureBenutzer wird genutzt um an den aktuellen Benutzer aus der Datenbank zu kommen und in sharedPreferences zwischenzuspeichern */
        // ignore: unused_local_variable
        var futureBenutzer =
            await Benutzer.getBenutzer(emailctrl.text, passctrl.text);

        /* Aufrufen des Willkommenscreens nach erfolgreicher Registrierung */
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => WillkommenScreen()));
        /* Meldung bei nicht erfolgreicher Registrierung */
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
      appBar: AppBar(
        title: Text('Registrieren'),
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
                    /* Prüfen, ob Benutzernamen eingegeben wurde */
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Bitte gib einen Benutzernamen an';
                      }
                      if (value.length > 15) {
                        return 'Dein Benutzername darf max. 15 Zeichen lang sein';
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
                    /* Prüfen, ob eine Email eingeben wurde */
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Bitte gib eine gültige Email Adresse an';
                      }

                      /* Prüfen, ob die Email in einen gültigen Format */
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
                    /* Prüfen, ob Passwort eingegeben wurde */
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
                    /* Prüfen, ob 2.Passwort eingegeben wurde */
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Bitte gib ein Passwort ein.';
                      }
                      /* Prüfen, ob Passwörter übereinstimmen */
                      if (value != passwortvalue) {
                        return 'Die Passwörter stimmen nicht überein.';
                      }

                      return null;
                    },
                    obscureText: true,
                  ),
                  SizedBox(height: 40),

                  /* REGISTRIEREN-BUTTON */
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
                    /* Prüfen, ob alle Daten korrekt angegeben wurden. 
                    Falls erfolgreich Benutzerregistrierung durchführen */
                    onTap: () {
                      var valid = _formKey.currentState.validate();
                      if (!valid) {
                        return;
                      }

                      benutzerRegistrierung();
                    },
                  ),
                  /* Struktur der Fehleranzeige bei Eingabe ungültiger Daten */
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
      /* Weiterleiten zur Anmeldung */
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
