import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/lern_kategorie.dart';
import 'package:gelsenkirchen_avatar/data/lernort.dart';
import 'package:gelsenkirchen_avatar/screens/lernort_screen.dart';

class LernortListeScreenKategorie extends StatefulWidget {
  final LernKategorie lk;
  LernortListeScreenKategorie({Key key, @required this.lk}) : super(key: key);

  @override
  _LernortListeScreenKategorieState createState() =>
      _LernortListeScreenKategorieState();
}

class _LernortListeScreenKategorieState
    extends State<LernortListeScreenKategorie> {
  bool isSearching = false;
  List lernortListGefiltert = List();
  bool timeout = false;
  String lkname;

  void initState() {
    lkname = widget.lk.name;
    Timer(Duration(seconds: 4), () {
      if (this.mounted) {
        setState(() {
          timeout = true;
        });
      }
    });
    /* Laden der Lernorte */
    var lernorteFuture = Lernort.shared.gibObjekte();
    lernorteFuture.then((lernorte) {
      setState(() {
        /* Falls nicht "Alle Lernorte" ausgewählt, nur Lernorte der Kategorie anzeigen */
        if (lkname != "Alle Lernorte") {
          lernortListGefiltert = lernorte
              .where((lernort) => lernort.kategorieID == widget.lk.id)
              .toList();
        } else {
          lernortListGefiltert = lernorte;
          print(lernortListGefiltert);
        }
      });
    });
    super.initState();
  }

  /*Diese Methode erstellt die ListViewItems*/
  Widget erstelleListViewitem(BuildContext context, int index) {
    return new Card(
        child: new Column(
      children: <Widget>[
        new ListTile(
          leading: CircleAvatar(
            /* Prüft, ob Bild vorhanden. Falls nicht, Placeholder einfügen */
            backgroundImage: lernortListGefiltert[index]
                    .titelbild
                    .contains("http")
                ? NetworkImage(lernortListGefiltert[index].titelbild)
                : NetworkImage(
                    "https://www.hanse-haus.de/fileadmin/_processed_/7/b/csm_fertighaus-bauen-startseiten-bild_d13e0ec91d.jpg"),
          ),
          title: new Text(
            /*NAME*/
            lernortListGefiltert[index].name != null
                ? lernortListGefiltert[index].name
                : 'empty',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LernortScreen(
                        l: lernortListGefiltert[index], k: "Todo")));
          },
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.lk.name)),
      body: Container(
        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        child: lernortListGefiltert.length > 0
            ? ListView.builder(
                itemCount: lernortListGefiltert.length,
                itemBuilder: erstelleListViewitem,
                padding: EdgeInsets.all(0.0),
              )
            : timeout
                ? Center(
                    child: Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Text(
                        "Derzeit gibt es leider keine Lernorte in die Kategorie \"" +
                            lkname +
                            "\"",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline3),
                  ))
                : Center(
                    child: CircularProgressIndicator(),
                  ),
      ),
    );
  }
}
