import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Avatarbearbeiten extends StatefulWidget {
  @override
  _AvatarbearbeitenState createState() => _AvatarbearbeitenState();
}

//@Lisa
/* List<List<Avatar>> avatare = loadInfo.loadAlleAvatare();

    for (var i = 0; i < avatare.length; i++) {
      for (var j = 0; j < avatare[i].length; j++) {
        print(b[i][j]);
      }
    }
    */
//Wenn auf Avatar klick => speicher TypID und collectablesausgerüstetID in Datenbank

class _AvatarbearbeitenState extends State<Avatarbearbeiten> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profil bearbeiten'),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Padding(
            padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
            child: Text("Avatar bearbeiten Placeholder")));
  }
}
