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
        /*Standardschrift*/
        fontFamily: 'Montserrat',
        /*Standardfarbe*/
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
