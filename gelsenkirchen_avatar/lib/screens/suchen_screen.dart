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
      });
    });
  }

  // Listet die Lernorte abhängig der Sucheingabe auf
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
        new ListTile(
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
                        l: lernortListGefiltert[index], k: "Kategorie")));
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
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  sucheLernort(value);
                },
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Suchen",
                  hintStyle: TextStyle(color: Colors.grey),
                ))),
        body: Container(
            color: Colors.white,
            child: ListView.builder(
              itemCount: _listLength,
              itemBuilder: erstelleListViewitem,
            )));
  }
}
