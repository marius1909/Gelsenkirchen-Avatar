import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gelsenkirchen Avatar',
      theme: ThemeData(
          /* Primäre Farben */
          primaryColor: Color(0xff2d75f0), //normales blau
          primaryColorLight: Color(0xff4d8af3), //helles blau
          primaryColorDark: Color(0xff105de3), //dunkles blau

          /* Sekundäre/ Akzent-Farbe */
          /* Muss ggf. angepasst werden */
          accentColor: Color(0xffe54bab),

          /* Hintergrundfarbe des Scaffold-Widgets */
          //scaffoldBackgroundColor: Colors.grey[500],

          /* Farbe für fokusierte Elemente */
          /* Muss ddf. angepasst werden */
          focusColor: Color(0xff98ce00),

          /* Standardschrift */
          fontFamily: 'Montserrat',
          textTheme: TextTheme(
            headline1: null,
            bodyText1: null,

            /* Set Theme in Widgets */
            /* Container(
    color: Theme.of(context).primaryColor,    
    child: Text('custom theme', 
                 style: Theme.of(context).textTheme.body
    )
) */
          )),
      home: HomeScreen(),
    );
  }
}
