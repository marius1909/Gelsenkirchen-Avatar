import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/screens/lernort_screen.dart';
import 'package:flutter_icons/flutter_icons.dart';
/* import 'package:http/http.dart' as http;
import 'dart:convert'; */
import 'package:gelsenkirchen_avatar/data/lernort.dart';
import 'package:imagebutton/imagebutton.dart';

// ignore: must_be_immutable
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

      // Kategorie: Abenteuer
      case 1:
        {
          kategorienSymbol = Icon(FlutterIcons.explore_mdi,
              size: symbolsize, color: symbolcolor);
        }
        break;

      // Kategorie: Natur
      case 2:
        {
          kategorienSymbol = Icon(FlutterIcons.local_florist_mdi,
              size: symbolsize, color: symbolcolor);
        }
        break;

      // Kategorie: Sport
      case 3:
        {
          kategorienSymbol = Icon(FlutterIcons.directions_bike_mdi,
              size: symbolsize, color: symbolcolor);
        }
        break;

      // Kategorie: Kunst
      case 4:
        {
          kategorienSymbol = Icon(FlutterIcons.color_lens_mdi,
              size: symbolsize, color: symbolcolor);
        }
        break;

      // Kategorie: Klima
      case 5:
        {
          kategorienSymbol = Icon(FlutterIcons.temperature_low_faw5s,
              size: symbolsize, color: symbolcolor);
        }
        break;

      // Kategorie: Geschichte
      case 6:
        {
          kategorienSymbol = Icon(FlutterIcons.book_faw5s,
              size: symbolsize, color: symbolcolor);
        }
        break;

      // Kategorie: Soziales Miteinander
      case 7:
        {
          kategorienSymbol = Icon(FlutterIcons.hand_holding_heart_faw5s,
              size: symbolsize, color: symbolcolor);
        }
        break;

      // Kategorie: Musik
      case 8:
        {
          kategorienSymbol = Icon(FlutterIcons.music_note_mdi,
              size: symbolsize, color: symbolcolor);
        }
        break;

      // Kategorie: Technik
      case 9:
        {
          kategorienSymbol = Icon(FlutterIcons.computer_mdi,
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
          body: SingleChildScrollView(
              child: Column(children: [
            /* TITELBILD */
            Container(child: titelbild),
            Container(
                padding: new EdgeInsets.all(15.0),
                child: Column(children: [
                  /* KATEGORIE*/
                  Row(children: [
                    kategorienSymbol,
                    SizedBox(width: 10),
                    Text("Kategorie",
                        //lernKategorieList[lernort.kategorieID].name,
                        style: Theme.of(context).textTheme.headline4),
                  ]),
                  SizedBox(height: 20),

                  /* ADRESSE */
                  Row(children: [
                    Icon(FlutterIcons.location_arrow_faw5s,
                        size: 20, color: Color(0xff0b3e99)),
                    SizedBox(width: 10),
                    Flexible(
                      child: Text(
                          lernort.adresse == ""
                              ? "Keine Adresse vorhanden"
                              : lernort.adresse,
                          style: Theme.of(context).textTheme.headline4),
                    )
                  ]),
                  SizedBox(height: 20),

                  /* ÖFFNUNGSZEITEN */
                  Row(children: [
                    Icon(FlutterIcons.clock_faw5s,
                        size: 20, color: Color(0xff0b3e99)),
                    SizedBox(width: 10),
                    Text(
                        lernort.oeffnungszeiten == ""
                            ? "Keine Öffnungszeiten vorhanden"
                            : lernort.oeffnungszeiten,
                        style: Theme.of(context).textTheme.headline4),
                  ]),
                  SizedBox(height: 20),

                  /* KOSTEN */
                  Row(children: [
                    //Icon(MdiIcons.sword),
                    Icon(FlutterIcons.attach_money_mdi,
                        size: 20, color: Color(0xff0b3e99)),
                    SizedBox(width: 10),
                    Text(
                        lernort.kosten == "" ? "Keine Angaben" : lernort.kosten,
                        style: Theme.of(context).textTheme.headline4),
                  ]),
                  SizedBox(height: 20),

                  /* BARRIEREFREIHEIT */
                  Row(children: [
                    //Icon(MdiIcons.sword),
                    Icon(FlutterIcons.accessible_mdi,
                        size: 20, color: Color(0xff0b3e99)),
                    SizedBox(width: 10),
                    Text(
                        lernort.barrierefrei == 0
                            ? "nicht barrierefrei"
                            : "barrierefrei",
                        style: Theme.of(context).textTheme.headline4),
                  ]),
                  SizedBox(height: 20),

                  /* WEBSITE */
                  Container(child: setWebsite(widget.l)),
                  SizedBox(height: 20),

                  /*BESCHREIBUNG*/
                  Text(
                    lernort.kurzbeschreibung,
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(height: 50),
                  ImageButton(
                      children: <Widget>[],
                      /* 302 x 91 sind die Originalmaße der Buttons */
                      width: 302 / 1.5,
                      height: 91 / 1.5,
                      paddingTop: 5,
                      /* PressedImage gibt ein Bild für den Button im gedrückten 
                    Zustand an. Bisher nicht implementiert, muss aber mit dem
                    Bild im normalen zustand angegeben werden. */
                      pressedImage: Image.asset(
                        "assets/buttons/Lernort_dunkelblau_groß.png",
                      ),
                      unpressedImage: Image.asset(
                          "assets/buttons/Lernort_dunkelblau_groß.png"),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LernortScreen(l: lernort, k: "TODO")));
                      })
                ]))
          ])));
    }
  }
}
