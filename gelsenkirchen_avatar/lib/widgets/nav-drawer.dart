import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gelsenkirchen_avatar/screens/freundesliste_screen.dart';
import 'package:gelsenkirchen_avatar/screens/home_screen.dart';
import 'package:gelsenkirchen_avatar/screens/lernort_liste_screen.dart';
import 'package:gelsenkirchen_avatar/screens/profil_bearbeiten_screen.dart';
import 'package:gelsenkirchen_avatar/screens/profil_screen.dart';
import 'package:gelsenkirchen_avatar/screens/impressum_screen.dart';
import 'package:gelsenkirchen_avatar/screens/registrierung_screen.dart';
import 'package:gelsenkirchen_avatar/screens/scoreboard_screen.dart';
import 'package:gelsenkirchen_avatar/quiz/nfc_quiz.dart';
import 'package:gelsenkirchen_avatar/data/global.dart';
import 'package:gelsenkirchen_avatar/suchspiel/suchspiel_screen.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              '',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.blue[200],
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/Menubild.png'))),
          ),

          /* HOME (heißt in der App jetzt Karte, weil es den Menüpunkt für den Bentuzer treffender bezeichnet) */
          ListTile(
              //leading: Icon(Icons.home),
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 20,
                  minHeight: 20,
                  maxWidth: 30,
                  maxHeight: 30,
                ),
                child: Image.asset("assets/icons/Home_dunkelblau_Icon.png"),
              ),
              title: Text('Karte'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => HomeScreen()));
              }),

          /* PROFIL */
          ListTile(
              //leading: Icon(Icons.face),
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 20,
                  minHeight: 20,
                  maxWidth: 30,
                  maxHeight: 30,
                ),
                child: Image.asset("assets/icons/Profil_blau_Icon.png"),
              ),
              title: Text('Profil'),
              onTap: () {
                if (global.user?.id != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Profil(global.user.id)));
                } else {
                  Fluttertoast.showToast(
                      msg: "Anmeldung fehlt!", toastLength: Toast.LENGTH_SHORT);
                }
              }),

          /* LERNORTE */
          ListTile(
              //leading: Icon(Icons.account_balance),
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 20,
                  minHeight: 20,
                  maxWidth: 30,
                  maxHeight: 30,
                ),
                child: Image.asset("assets/icons/Lernort_rot_Icon.png"),
              ),
              title: Text('Lernorte'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            LernortListeScreen()));
              }),
          ListTile(
              leading: Icon(Icons.search),
              title: Text('Suchspiel'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Suchspiel()));
              }),

          /* FREUNDE */
          ListTile(
              //leading: Icon(Icons.people),
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 20,
                  minHeight: 20,
                  maxWidth: 30,
                  maxHeight: 30,
                ),
                child: Image.asset("assets/icons/Freunde_gelb_Icon.png"),
              ),
              title: Text('Freunde'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Freundesliste()));
              }),

          /* SCOREBOARD */
          /* Wurde in Sprint 4 in "Bestelnliste" umbenannt, da verständlicher für User */
          ListTile(
              //leading: Icon(Icons.score),
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 20,
                  minHeight: 20,
                  maxWidth: 30,
                  maxHeight: 30,
                ),
                child: Image.asset("assets/icons/Scoreboard_gruen_Icon.png"),
              ),
              title: Text('Bestenliste'),
              onTap: () {
                if (global.user?.id != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ScoreBoard(global.user.id)));
                } else {
                  Fluttertoast.showToast(
                      msg: "Anmeldung fehlt!", toastLength: Toast.LENGTH_SHORT);
                }
              }),

          /* TODO: Hilfe muss noch implenentiert werden (optional) (Lisa)*/
          /* TODO: Hilfeicon fehlt (optional) (Lisa) */
          /* HILFE */
          /* ListTile(
              leading: Icon(Icons.help),
              title: Text('Hilfe'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => HilfeScreen()));
              }), */

          /* TODO: Einstellungen muss noch implenentiert werden (optional) (Lisa) */
          /* TODO: Einstellungenicon fehlt (optional) (Lisa) */
          /* EINSTELLUNGEN */
          /* ListTile(
              leading: Icon(Icons.settings),
              title: Text('Einstellungen'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            EinstellungenScreen()));
              }), */

          /* IMPRESSUM */
          ListTile(
              //leading: Icon(Icons.description),
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 20,
                  minHeight: 20,
                  maxWidth: 30,
                  maxHeight: 30,
                ),
                child:
                    Image.asset("assets/icons/Impressum_dunkelblau_Icon.png"),
              ),
              title: Text('Impressum'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ImpressumScreen()));
              }),

          /* TODO: Registrieren muss entfernt werden (Lisa) */
          /* REGISTRIEREN */
          ListTile(
              leading: Icon(Icons.menu_book),
              title: Text('Registrierung'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Registrierung()));
              }),

          /* TODO: Logout-Funktion muss noch implementiert werden (Lisa) */
          /* TODO: Logouticon fehlt (Lisa) */
          /* LOGOUT */
          /* ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
            //Funktionalität zum Ausloggen fehlt noch
          ), */
        ],
      ),
    );
  }
}
