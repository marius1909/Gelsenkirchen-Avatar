import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';
import 'package:gelsenkirchen_avatar/unused/testfreund.dart';

import '../data/benutzer.dart';
import '../data/benutzer.dart';
import '../data/benutzer.dart';

class Freundesliste extends StatefulWidget {
  //loadFreunde

  @override
  _FreundeslisteState createState() => _FreundeslisteState();
}

class _FreundeslisteState extends State<Freundesliste> {
  List<Benutzer> freunde;

  int currentSortStyle = 0;

  TextFormField freundHinzufuegenField;
  TextEditingController freundeHinzufuegenController = TextEditingController();

  var showAddFriendTextField = false;

  bool initComplete = false;

  @override
  Widget build(BuildContext context) {
    if (!initComplete) {
      loadFriendList();
      initComplete = true;
    }

    return Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        appBar: AppBar(
          title: Text('Freundesliste'),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(05.0, 05.0, 30.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(width: 5),
                  Text("Level",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: 22),
                  Text("Name",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: 10),
                  Text("Sortieren",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  FlatButton(
                      onPressed: () {
                        if (currentSortStyle == 0) {
                          setState(() {
                            freunde.sort((a, b) => a.benutzer
                                .toLowerCase()
                                .compareTo(b.benutzer.toLowerCase()));
                            currentSortStyle++;
                          });
                        } else if (currentSortStyle == 1) {
                          setState(() {
                            freunde.sort((a, b) => a.id.compareTo(b.id));
                            currentSortStyle = 0;
                          });
                        }

                        //print(freunde[0]);

                        // var neuerBenutzer = Benutzer(
                        //     email: "hans@gmail.com",
                        //     benutzer: "Hans",
                        //     passwort: "1234567",
                        //     rolleID: 1);
                        // neuerBenutzer.insertIntoDatabase();

                        // print("Neuer Benutzer hinzugefügt");

                        // Benutzer.shared.removeFromDatabaseWithID({"id": "5"});

                        // var alleBenutzerFuture = Benutzer.shared.gibObjekte();
                        // alleBenutzerFuture.then((benutzer) {
                        //   benutzer.forEach((element) {
                        //     print(element);
                        //   });
                        // });
                      },
                      child: Icon(Icons.sort, color: Colors.white))
                ],
              ),
              SizedBox(height: 2),
              Expanded(
                child: SizedBox(
                  height: 400.00,
                  child: ListView.builder(
                      itemCount: freunde.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: ListTile(
                          onTap: () {},
                          title: Text(freunde[index].benutzer,
                              style: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 1.8,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)),
                          leading: Text(freunde[index].id.toString()),
                        ));
                      }),
                ),
              ),
              SizedBox(height: 5),
              FlatButton(
                color: Colors.blue[400],
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                splashColor: Colors.black,
                onPressed: () {
                  setState(() {
                    showAddFriendTextField = true;
                  });
                },
                child: Text(
                  "Freund hinzufügen",
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
              if (showAddFriendTextField == true)
                Expanded(
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                          width: 200,
                          child: freundHinzufuegenField = new TextFormField(
                              controller: freundeHinzufuegenController,
                              decoration: InputDecoration(hintText: "Name"))),
                      new FlatButton(
                          onPressed: () {
                            setState(() {
                              showAddFriendTextField = false;
                              FuegeFreundHinzu(
                                  freundeHinzufuegenController.text);
                            });
                          },
                          child: Icon(
                            Icons.check_box,
                            size: 30,
                          ))
                    ],
                  ),
                ),
            ],
          ),
        ));
  }

  //dummy funktion, soll später auf freundesliste datenbank arbeiten
  Future<void> loadFriendList() async {
    List<Benutzer> a = await Benutzer.shared.gibObjekte();

    setState(() {
      freunde = a;
    });
  }

  //dummy funktion geht später alle user durch und fuegt freund in datenbank ein
  void FuegeFreundHinzu(String _name) {
    print(_name);
  }
}
