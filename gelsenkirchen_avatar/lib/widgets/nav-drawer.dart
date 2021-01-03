import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gelsenkirchen_avatar/screens/einstellungen_screen.dart';
import 'package:gelsenkirchen_avatar/screens/home_screen.dart';
import 'package:gelsenkirchen_avatar/screens/lernort_liste_screen.dart';
import 'package:gelsenkirchen_avatar/screens/profil_screen.dart';
import 'package:gelsenkirchen_avatar/screens/hilfe_screen.dart';
import 'package:gelsenkirchen_avatar/screens/impressum_screen.dart';
import 'package:gelsenkirchen_avatar/screens/registrierung_screen.dart';
import 'package:gelsenkirchen_avatar/screens/scoreboard_screen.dart';
import 'package:gelsenkirchen_avatar/data/global.dart';

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
                    image: AssetImage('assets/images/lernendestadt.png'))),
          ),
          ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => HomeScreen()));
              }),
          ListTile(
              leading: Icon(Icons.face),
              title: Text('Profil'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Profil()));
              }),
          ListTile(
              leading: Icon(Icons.account_balance),
              title: Text('Lernorte'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            LernortListeScreen()));
              }),

          /*Im Folgenden sind die Menüeinträge "Freunde und Scoreboard, die ggf.
          später implementiert werden"*/
          /* ListTile(
              leading: Icon(Icons.people),
              title: Text('Freunde'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LernortScreen()));
              }),
          ListTile(
              leading: Icon(Icons.score),
              title: Text('Scorebeard'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LernortScreen()));
              }), */

          ListTile(
              leading: Icon(Icons.settings),
              title: Text('Einstellungen'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            EinstellungenScreen()));
              }),
          ListTile(
              leading: Icon(Icons.help),
              title: Text('Hilfe'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => HilfeScreen()));
              }),
          ListTile(
              leading: Icon(Icons.description),
              title: Text('Impressum'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ImpressumScreen()));
              }),
          ListTile(
              leading: Icon(Icons.menu_book),
              title: Text('Registrierung'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Registrierung()));
              }),
          ListTile(
              leading: Icon(Icons.table_view),
              title: Text('Scoreboard'),
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
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
            //Funktionalität zum Ausloggen fehlt noch
          ),
        ],
      ),
    );
  }
}
