import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/lernort.dart';
import 'package:gelsenkirchen_avatar/screens/anmeldung_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';
import 'data/benutzer.dart';
import 'screens/home_screen.dart';
import 'widgets/ladescreen.dart';
import 'dart:convert';
import 'package:gelsenkirchen_avatar/theme/GElernt_theme.dart';

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

    Lernort.shared.gibObjekte().then((value) => value.forEach((element) {
          print(element.id);
          print(element.kategorieID);
          print(element.name);
        }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gelsenkirchen Avatar',
      home: processing
          ? Ladescreen()
          : angemeldeterBenutzer == null
              ? Anmeldung()
              : HomeScreen(),
      theme: GElerntTheme.lightTheme,
    );
  }
}
