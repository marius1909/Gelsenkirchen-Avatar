import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Avatarbearbeiten extends StatefulWidget {
  @override
  _AvatarbearbeitenState createState() => _AvatarbearbeitenState();
}

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
