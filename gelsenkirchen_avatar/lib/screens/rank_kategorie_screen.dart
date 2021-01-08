import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RankKategorieScreen extends StatefulWidget {
  int id_lern_category;
  int id_user;
  String name_lern_category;

  RankKategorieScreen(
      this.id_lern_category, this.id_user, this.name_lern_category);

  @override
  _RankKategorieScreenState createState() => _RankKategorieScreenState();
}

class _RankKategorieScreenState extends State<RankKategorieScreen> {
  int limit = 10;
  dynamic data;

  Future<void> RankCategories() async {
    var url = "http://zukunft.sportsocke522.de/rank_categories.php?" +
        "id_user=" +
        widget.id_user.toString() +
        "&id_lern_category=" +
        widget.id_lern_category.toString() +
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
    // TODO: implement initState
    super.initState();
    RankCategories();
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
      dynamic lernCategories = data['data'];
      if (lernCategories != null) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.name_lern_category),
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              RichText(
                text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 17),
                    children: <TextSpan>[
                      TextSpan(text: "Your Rank : "),
                      TextSpan(
                          text: data['current_rank'].toString(),
                          style: TextStyle(color: Colors.red)),
                    ]),
              ),
              RichText(
                text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 17),
                    children: <TextSpan>[
                      TextSpan(text: "Your Score : "),
                      TextSpan(
                          text: data['current_point'].toString(),
                          style: TextStyle(color: Colors.red)),
                    ]),
              ),
              SizedBox(
                width: double.infinity,
                child: DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Rank',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'UserName',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Score',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                    rows: List<DataRow>.generate(
                      lernCategories.length,
                      (index) => DataRow(
                        cells: <DataCell>[
                          DataCell(Container(
                            child: Center(
                                child: Text(
                                    lernCategories[index]['rank'].toString())),
                            width: 20,
                          )),
                          DataCell(Container(
                              width: double.infinity,
                              child: Text(lernCategories[index]['username'] ==
                                          null ||
                                      lernCategories[index]['username'] == ""
                                  ? lernCategories[index]['email']
                                  : lernCategories[index]['username']))),
                          DataCell(Container(
                              width: 50,
                              child: Center(
                                  child: Text(lernCategories[index]
                                          ['sum_erfahrungspunkte']
                                      .toString())))),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        );
      } else {
        return Scaffold(
            appBar: AppBar(
              title: Text(widget.name_lern_category),
            ),
            body: new Container(
                margin: EdgeInsets.all(10.0),
                alignment: Alignment.topCenter,
                child: Center(
                    child: Text(
                        "There is no ranking for ${widget.name_lern_category}"))));
      }
    }
  }
}
