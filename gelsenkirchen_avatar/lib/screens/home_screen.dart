import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';

import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';

import 'map_screen.dart';

class HomeScreen extends StatelessWidget {
  final Benutzer angemeldeterBenutzer;
  HomeScreen({Key key, @required this.angemeldeterBenutzer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('GElernt!'),
      ),
      body: Center(
        child: MapScreen(),
      ),
    );
  }
}
