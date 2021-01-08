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

  void initState() {
    var lernorteFuture = Lernort.shared.gibObjekte();
    lernorteFuture.then((lernorte) {
      setState(() {
        lernortListGefiltert = lernorte
            .where((lernort) => lernort.kategorieID == widget.lk.id)
            .toList();
        print(lernortListGefiltert);
      });
    });
    super.initState();
  }

  Widget erstelleListViewitem(BuildContext context, int index) {
    return new Card(
        child: new Column(
      children: <Widget>[
        /*BILD*/
        /*new ListTile(
        leading: new Image.asset(
          "assets/" + _allCities[index].image,
          fit: BoxFit.cover,
          width: 100.0,
        ),*/
        new ListTile(
          title: new Text(
            /*NAME*/
            lernortListGefiltert[index].name != null
                ? lernortListGefiltert[index].name
                : 'empty',
            style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          subtitle: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /*KURZBESCHREIBUNG*/
                new Text(
                    lernortListGefiltert[index].kurzbeschreibung != null
                        ? lernortListGefiltert[index].kurzbeschreibung
                        : '',
                    style: new TextStyle(
                        fontSize: 13.0, fontWeight: FontWeight.normal)),
                /*KATEGORIE*/
                /*new Text('Kategorie: ${lernortListGefiltert[index].kategorieId}',
                  style: new TextStyle(
                      fontSize: 11.0, fontWeight: FontWeight.normal)),*/
              ]),
          onTap: () {
            /*Hier kommt Aktion beim Klick auf Lernort hin*/
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        LernortScreen(l: lernortListGefiltert[index])));
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
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
