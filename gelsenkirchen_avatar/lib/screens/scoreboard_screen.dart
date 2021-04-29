import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';
import 'package:gelsenkirchen_avatar/screens/rank_kategorie_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ScoreBoard extends StatefulWidget {
  final int userID;

  ScoreBoard(this.userID);

  @override
  _ScoreBoardState createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  dynamic data;
  int totalPoints;
  int level;
  final int erfahrung = Benutzer.current.erfahrung;

  Future<void> lernKategories() async {
    var url = "http://zukunft.sportsocke522.de/user_score_level.php?id=" +
        widget.userID.toString();
    var res = await http.get(url);
    if (jsonDecode(res.body) == "Datensatz existiert nicht") {
      print('Datensatz nicht gefunden');
    } else {
      setState(() {
        data = jsonDecode(res.body)['data'];
        totalPoints = jsonDecode(res.body)['total_point'];
        level = jsonDecode(res.body)['level'];
        print(data);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    lernKategories();
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Scaffold(
          body: new Container(
              margin: EdgeInsets.all(10.0),
              alignment: Alignment.topCenter,
              child: Center(child: CircularProgressIndicator())));
    } else {
      return Scaffold(
        appBar: AppBar(
          /*NAME*/
          title: Text("Bestenliste"),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(15, 40, 15, 20),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(
                      FlutterIcons.like1_ant,
                      size: 20,
                      color: Color(0xffe54b4b),
                    ),
                    SizedBox(width: 10),
                    Text(
                        "Glückwunsch," +
                            " ${Benutzer.current.benutzer == null || Benutzer.current.benutzer == "" ? Benutzer.current.email : Benutzer.current.benutzer}! ",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline1.apply(
                              color: Color(0xffe54b4b),
                            )),
                  ]),
                  SizedBox(height: 10),
                  Text(
                      "Du hast Level " +
                          level.toString() +
                          " erreicht, mit insgesamt " +
                          totalPoints.toString() +
                          " Erfahrungspunkten.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline3),
                  SizedBox(height: 20),
                  Center(
                    child: Container(
                      height: 22,
                      width: 200,
                      child: Align(
                        alignment: Alignment(0, 0),
                        child: LinearPercentIndicator(
                          width: 200,
                          lineHeight: 22,
                          percent: berechnelvlProzent(erfahrung),
                          backgroundColor: Color(0xff0d4dbb),
                          progressColor: Color(0xff2d75f0),
                          center: Text(
                            "Level " + berechneLevel(erfahrung).toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: data.length,
              itemBuilder: erstelleListViewitem,
              padding: EdgeInsets.all(0.0),
            ))
          ],
        ),
      );
    }
  }

  /*Diese Methode erstellt die ListViewItems*/
  Widget erstelleListViewitem(BuildContext context, int index) {
    Icon kategorienSymbol;
    Color symbolcolor = Color(0xff0b3e99);
    double symbolsize = 25;
    switch (int.parse(data[index]['id'])) {
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

    return Card(
        child: Column(
      children: <Widget>[
        ListTile(
          title: Row(
            children: [
              kategorienSymbol,
              SizedBox(
                width: 25,
              ),
              Text(
                data[index]['name'].toString(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Spacer(),
              Text(
                data[index]['erfahrungspunkte'].toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .apply(color: Color(0xffff9f1c)),
              ),
              SizedBox(width: 5),
              Icon(
                FlutterIcons.coin_mco,
                color: Color(0xffff9f1c),
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => RankKategorieScreen(
                        int.parse(data[index]['id']),
                        widget.userID,
                        data[index]['name'].toString())));
          },
        )
      ],
    ));
  }
}

int berechneLevel(int xp) {
  int lvl = 0;
  if (xp < 30) {
    lvl = 1;
  } else if (xp < 51) {
    lvl = 2;
  } else {
    int minxp = 51;
    minxp = (minxp.toDouble() * 1.7).toInt();
    lvl = 3;
    while (xp >= minxp) {
      minxp = (minxp.toDouble() * 1.7).toInt();
      lvl++;
    }
  }
  return lvl;
}

double berechnelvlProzent(int xp) {
  double prozent = 0.0;
  if (xp < 30) {
    prozent = xp / 30;
  } else if (xp < 51) {
    prozent = (xp - 30) / (51 - 30);
  } else {
    int minxp = 51;
    int maxxp = (minxp.toDouble() * 1.7).toInt();
    prozent = (xp - minxp) / (maxxp - minxp);
    while (xp >= maxxp) {
      minxp = maxxp;
      maxxp = (minxp.toDouble() * 1.7).toInt();
      prozent = (xp - minxp) / (maxxp - minxp);
    }
  }
  return prozent;
}
