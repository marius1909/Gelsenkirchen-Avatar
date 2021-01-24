import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';
import 'package:gelsenkirchen_avatar/screens/rank_kategorie_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_icons/flutter_icons.dart';

class ScoreBoard extends StatefulWidget {
  int id_user;

  ScoreBoard(this.id_user);

  @override
  _ScoreBoardState createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  dynamic data;
  int total_point;
  int level;

  Future<void> LernKategories() async {
    var url = "http://zukunft.sportsocke522.de/user_score_level.php?id=" +
        widget.id_user.toString();
    var res = await http.get(url);
    if (jsonDecode(res.body) == "Datensatz existiert nicht") {
      print('Datensatz nicht gefunden');
    } else {
      setState(() {
        data = jsonDecode(res.body)['data'];
        total_point = jsonDecode(res.body)['total_point'];
        level = jsonDecode(res.body)['level'];
        print(data);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LernKategories();
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
              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Column(
                children: [
                  Text(
                      "Glückwunsch," +
                          " ${Benutzer.current.benutzer == null || Benutzer.current.benutzer == "" ? Benutzer.current.email : Benutzer.current.benutzer}! ",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline1.apply(
                            color: Color(0xffe54b4b),
                          )),
                  SizedBox(height: 10),
                  Text(
                      "Du hast Level " +
                          level.toString() +
                          " erreicht, mit insgesamt " +
                          total_point.toString() +
                          " Erfahrungspunkten.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline3),
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
    return new Card(
        child: new Column(
      children: <Widget>[
        new ListTile(
          title: Row(
            children: [
              /* TODO: Kategoriesymbol einfügen. Vgl. kategorie_top_tab.dart, dort wurde das auch schon mal gemacht. (Lisa) */
              //kategorienSymbol,

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
                        widget.id_user,
                        data[index]['name'].toString())));
          },
        )
      ],
    ));
  }
}
