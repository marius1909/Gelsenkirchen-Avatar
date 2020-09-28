import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/lernort_screen.dart';
import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';

class LernorteScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Lernorte'),
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        FlatButton(
          textColor: Colors.white,
          color: Colors.blue,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => LernortScreen()));
          },
          child: Text('Beispiel-Lernort'),
        ),
      ])),
    );
  }
}
