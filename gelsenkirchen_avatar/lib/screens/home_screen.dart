import 'package:flutter/material.dart';

import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';

import 'map_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Gelsenkirchen Avatar'),
      ),
      body: Center(
        child: MapScreen(),

        //Hier wird später die Karte eingefügt
      ),
    );
  }
}
