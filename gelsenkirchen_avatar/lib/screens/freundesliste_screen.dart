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
                /* Liste alphabetisch sortieren */
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
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Column(children: [
                freunde.isNotEmpty == true
                    ?
                    /* LISTENKÖPFE */
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
                        ],
                      )
                    : new Container(
                        child: Center(
                            child: Container(
                        padding: EdgeInsets.fromLTRB(15, 50, 15, 0),
                        child: Text(
                            "Du hast noch keine Freunde. Füg' doch einfach einen über das Textfeld unten hinzu.",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline3),
                      ))),
                /* FREUNDESLISTE */
                Expanded(
                  child: ListView.builder(
                    itemCount: freunde.length,
                    itemBuilder: erstelleListViewitem,
                  ),
                ),

                /* FREUND HINZUFÜGEN */
                Container(
                    //width: 200,
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child:
                        /* BENUTZERNAME EINES ANDERES BENUTZERS */
                        TextFormField(
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
                /* FREUND-HINZUFÜGEN-BUTTON */
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
                  unpressedImage:
                      Image.asset("assets/buttons/Adden_dunkelblau_groß.png"),
                  onTap: () {
                    fuegeFreundHinzu(freundeHinzufuegenController.text);
                  },
                ),
              ])));
    }
  }

  /* Fügt den eingegebenen Freund der Freundesliste hinzu */
  void fuegeFreundHinzu(String _name) async {
    if (_name != Benutzer.current.benutzer) {
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
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => super.widget));
    }
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
                )),
            leading: Text(berechneLevel(freunde[index].erfahrung).toString()),
            trailing:
                /* FREUND-LÖSCHEN-BUTTON */
                IconButton(
                    icon:
                        Icon(FlutterIcons.delete_mdi, color: Color(0xffe54b4b)),
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
                                            Benutzer.current.id,
                                            freunde[index].id);
                                        setState(() {});
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        super.widget));
                                      }),
                                      child: Text("Ja")),
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
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
