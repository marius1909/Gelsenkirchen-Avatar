import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_icons/flutter_icons.dart';

class RankKategorieScreen extends StatefulWidget {
  final int lernCategoryID;
  final int userID;
  final String nameLernCategory;

  RankKategorieScreen(this.lernCategoryID, this.userID, this.nameLernCategory);

  @override
  _RankKategorieScreenState createState() => _RankKategorieScreenState();
}

class _RankKategorieScreenState extends State<RankKategorieScreen> {
  int limit = 10;
  dynamic data;

  Future<void> rankCategories() async {
    var url = "http://zukunft.sportsocke522.de/rank_categories.php?" +
        "id_user=" +
        widget.userID.toString() +
        "&id_lern_category=" +
        widget.lernCategoryID.toString() +
        "&limit=" +
        limit.toString();
    var res = await http.get(url);
    if (jsonDecode(res.body) == "Datensatz existiert nicht") {
      print('Datensatz nicht gefunden');
    } else {
      setState(() {
        data = jsonDecode(res.body);
        print(data);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    rankCategories();
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      /* Hier wäre ne Info für den Benutzer super ;) */
      return Scaffold(
          body: new Container(
              margin: EdgeInsets.all(10.0),
              alignment: Alignment.topCenter,
              child: Center(child: CircularProgressIndicator())));
    } else {
      dynamic lernCategories = data['data'];
      if (lernCategories != null) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.nameLernCategory),
          ),
          body: Column(
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(15, 40, 15, 40),
                  child: Column(children: [
                    Row(
                      children: [
                        Icon(FlutterIcons.arrow_up_faw5s,
                            size: 20, color: Color(0xff093582)),
                        SizedBox(width: 10),
                        Text("Dein Platz: " + data['current_rank'].toString(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline3),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(
                          FlutterIcons.coin_mco,
                          color: Color(0xff093582),
                        ),
                        SizedBox(width: 10),
                        Text(
                            "Deine Erfahrungspunkte: " +
                                data['current_point'].toString(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline3),
                      ],
                    )
                  ])),

              /* Tabelle mit dem Ranking */
              Expanded(
                  child: Container(
                      child: SizedBox(
                width: double.infinity,
                child: ListView(children: [
                  DataTable(
                      /* SPALTENKÖPFE */
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text('Platz',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        DataColumn(
                          label: Text('Name',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        DataColumn(
                          label: Text('Punkte',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                      rows: List<DataRow>.generate(
                        lernCategories.length,
                        (index) => DataRow(
                          cells: <DataCell>[
                            /* PLATZIERUNG */
                            DataCell(Container(
                              width: 20,
                              child: Center(
                                  child: Text(lernCategories[index]['rank']
                                      .toString())),
                            )),

                            /* BENUTZERNAME */
                            DataCell(Container(
                                width: 120,
                                //width: double.infinity,
                                child: Text(
                                  lernCategories[index]['username'] == null ||
                                          lernCategories[index]['username'] ==
                                              ""
                                      ? lernCategories[index]['email']
                                      : lernCategories[index]['username'],
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  softWrap: false,
                                ))),

                            /* ERFAHRUNGSPUNKTE */
                            DataCell(Container(
                                width: 50,
                                child: Center(
                                    child: Text(lernCategories[index]
                                            ['sum_erfahrungspunkte']
                                        .toString())))),
                          ],
                        ),
                      ))
                ]),
              )))
            ],
          ),
        );
      } else {
        return Scaffold(
            appBar: AppBar(
              title: Text(widget.nameLernCategory),
            ),
            body: Container(
                margin: EdgeInsets.all(10.0),
                alignment: Alignment.topCenter,
                child: Center(
                    child: Text(
                        "Es gibt keine Bestenliste für ${widget.nameLernCategory}"))));
      }
    }
  }
}
