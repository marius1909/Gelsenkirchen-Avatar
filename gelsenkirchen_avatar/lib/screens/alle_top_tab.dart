import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/lern_kategorie.dart';
import 'package:gelsenkirchen_avatar/screens/lernort_screen.dart';
import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:gelsenkirchen_avatar/data/lernort.dart';

class AlleTopTab extends StatefulWidget {
  @override
  _AlleTopTabState createState() => _AlleTopTabState();
}

class _AlleTopTabState extends State<AlleTopTab> {
  int _listLength = 0;
  List<Lernort> lernortList = List();

  @override
  void initState() {
    super.initState();
    var lernorteFuture = Lernort.shared.gibObjekte();
    lernorteFuture.then((lernorte) {
      setState(() {
        _listLength = lernorte.length;
        lernortList = lernorte;
        print(lernortList);
      });
    });
  }

  /*Diese Methode erstellt die ListViewItems*/
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
            lernortList[index].name != null ? lernortList[index].name : 'empty',
            style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          subtitle: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /*KURZBESCHREIBUNG*/
                new Text(
                    lernortList[index].kurzbeschreibung != null
                        ? lernortList[index].kurzbeschreibung
                        : '',
                    style: new TextStyle(
                        fontSize: 13.0, fontWeight: FontWeight.normal)),
                /*KATEGORIE*/
                /*new Text('Kategorie: ${lernortList[index].kategorieId}',
                  style: new TextStyle(
                      fontSize: 11.0, fontWeight: FontWeight.normal)),*/
              ]),
          onTap: () {
            /*Hier kommt Aktion beim Klick auf Lernort hin*/
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        LernortScreen(l: lernortList[index])));
          },
        )
      ],
    ));
  }

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _listLength,
      itemBuilder: erstelleListViewitem,
      padding: EdgeInsets.all(0.0),
    );
  }
}
