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
    var lernorteFuture = Lernort.shared.gibObjekte();
    lernorteFuture.then((lernorte) {
      setState(() {
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

  Widget erstelleListViewitem(BuildContext context, int index) {
    return new Card(
        child: new Column(
      children: <Widget>[
        new ListTile(
          /* TODO: Bild aus DB holen und anzeigen (Lisa) */

          /* leading: new Image.asset(
          "assets/" + _allCities[index].image,
          fit: BoxFit.cover,
          width: 100.0,
          ), */
          leading: CircleAvatar(
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
            /*Hier kommt Aktion beim Klick auf Lernort hin*/
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
                    child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700]),
                            children: [
                          TextSpan(text: "Keine Ergebnisse für die Kategorie "),
                          TextSpan(
                              text: lkname,
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ])),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
      ),
    );
  }
}
