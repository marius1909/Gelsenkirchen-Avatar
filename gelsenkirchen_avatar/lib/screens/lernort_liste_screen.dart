import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/lern_kategorie.dart';
import 'package:gelsenkirchen_avatar/screens/alle_top_tab.dart';
import 'package:gelsenkirchen_avatar/screens/kategorie_top_tab.dart';
import 'package:gelsenkirchen_avatar/screens/lernort_screen.dart';
import 'package:gelsenkirchen_avatar/screens/suchen_screen.dart';
import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:gelsenkirchen_avatar/data/lernort.dart';
import 'package:gelsenkirchen_avatar/data/lern_kategorie.dart';

class LernortListeScreen extends StatefulWidget {
  @override
  _LernortListeScreenState createState() => _LernortListeScreenState();
}

class _LernortListeScreenState extends State<LernortListeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          drawer: NavDrawer(),
          appBar: AppBar(
            // backgroundColor: Color(0xff109618),
            backgroundColor: Colors.blue,
            title: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: _CustomAppBar(context),
            ),
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Colors.white,
              indicatorWeight: 6.0,
              tabs: <Widget>[
                Tab(
                  child: Container(
                    child: Text(
                      'Alle Lernorte',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text(
                      'Lernkategorien',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[AlleTopTab(), KategorieTopTab()],
          )),
    );
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
