import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/lernort.dart';
import 'package:gelsenkirchen_avatar/screens/lernort_screen.dart';

class SuchenScreen extends StatefulWidget {
  @override
  _SuchenScreenState createState() => _SuchenScreenState();
}

class _SuchenScreenState extends State<SuchenScreen> {
  List lernortListGefiltert;
  int _listLength = 0;
  List<Lernort> lernortList = List();

  @override
  void initState() {
    super.initState();
    var lernorteFuture = Lernort.shared.gibObjekte();
    lernorteFuture.then((lernorte) {
      setState(() {
        lernortList = lernorte;
        print(lernortList);
      });
    });
  }

  void sucheLernort(value) {
    setState(() {
      lernortListGefiltert = lernortList
          .where((lernort) =>
              lernort.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
      _listLength = lernortListGefiltert.length;
    });
  }

  Widget erstelleListViewitem(BuildContext context, int index) {
    return new Column(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: TextField(
                onChanged: (value) {
                  sucheLernort(value);
                },
                autofocus: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    // icon: Icon(
                    //   Icons.search,
                    //   color: Colors.white,
                    // ),
                    hintText: "Lernort Suchen"))),
        body: Container(
            color: Colors.white,
            child: ListView.builder(
              itemCount: _listLength,
              itemBuilder: erstelleListViewitem,
            )));
  }
}
