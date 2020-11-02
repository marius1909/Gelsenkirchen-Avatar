import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/lernort.dart';
import 'package:gelsenkirchen_avatar/lernort_screen.dart';
import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LernortListeScreen extends StatefulWidget {
  @override
  _LernortListeScreenState createState() => _LernortListeScreenState();
}

class _LernortListeScreenState extends State<LernortListeScreen> {
  @override
  void initState() {
    super.initState();

    /*Hier kann man alles mögliche aufrufen, was beim Laden des Screens
    geschehen soll*/
    ladeLernorte();
  }

  List data = [];

  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('Lernorte'),
        ),
        body: new Padding(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: getHomePageBody(context)));
  }
}

getHomePageBody(BuildContext context) {
  return ListView.builder(
    itemCount: lernortList.length,
    itemBuilder: _getItemUI,
    padding: EdgeInsets.all(0.0),
  );
}

Widget _getItemUI(BuildContext context, int index) {
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
                  builder: (context) => LernortScreen(l: lernortList[index])));
        },
      )
    ],
  ));
}

List<Lernort> lernortList = new List();

/*Diese Methode holt die Lernortdaten aus der Datenbank und ruft die Methode
fuelleListView() auf*/
void ladeLernorte() async {
  var url = "http://zukunft.sportsocke522.de/getLernorte.php";
  var res = await http.get(url);

  /*List, die Maps enthält, in denen jeweils ein Datensatz steckt.
  Zuordnung: Spaltenname -> Inhalt*/
  var lernortDatensaetze = new List();
  lernortDatensaetze = jsonDecode(res.body);
  print(lernortDatensaetze);

  fuelleLernortList(lernortDatensaetze);

  if (jsonDecode(res.body) == null) {
    Fluttertoast.showToast(
        msg: "Laden der Lernorte fehlgeschlagen.",
        toastLength: Toast.LENGTH_SHORT);
  } else {
    Fluttertoast.showToast(
        msg: "Daten wurden geladen.", toastLength: Toast.LENGTH_SHORT);
    print("Laden der Lernorte erfolgreich.");
  }

  /*Alternative Fehlerabfrage*/
  /* if (jsonDecode(res.body) == "Account existiert bereits") {
    Fluttertoast.showToast(
        msg: "Der Benutzer existiert bereits", toastLength: Toast.LENGTH_SHORT);
  } else {
    if (jsonDecode(res.body) == "true") {
      Fluttertoast.showToast(
          msg: "Benutzer erstellt", toastLength: Toast.LENGTH_SHORT);
    } else {
      Fluttertoast.showToast(msg: "error", toastLength: Toast.LENGTH_SHORT);
    }
  } */
}

/*Diese Methode füllt eine List mit Lernortobjekten aus der DB, die der
  ListView übergeben wird*/
void fuelleLernortList(List datenquelle) {
  /*Iteriert über den Inhalt der List, die wir aus der DB bekommen, also über
    Map-Objekte, die die Datensätze enthalten*/
  var it = datenquelle.iterator;

  while (it.moveNext()) {
    Lernort datensatz = new Lernort();
    var valuesListe = it.current.values.toList();

    datensatz.setId(int.parse(valuesListe[0]));
    datensatz.setNord(int.parse(valuesListe[1]));
    datensatz.setOst(int.parse(valuesListe[2]));
    datensatz.setKategorieId(int.parse(valuesListe[3]));
    datensatz.setName(valuesListe[4]);
    datensatz.setKurzbeschreibung(valuesListe[5]);
    datensatz.setBeschreibung(valuesListe[6]);
    datensatz.setTitelbild(valuesListe[7]);
    datensatz.setMinispielArtId(int.parse(valuesListe[8]));
    datensatz.setBelohnungenId(int.parse(valuesListe[9]));
    datensatz.setWeitereBilder(valuesListe[10]);

    lernortList.add(datensatz);
  }
}
