import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';
import 'package:gelsenkirchen_avatar/widgets/ladescreen.dart';
import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';
import 'freund_screen.dart';
import 'package:gelsenkirchen_avatar/data/freundschaft.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:imagebutton/imagebutton.dart';

class Freundesliste extends StatefulWidget {
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
          appBar: AppBar(
              title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(
                    "Freunde",
                  ),
                ),
                /* Alphabetisch sortieren */
                Container(
                  child: IconButton(
                      icon: Icon(FlutterIcons.sort_by_alpha_mdi,
                          color: Colors.white),
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
                      }),
                ),
              ],
            ),
          )),
          body: Padding(
              padding: EdgeInsets.fromLTRB(15, 40, 15, 20),
              child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 5),
                        Text(
                          "Level",
                        ),
                        SizedBox(width: 25),
                        Text(
                          "Name",
                        ),
                        //SizedBox(width: 10),
                        /* Text("Sortieren",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)), */
                        /* Sortieren*/
                        /* FlatButton(
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
                            child: Icon(FlutterIcons.sort_by_alpha_mdi,
                                color: Colors.black)) */
                      ],
                    ),
                    //SizedBox(height: 2),
                    Expanded(
                      child: ListView.builder(
                        itemCount: freunde.length,
                        itemBuilder: erstelleListViewitem,
                        /*  (context, index) {
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
                                        //letterSpacing: 1.8,
                                        //fontSize: 20.0,
                                        //fontWeight: FontWeight.bold
                                      )),
                                  leading: Text(
                                      berechneLevel(freunde[index].erfahrung)
                                          .toString()),
                                  trailing: IconButton(
                                      icon: Icon(FlutterIcons.delete_mdi,
                                          color: Color(0xffe54b4b)),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: Text(
                                                      "Aus Freundesliste entfernen?",
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xff0b3e99))),
                                                  content: Text("Möchtest du " +
                                                      freunde[index].benutzer +
                                                      " wirklich aus deiner Freundesliste entfernen?"),
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
                                                                      .current
                                                                      .id,
                                                                  freunde[index]
                                                                      .id);
                                                          Navigator.pop(
                                                              context);
                                                        }),
                                                        child: Text("Ja"))
                                                  ],
                                                ),
                                            barrierDismissible: true);
                                      })),
                            ); 
                          }*/
                      ),
                    ),

                    /* FREUND HINZUFÜGEN */

                    Container(
                        //width: 200,
                        child: TextFormField(
                      decoration: new InputDecoration(
                        /*Prompt*/
                        labelText: "Name",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                      //keyboardType: TextInputType.emailAddress,
                      controller: freundeHinzufuegenController,
                    )),
                    SizedBox(height: 20),
                    ImageButton(
                      children: <Widget>[],
                      /* 302 x 91 sind die Originalmaße der Buttons */
                      width: 302 / 1.3,
                      height: 91 / 1.3,
                      paddingTop: 5,
                      /* PressedImage gibt ein Bild für den Button im gedrückten 
                    Zustand an. Bisher nicht implementiert, muss aber mit dem
                    Bild im normalen zustand angegeben werden. */
                      pressedImage: Image.asset(
                        "assets/buttons/Adden_dunkelblau_groß.png",
                      ),
                      unpressedImage: Image.asset(
                          "assets/buttons/Adden_dunkelblau_groß.png"),
                      onTap: () {
                        fuegeFreundHinzu(freundeHinzufuegenController.text);
                      },
                    ),

                    /* SizedBox(height: 5),
                FlatButton(
                  color: Colors.blue[400],
                  textColor: Colors.black,
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
                  ), */
                  ])));
    }
  }

  /* Fügt den eingegebenen Freund der Freundesliste hinzu */
  void fuegeFreundHinzu(String _name) async {
    //FocusScope.of(context).requestFocus(FocusNode());
    /* Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => super.widget)); */
    /* TODO: Refresh Screen beim hinzufügen */
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => Freundesliste()));
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

    setState(() {});
  }

  Future<bool> ladeAsyncDaten() async {
    freunde = await Freundschaft.shared.gibFreunde(Benutzer.current.id);

    return true;
  }

  /*Diese Methode erstellt die ListViewItems*/
  Widget erstelleListViewitem(BuildContext context, int index) {
    return Card(
      child: Column(children: <Widget>[
        ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Freund(freunde[index],
                          berechneLevel(freunde[index].erfahrung))));
            },
            title: Text(freunde[index].benutzer,
                style: TextStyle(
                  color: Colors.black,
                  //letterSpacing: 1.8,
                  //fontSize: 20.0,
                  //fontWeight: FontWeight.bold
                )),
            leading: Text(berechneLevel(freunde[index].erfahrung).toString()),
            trailing: IconButton(
                icon: Icon(FlutterIcons.delete_mdi, color: Color(0xffe54b4b)),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text("Aus Freundesliste entfernen?",
                                style: TextStyle(color: Color(0xff0b3e99))),
                            content: Text("Möchtest du " +
                                freunde[index].benutzer +
                                " wirklich aus deiner Freundesliste entfernen?"),
                            actions: [
                              FlatButton(
                                  onPressed: (() async {
                                    await Freundschaft.shared.removeFreund(
                                        Benutzer.current.id, freunde[index].id);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                super.widget));
                                  }),
                                  child: Text("Ja")),
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  },
                                  child: Text("Nein"))
                            ],
                          ),
                      barrierDismissible: true);
                }))
      ]),
    );
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

/* Widget _customAppBar(BuildContext context) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: Text(
            "Freunde",
          ),
        ),
        Container(
          child: IconButton(
              icon: Icon(FlutterIcons.sort_by_alpha_mdi, color: Colors.white),
              onPressed: () {if (currentSortStyle == 0) {
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
              }),
        ),
      ],
    ),
  );
} */
