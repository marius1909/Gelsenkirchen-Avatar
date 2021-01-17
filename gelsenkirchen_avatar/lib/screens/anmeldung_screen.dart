import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';
import 'package:gelsenkirchen_avatar/data/benutzer_invalid_login_exception.dart';
import 'package:gelsenkirchen_avatar/screens/registrierung_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gelsenkirchen_avatar/screens/home_screen.dart';
import 'package:imagebutton/imagebutton.dart';

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

    var futureBenutzer = Benutzer.getBenutzer(emailctrl.text, passctrl.text);
    futureBenutzer.catchError(invalidError);
    futureBenutzer.then((benutzer) {
      angemeldeterBenutzer = benutzer;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
    });

    setState(() {
      processing = false;
    });
  }

  bool invalidError(Object error) {
    final invalidErrorCause = (error as InvalidLoginException).cause;
    switch (invalidErrorCause) {
      case InvalidLoginExceptionCause.emailNotFound:
        Fluttertoast.showToast(
            msg: "Der angegebene Benutzer existiert nicht",
            toastLength: Toast.LENGTH_SHORT);
        break;
      case InvalidLoginExceptionCause.passwordIncorrect:
        Fluttertoast.showToast(
            msg: "Falsches Passwort", toastLength: Toast.LENGTH_SHORT);
        break;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Anmelden'),
        /*Farbcode in Hexadezimal: Vor dem Hexadezimalcode "0xff" schreiben*/
        backgroundColor: Color(0xff0B3E99),
        /*Entfernt den Zurückbutton*/
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
          child: ListView(children: [
        Padding(padding: EdgeInsets.fromLTRB(30, 50, 30, 0)),
        Column(children: [
          Text("Bitte gib deine Anmeldedaten ein:",
              style: Theme.of(context).textTheme.headline3),
          /* CircleAvatar(
                backgroundImage: AssetImage('assets/images/wink.png'),
                radius: 130), */
          Padding(
              padding: EdgeInsets.fromLTRB(15, 50, 15, 0),
              child: Column(children: [
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
                  /* validator: (value) {
                      if (value.isEmpty) {
                        return 'Bitte gib eine gültige Email Adresse an';
                      }
                      if (EmailValidator.validate(value)) {
                        return null;
                      }

                      //Die Textzeile ist zu lang um angezeigt zu werden.*/
                  //return 'Bitte gib eine Email-Adresse im Format sample@example.com. ein';
                  //}, */
                  keyboardType: TextInputType.emailAddress,
                  controller: emailctrl,
                ),
                SizedBox(
                  height: 20,
                ),
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
                  /* validator: (value) {
                      if (value.isEmpty) {
                        return 'Bitte gib ein Passwort an.';
                      }

                      passwortvalue = value;

                      return null;
                    }, */
                  controller: passctrl,
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
                    "assets/buttons/Anmelden_dunkelblau_groß.png",
                  ),
                  unpressedImage: Image.asset(
                      "assets/buttons/Anmelden_dunkelblau_groß.png"),
                  onTap: () {
                    benutzerLogin();
                  },
                ),
                SizedBox(height: 40),

                /* Dieser Button dient nur dazu während der Entwicklung den Anmeldescreen zu überspringen */
                FlatButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => HomeScreen()));
                  },
                  child: Text(
                    "Ich bin Entwickler ;)",
                    textAlign: TextAlign.center,
                  ),
                ),
              ]))
        ])
      ])),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: FlatButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Registrierung()));
          },
          child: Text(
            "Du hast noch keinen Account? \n Hier geht's zur Registrierung.",
            textAlign: TextAlign.center,
          ),
        ),
        elevation: 0,
      ),
    );
  }
}
