import 'package:flutter/material.dart';

import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Gelsenkirchen Avatar'),
      ),
      body: Center(
        child: Text('Karte'),
        //Hier wird später die Karte eingefügt
      ),
    );
  }
}
