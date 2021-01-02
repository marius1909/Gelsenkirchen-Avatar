import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/screens/lernort_screen.dart';
import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:gelsenkirchen_avatar/data/lernort.dart';

class LernortListeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('Lernorte'),
          actions: [
            IconButton(
                icon: Icon(Icons.search, color: Colors.white), onPressed: null),
            IconButton(
                icon: Icon(Icons.filter_alt, color: Colors.white),
                onPressed: null)
          ],
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
  List<Lernort> lernortListGefiltert = List();

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

  void filterLernortList(value) {
    setState(() {
      lernortListGefiltert = lernortList
          .where((lernort) =>
              lernort.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
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

  /* Diese Methode erstellt die ListViewItems */
  Widget erstelleListViewitem(BuildContext context, int index) {
    return new Card(
        color: null,
        elevation: 0,
        child: new Column(
          children: <Widget>[
            /* BILD */
            /* TODO: Lernortbilder aus DB anzeigen (Lisa) */
            /*new ListTile(
        leading: new Image.asset(
          "assets/" + _allCities[index].image,
          fit: BoxFit.cover,
          width: 100.0,
        ),*/
            new ListTile(
              //dense: true,
              title: new Text(
                /* NAME */
                lernortList[index].name != null
                    ? lernortList[index].name
                    : 'empty',
                style: new TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    /* KURZBESCHREIBUNG */
                    new Text(
                      lernortList[index].kurzbeschreibung != null
                          ? lernortList[index].kurzbeschreibung
                          : '',
                    ),
                    /* KATEGORIE */
                    /* TODO: Kategoriename aus DB anzeigen (Lisa) */
                    /*new Text('Kategorie: ${lernortList[index].kategorieId}',
                  style: new TextStyle(
                      fontSize: 11.0, fontWeight: FontWeight.normal)),*/
                  ]),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
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
