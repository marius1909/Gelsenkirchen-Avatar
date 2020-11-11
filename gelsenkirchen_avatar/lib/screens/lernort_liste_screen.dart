import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/lernort_screen.dart';
import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';
import 'package:flutter/cupertino.dart';
import 'lernort.dart';

class LernortListeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('Lernorte'),
        ),
        body: new Padding(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: LernortListView()));
  }
}

class LernortListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LernortListState();
}

class LernortListState extends State<LernortListView> {
  int _listLength = 0;
  List<Lernort> lernortList = List();

  @override
  void initState() {
    super.initState();
    var lernorteFuture = Lernort.shared.gibLernorte();
    lernorteFuture.then((lernorte) {
      setState(() {
        _listLength = lernorte.length;
        lernortList = lernorte;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _listLength,
      itemBuilder: erstelleListViewitem,
      padding: EdgeInsets.all(0.0),
    );
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
}
