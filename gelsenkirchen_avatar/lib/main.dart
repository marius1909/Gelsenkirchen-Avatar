import 'package:flutter/material.dart';

import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';

import 'package:gelsenkirchen_avatar/homescreen.dart';
import 'package:gelsenkirchen_avatar/lernortscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gelsenkirchen Avatar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      //MyHomePage(),
    );
  }
}

/*
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Gelsenkirchen Avatar'),
      ),
      body: Center(
        child: Text('Karte'),
      ),
    );
  }
}
*/

/*
class ScreenLernort extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blub'),
      ),
    );
  }
}
*/
