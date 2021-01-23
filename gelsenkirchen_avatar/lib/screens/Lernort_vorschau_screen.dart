import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/screens/lernort_screen.dart';
import 'package:flutter_icons/flutter_icons.dart';
/* import 'package:http/http.dart' as http;
import 'dart:convert'; */
import 'package:gelsenkirchen_avatar/data/lernort.dart';

class LernortVorschau extends StatefulWidget {
  // final Lernort l;
  int id;
  Lernort l;

  LernortVorschau({Key key, @required this.l}) : super(key: key);
  @override
  _LernortVorschauState createState() => _LernortVorschauState();
}

class _LernortVorschauState extends State<LernortVorschau> {
  Map data;
  Icon kategorienSymbol;
  Image titelbild;
  Lernort lernort;

  void lernortDaten() async {
    lernort = widget.l;
    // var url = "http://zukunft.sportsocke522.de/lernortVorschau.php";
    // var body = {"id": lernortID.toString()};

    // var res = await http.post(url, body: body);

    // if (jsonDecode(res.body) == "Datensatz existiert nicht") {
    //   print('Datensatz nicht gefunden');
    // } else {
    setState(() {
      setKategorienSymbol(lernort.kategorieID);
      setTitelbild(lernort.titelbild);
    });
    // }
  }

  void setTitelbild(String bildUrl) {
    if (bildUrl.isEmpty) {
      titelbild = Image.asset(
        'assets/images/lernortPlaceholderTitelbild.jpg',
        fit: BoxFit.cover,
      );
    } else {
      titelbild = Image.network(bildUrl, fit: BoxFit.cover);
    }
  }

  void setKategorienSymbol(int kategorienID) {
    Color symbolcolor = Color(0xff0b3e99);
    double symbolsize = 20;
    switch (kategorienID) {
      case 0:
        {
          kategorienSymbol = Icon(FlutterIcons.cube_faw5s,
              size: symbolsize, color: symbolcolor);
        }
        break;

      case 1:
        {
          kategorienSymbol = Icon(FlutterIcons.compass_faw5s,
              size: symbolsize, color: symbolcolor);
        }
        break;

      case 2:
        {
          kategorienSymbol = Icon(FlutterIcons.seedling_faw5s,
              size: symbolsize, color: symbolcolor);
        }
        break;

      case 3:
        {
          kategorienSymbol = Icon(FlutterIcons.futbol_faw5s,
              size: symbolsize, color: symbolcolor);
        }
        break;

      case 4:
        {
          kategorienSymbol = Icon(FlutterIcons.palette_faw5s,
              size: symbolsize, color: symbolcolor);
        }
        break;

      case 5:
        {
          kategorienSymbol = Icon(FlutterIcons.temperature_low_faw5s,
              size: symbolsize, color: symbolcolor);
        }
        break;

      case 6:
        {
          kategorienSymbol = Icon(FlutterIcons.book_faw5s,
              size: symbolsize, color: symbolcolor);
        }
        break;

      case 7:
        {
          kategorienSymbol = Icon(FlutterIcons.hand_holding_heart_faw5s,
              size: symbolsize, color: symbolcolor);
        }
        break;

      case 8:
        {
          kategorienSymbol = Icon(FlutterIcons.music_faw5s,
              size: symbolsize, color: symbolcolor);
        }
        break;

      case 9:
        {
          kategorienSymbol = Icon(FlutterIcons.laptop_code_faw5s,
              size: symbolsize, color: symbolcolor);
        }
        break;
      default:
        {
          kategorienSymbol =
              Icon(Icons.category, size: symbolsize, color: symbolcolor);
        }
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    lernortDaten();
  }

  @override
  Widget build(BuildContext context) {
    if (lernort == null) {
      return Scaffold(
          body: new Container(
              margin: const EdgeInsets.all(10.0),
              alignment: Alignment.topCenter,
              child: Center(child: CircularProgressIndicator())));
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(lernort.name),
        ),
        //   body: SafeArea(
        // child:
        body: SingleChildScrollView(
            child: Column(children: [
          /* TITELBILD */
          Container(child: titelbild),
          Container(
            padding: new EdgeInsets.all(15.0),
            child: Column(
              children: [
                /* KATEGORIE*/
                /* TODO: - Hier muss noch der Kategoriename anstatt die KategorieId eingefügt werden */
                /* TODO: Kategorieicon anzeigen (Lisa) */
                /* TODO: Kategoriename aus DB anzeigen (Lisa) */
                Row(children: [
                  kategorienSymbol,
                  SizedBox(width: 15),
                  /* TODO: "lernKategorieList[lernort.kategorieID].name" verursacht einen Fehler, von dem ich nicht weiß, wie ich ihn beheben soll. Deshalb auch auskommentiert. (Lisa) */
                  Text("Kategorie",
                      //lernKategorieList[lernort.kategorieID].name,
                      style: Theme.of(context).textTheme.headline3),
                ]),
                SizedBox(height: 20),

                /* ADRESSE */
                Row(children: [
                  Text(lernort.adresse,
                      style: Theme.of(context).textTheme.headline3),
                ]),
                SizedBox(height: 20),

                /* ÖFFNUNGSZEITEN */
                Row(children: [
                  Text(
                    lernort.oeffnungszeiten == ""
                        ? "Keine Öffnungszeiten verfügbar"
                        : widget.l.oeffnungszeiten,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ]),
                SizedBox(height: 40),

                /*BESCHREIBUNG*/
                Text(
                  lernort.kurzbeschreibung,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          )
        ]))

        /* CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text(lernort.name),
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                background: titelbild,
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  // Expanded(
                  //     flex: 1,
                  //     child: Container(
                  //       padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  //       child: Text("Kategorie:",
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.bold, fontSize: 20.0)),
                  //     )),
                  Expanded(
                    flex: 1,
                    child: Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.fromLTRB(0, 0, 50, 0),
                        child: kategorienSymbol),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Beschreibung:",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    SizedBox(height: 5),
                    Text(lernort.kurzbeschreibung,
                        style: Theme.of(context).textTheme.subtitle1,
                        textAlign: TextAlign.justify),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: ButtonTheme(
                    child: RaisedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                LernortScreen(l: lernort, k: "TODO")));
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.blueGrey[900])),
                  color: Colors.blueGrey[800],
                  child: Text(
                    "Weiter zum Lernort",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey[100]),
                  ),
                )),
              )
            ]))
          ],
        ) */
        ,
      );
    }
  }
}
