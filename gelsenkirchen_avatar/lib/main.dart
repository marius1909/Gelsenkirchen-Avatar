import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/screens/home_screen.dart';
import 'package:gelsenkirchen_avatar/suchspiel/body.dart';
import 'package:gelsenkirchen_avatar/suchspiel/scan_screen.dart';
import 'package:gelsenkirchen_avatar/suchspiel/score_screen.dart';
import 'package:gelsenkirchen_avatar/suchspiel/suchspiel_art.dart';
import 'package:gelsenkirchen_avatar/suchspiel/suchspiel_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gelsenkirchen Avatar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
