import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';
import 'package:gelsenkirchen_avatar/data/memoryspiel.dart';
import 'package:gelsenkirchen_avatar/memory/memorypage.dart';
import 'package:http/http.dart' as http;
import 'package:imagebutton/imagebutton.dart';

// ignore: must_be_immutable
class StartMemory extends StatefulWidget {
  int id;

  StartMemory(this.id);

  @override
  _StartMemoryState createState() => _StartMemoryState();
}

class _StartMemoryState extends State<StartMemory> {
  dynamic data;
  List<Memoryspiel> memorylist;

  void getLernort() async {
    var id = widget.id;
    var url =
        "http://zukunft.sportsocke522.de/get_lernortID.php?id=" + id.toString();

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

  void initState() {
    getLernort();
    var id = widget.id;
    var memoryspielFuture = Memoryspiel.shared.sucheObjekt("lernortID", id);
    // var memoryspielFuture = Memoryspiel.shared.gibObjekte();
    memoryspielFuture.then((value) {
      setState(() {
        memorylist = value;

        print(memorylist);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (memorylist == null || data == null) {
      return Scaffold(
          body: new Container(
              margin: EdgeInsets.all(10.0),
              alignment: Alignment.topCenter,
              child: Center(child: CircularProgressIndicator())));
    } else if (memorylist.isEmpty) {
      return Scaffold(
          body: Container(
              margin: EdgeInsets.all(10.0),
              alignment: Alignment.topCenter,
              child: Center(
                  child: Text(
                      "Kein Memoryspiel für " + data['name'] + " vorhanden"))));
    } else {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff093582),
            title: Text(
              //Name von aktuellen Lernort
              data['name'] + " - Memory",
            ),
          ),
          body: SingleChildScrollView(
              child: Column(children: [
            /* HEADLINE "QUIZ" */
            Container(
              padding: EdgeInsets.fromLTRB(15, 40, 15, 40),
              child: Text(
                "Memory",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Ccaps",
                    fontSize: 35.0,
                    color: Color(0xff093582)),
              ),
            ),

            /* BESCHREIBUNG */
            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
              child: Text(
                "In diesem Minispiel musst du die passenden Paare finden. Am Anfang des Spiels hast du die Möglichkeit dir möglichst viele Paare zu merken. Sobald die Zeit abgelauften ist, versuchst du die zugehörigen Karten zu finden. Durch das Klicken auf eine Karte, wird diese aufgedeckt. Falls du ein Paar gefunden hast, bleiben die Karten aufgedeckt, falls nicht werden die entsprechenden Karten wieder umgedreht. Das Spiel endet sobald alle Paare gefunden worden sind. Je schneller du dabei warst, desto mehr Punkte erhälst du!",
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 40, 15, 20),
              child: Text(
                "Aufgabe Memory " + data['name'],
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Ccaps",
                    fontSize: 20.0,
                    color: Color(0xff093582)),
              ),
            ),

            /* BESCHREIBUNG */
            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 40),
              child: Text(
                memorylist[0].aufgabe,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),

            /* SPIELEN-BUTTON */
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
                  "assets/buttons/Spielen_dunkelblau_groß.png",
                ),
                unpressedImage:
                    Image.asset("assets/buttons/Spielen_dunkelblau_groß.png"),
                onTap: () {
                  if (Benutzer.current?.id != null) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MemoryPage(
                            benutzerID: Benutzer.current.id,
                            lernKategorieID: int.parse(data['kategorieID']),
                            lernortID: int.parse(data['id']),
                            title: data['name'],
                            memoryID: memorylist[0].id,
                            aufgabe: memorylist[0].aufgabe,
                            erfahrungspunkte: memorylist[0].erfahrungspunkte)));
                  } else {
                    Fluttertoast.showToast(
                        msg: "Bitte melde dich an, um dieses Spiel zu spielen.",
                        toastLength: Toast.LENGTH_SHORT);
                  }
                })
          ])));
    }
  }
}
