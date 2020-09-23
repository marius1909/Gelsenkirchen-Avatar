import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/einstellungenscreen.dart';
import 'package:gelsenkirchen_avatar/homescreen.dart';
import 'package:gelsenkirchen_avatar/lernortscreen.dart';
import 'package:gelsenkirchen_avatar/profilscreen.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              '',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.blue[200],
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/lernendestadt.png'))),
          ),
          ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => HomeScreen()));
              }),
          ListTile(
              leading: Icon(Icons.face),
              title: Text('Profil'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ProfilScreen()));
              }),
          ListTile(
              leading: Icon(Icons.account_balance),
              title: Text('Lernorte'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LernortScreen()));
              }),
          ListTile(
              leading: Icon(Icons.settings),
              title: Text('Einstellungen'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            EinstellungenScreen()));
              }),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
            //Funktionalität zum Ausloggen fehlt noch
          ),
        ],
      ),
    );
  }
}
