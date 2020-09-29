import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';

class ProfilScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Profil'),
      ),
    );
  }
}
