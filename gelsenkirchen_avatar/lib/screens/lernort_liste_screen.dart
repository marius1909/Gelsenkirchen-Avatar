import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/screens/kategorie_top_tab.dart';
import 'package:gelsenkirchen_avatar/screens/suchen_screen.dart';
import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';
import 'package:flutter/cupertino.dart';

class LernortListeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          // backgroundColor: Color(0xff109618),
          backgroundColor: Colors.blue,
          title: Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: _CustomAppBar(context),
          ),
        ),
        body: KategorieTopTab());
  }
}

Widget _CustomAppBar(BuildContext context) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: Text(
            'Lernorte',
            style: TextStyle(color: Colors.white),
          ),
        ),
        Container(
          child: IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => SuchenScreen()));
              }),
        ),
      ],
    ),
  );
}
