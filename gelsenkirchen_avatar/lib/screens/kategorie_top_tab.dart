import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/lern_kategorie.dart';
import 'package:gelsenkirchen_avatar/screens/lernort_liste_screen_kategorie.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/cupertino.dart';

class KategorieTopTab extends StatefulWidget {
  @override
  _KategorieTopTabState createState() => _KategorieTopTabState();
}

class _KategorieTopTabState extends State<KategorieTopTab> {
  int _listLength = 0;
  List<LernKategorie> lernKategorieList = List();

  @override
  void initState() {
    super.initState();
    /* Erstellen einer Liste aus den vorhandenen Lernorten */
    var lernKategorieFuture = LernKategorie.shared.gibObjekte();
    lernKategorieFuture.then((lernkategorie) {
      setState(() {
        /* Zusätzliche Lernkategorie "Alle Lernorte" zum laden aller Lernorte */
        LernKategorie alleKategorien =
            LernKategorie(id: lernkategorie.length + 1, name: "Alle Lernorte");
        lernKategorieList.add(alleKategorien);
        /* Alphabetische Sortierung der Liste */
        lernkategorie.sort((a, b) => a.name.compareTo(b.name));
        lernKategorieList.addAll(lernkategorie);
        _listLength = lernKategorieList.length;
      });
    });
  }

  /*Diese Methode erstellt die ListViewItems*/
  Widget erstelleListViewitem(BuildContext context, int index) {
    Icon kategorienSymbol;
    Color symbolcolor = Color(0xff0e53c9);
    double symbolsize = 25;
    /* Erstellt Kategoriesymbol der jeweiligen Kategorie entsprechend */
    switch (lernKategorieList[index].id) {
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
          title: Row(
            children: [
              kategorienSymbol,
              SizedBox(
                width: 25,
              ),
              new Text(
                /*NAME*/
                lernKategorieList[index].name != null
                    ? lernKategorieList[index].name
                    : 'empty',
                style: Theme.of(context).textTheme.bodyText1,
                //new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          onTap: () {
            /*Hier kommt Aktion beim Klick auf Lernort hin*/
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LernortListeScreenKategorie(
                        lk: lernKategorieList[index])));
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
