import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/lern_kategorie.dart';
import 'package:gelsenkirchen_avatar/screens/lernort_screen.dart';
import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:gelsenkirchen_avatar/data/lernort.dart';

class LernortListeScreenTest extends StatefulWidget {
  @override
  _LernortListeScreenTestState createState() => _LernortListeScreenTestState();
}

class _LernortListeScreenTestState extends State<LernortListeScreenTest> {
  List<Lernort> lernortList = List();
  List lernortListGefiltert = List();
  bool isSearching = false;
  List<LernKategorie> lernKategorieList = List();

  @override
  void initState() {
    var lernorteFuture = Lernort.shared.gibObjekte();
    var lernKategorieFuture = LernKategorie.shared.gibObjekte();
    lernorteFuture.then((lernorte) {
      setState(() {
        lernortList = lernortListGefiltert = lernorte;
        print(lernortList);
      });
    });
    lernKategorieFuture.then((lernkategorie) {
      setState(() {
        lernKategorieList = lernkategorie;
        print(lernkategorie);
      });
    });
    super.initState();
  }

  void sucheLernort(value) {
    setState(() {
      lernortListGefiltert = lernortList
          .where((lernort) =>
              lernort.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  //  @override
  // Widget build(BuildContext context) {
  //   return ListView.builder(
  //     itemCount: lernortListGefiltert.length,
  //     itemBuilder: erstelleListViewitem,
  //     padding: EdgeInsets.all(0.0),
  //   );
  // }

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
      drawer: NavDrawer(),
      appBar: AppBar(
        title: !isSearching
            ? Text('Lernorte')
            : TextField(
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
                    hintText: "Lernort Suchen"),

                // hintStyle: TextStyle(color: Colors.white)),
              ),
        actions: <Widget>[
          isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      this.isSearching = false;
                      lernortListGefiltert = lernortList;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      this.isSearching = true;
                    });
                  },
                ),
        ],
      ),
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
