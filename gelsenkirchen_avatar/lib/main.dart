import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/screens/anmeldung_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';
import 'data/benutzer.dart';
import 'screens/home_screen.dart';
import 'widgets/ladescreen.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Benutzer currentBenutzer = Benutzer();
  Benutzer angemeldeterBenutzer;
  bool processing = true;

  /* Prüfen ob der Benutzer bereits angemeldet ist */
  Future pruefeAufLogin() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    /* Prüfen ob der Key 'benutzer' bereits angelegt */
    var test = sharedPreferences.getString("benutzer");
    if (test != null) {
      var erhaltenerBenutzer =
          jsonDecode(sharedPreferences.getString("benutzer"));
      print(erhaltenerBenutzer);
      setState(() {
        angemeldeterBenutzer =
            Benutzer.shared.objektVonJasonArray(erhaltenerBenutzer);
        /* Den Current Benutzer auf dem in Zwischenspeicher gespeicherten setzen */
        currentBenutzer.setCurrent(erhaltenerBenutzer);
      });
    }
    setState(() {
      processing = false;
    });
  }

  @override
  void initState() {
    pruefeAufLogin();
    super.initState();
  }

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
            headline1: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),

            /* Verwendung für Unterüberschriften: Text('custom theme', style: Theme.of(context).textTheme.headline2) */
            headline2: TextStyle(fontSize: 20),

            /* Verwendung für kurze wichtige Infos o. ä.: Text('custom theme', style: Theme.of(context).textTheme.headline3) */
            headline3: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),

            /* Verwendung für kurze wichtige Infos in Farbe o. ä.: Text('custom theme', style: Theme.of(context).textTheme.headline3) */
            headline4: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xff0b3e99)),

            /* Verwendung für normalen Fließtext: Text('custom theme', style: Theme.of(context).textTheme.bodyText1) */
            bodyText1: TextStyle(fontSize: 15),
          )),
      home: processing
          ? Ladescreen()
          : angemeldeterBenutzer == null
              ? Anmeldung()
              : HomeScreen(),
    );
  }
}
