import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';
import 'package:gelsenkirchen_avatar/widgets/ladescreen.dart';
import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';
import 'freund_screen.dart';
import 'package:gelsenkirchen_avatar/data/freundschaft.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  var _asyncResult;
  @override
  void initState() {
    super.initState();

    ladeAsyncDaten().then((result) {
      setState(() {
        _asyncResult = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_asyncResult == null) {
      return Ladescreen();
    } else {
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
                                          builder: (BuildContext context) =>
                                              Freund(
                                                  freunde[index],
                                                  berechneLevel(freunde[index]
                                                      .erfahrung))));
                                },
                                title: Text(freunde[index].benutzer,
                                    style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 1.8,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                                leading: Text(
                                    berechneLevel(freunde[index].erfahrung)
                                        .toString()),
                                trailing: IconButton(
                                    icon: Icon(Icons.remove_circle_outlined),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text(
                                                    "Aus Freundesliste entfernen?"),
                                                content: Text(
                                                    "Möchtest du wirklich " +
                                                        freunde[index]
                                                            .benutzer +
                                                        " aus deiner Freundesliste entfernen?"),
                                                actions: [
                                                  FlatButton(
                                                      onPressed: (() =>
                                                          Navigator.pop(
                                                              context)),
                                                      child: Text("Nein")),
                                                  FlatButton(
                                                      onPressed: (() async {
                                                        await Freundschaft
                                                            .shared
                                                            .removeFreund(
                                                                Benutzer
                                                                    .current.id,
                                                                freunde[index]
                                                                    .id);
                                                        Navigator.pop(context);
                                                      }),
                                                      child: Text("Ja"))
                                                ],
                                              ),
                                          barrierDismissible: true);
                                    })),
                          );
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
  }

  /* Fügt den eingegebenen Freund der Freundesliste hinzu */
  void fuegeFreundHinzu(String _name) async {
    var neuerFreund = await Freundschaft.shared.neuerFreund(_name);

    if (neuerFreund == null) {
      Fluttertoast.showToast(
          msg: "Der angegebene Benutzer existiert nicht",
          toastLength: Toast.LENGTH_SHORT);
    } else {
      Freundschaft neueFreundschaft = Freundschaft(
          benutzerID_1: Benutzer.current.id, benutzerID_2: neuerFreund.id);

      neueFreundschaft.insertIntoDatabase();
    }
  }

  Future<bool> ladeAsyncDaten() async {
    // freunde = await Freundschaft.shared.gibFreunde(Benutzer.current.id);
    // TODO: durch Benutzer.current.id ersetzen
    freunde = await Freundschaft.shared.gibFreunde(128);
    return true;
  }
}

/* Berechnet das Level aus den Erfahrungspunkten des Spielers */
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
