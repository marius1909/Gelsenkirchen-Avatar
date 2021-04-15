import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';
import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';
import 'freund_screen.dart';
import 'package:gelsenkirchen_avatar/data/freundschaft.dart';

class Freundesliste extends StatefulWidget {
  //loadFreunde

  @override
  _FreundeslisteState createState() => _FreundeslisteState();
}

class _FreundeslisteState extends State<Freundesliste> {
  List<Benutzer> freunde = new List();

  int currentSortStyle = 0;

  TextFormField freundHinzufuegenField;
  TextEditingController freundeHinzufuegenController = TextEditingController();

  var showAddFriendTextField = false;

  bool initComplete = false;

  @override
  Widget build(BuildContext context) {
    loadFriendList();
    initComplete = true;

    return Scaffold(
        drawer: NavDrawer(),
        backgroundColor: Colors.lightBlueAccent,
        appBar: AppBar(
          title: Text('Freunde'),
          //centerTitle: true,
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
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(

                                    //TODO: (nicht bis S&T machbar) Kaputt, navigator pushed random
                                    builder: (BuildContext context) =>
                                        Freund(freunde[index].id)));
                          },
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
                              fuegeFreundHinzu(
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

  //TODO: (nicht bis S&T machbar) Lädt zur zeit alle Benutzer zum testen soll aber auf Freundeslite arbeiten
  Future<void> loadFriendList() async {
    List<Benutzer> a =
        await Freundschaft.shared.gibFreunde(Benutzer.current.id);

    setState(() {
      freunde = a;
    });
  }

  // TODO: (nicht bis S&T machbar) Placeholder funktion geht später alle user durch und fuegt freund in datenbank ein
  void fuegeFreundHinzu(String _name) async {
    var neuerFreund = await Freundschaft.shared.neuerFreund(_name);

    Freundschaft neueFreundschaft = Freundschaft(
        benutzerID_1: Benutzer.current.id, benutzerID_2: neuerFreund.id);

    neueFreundschaft.insertIntoDatabase();
  }
}
