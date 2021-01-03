import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/screens/anmeldung_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gelsenkirchen Avatar',
      theme: ThemeData(
          /* Primäre Farben */
          primaryColor: Color(0xff0b3e99), //normales dunkelblau
          primaryColorLight: Color(0xff0e53c9), //helles dunkelblau
          primaryColorDark: Color(0xff072c6b), //dunkles dunkelblau

          /* Sekundäre/ Akzent-Farbe */
          /* Muss ggf. angepasst werden */
          accentColor: Color(0xffe54b4b),

          /* Hintergrundfarbe des Scaffold-Widgets */
          //scaffoldBackgroundColor: Colors.grey[500],

          /* Farbe für fokusierte Elemente */
          /* Muss ddf. angepasst werden */
          focusColor: Color(0xff98ce00),

          /* Standardschrift */
          /* Set Theme in Widgets */
          /* Text('custom theme', style: Theme.of(context).textTheme.headline1) */
          fontFamily: 'Montserrat',

          /* Standardtextstyles */
          textTheme: TextTheme(
            /* Verwendung für Überschriften: Text('custom theme', style: Theme.of(context).textTheme.headline1) */
            headline1: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),

            /* Verwendung für Unterüberschriften: Text('custom theme', style: Theme.of(context).textTheme.headline2) */
            headline2: TextStyle(fontSize: 22),

            /* Verwendung für kurze wichtige Infos o. ä.: Text('custom theme', style: Theme.of(context).textTheme.headline3) */
            headline3: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),

            /* Verwendung für normalen Fließtext: Text('custom theme', style: Theme.of(context).textTheme.bodyText1) */
            bodyText1: TextStyle(fontSize: 16),
          )),

      /* TODO: Wenn Benutzer angemeldet ist, dann HomeScreen anzeigen, wenn nicht angemeldet, dann Anmeldungsscreen anzeigen (Lisa) */
      home: Anmeldung(),
    );
  }
}
