import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/suchspiel/qrcode_reader.dart';
import 'package:gelsenkirchen_avatar/suchspiel/suchspiel_art.dart';
import 'package:imagebutton/imagebutton.dart';

class ScanScreen extends StatelessWidget {
  ScanScreen({this.onScanned});

  final Function(SuchspielArt) onScanned;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("QR-Suchspiel"),
          backgroundColor: Color(0xff98ce00),
        ),
        body: SizedBox.expand(
          child: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /* HEADLINE "QR-SUCHSPIEL" */
                Container(
                  padding: EdgeInsets.fromLTRB(15, 40, 15, 40),
                  child: Text(
                    "QR-Suchspiel",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Ccaps",
                        fontSize: 35.0,
                        color: Color(0xff98ce00)),
                  ),
                ),
                /* BILD */
                Image(
                  image: AssetImage('assets/images/hand_phone.png'),
                  width: 180,
                ),
                /* Altes Bild */
                /* ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image(
                    image: AssetImage('assets/images/hand_phone.png'),
                  ),
                ), */
                SizedBox(
                  height: 40,
                ),

                /* BESCHREIBUNG */
                Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 40),
                  child: Text(
                    "Scanne einen QR-Code in der Nähe eines Lernortes. Anschließend erscheint ein Hinweis auf ein gesuchtes Wort, dass mit dem Lernort zu tun hat. Deine Aufgabe ist es, mit Hilfe von möglichst wenigen Hinweisen das gesuchte Wort zu erraten. Du hast 20 Sekunden Zeit, bis ein neuer Hinweis erscheint. Du denkst, du hast das Wort erraten? Dann tippe es unten in das Textfeld ein, die Anzahl der Boxen gibt dabei die Anzahl der Buchstaben des Wortes an. Ist das Wort richtig, ist das Spiel beendet.\nDrücke Start und und lass uns sehen wie viel du schon über den Lernort weißt.",
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                scanButton("Scanne QR-Code, um das Spiel zu starten.",
                    QRCodeReader(
                  onQRCodeScanned: (code) {
                    SuchspielArt art =
                        SuchspielExtension.fromAssociatedStartphrase(code);
                    if (art != null) {
                      onScanned(art);
                    } else {
                      showDialog(
                        context: context,
                        builder: (_) {
                          /* Dialog, der angezeigt wird, wenn ein falscher QR-Code gescannt wurde. */
                          return AlertDialog(
                            title: Text("Ungültiger QR-Code",
                                style: TextStyle(color: Color(0xff98ce00))),
                            content: Text(
                                "Zu diesem QR-Code wurde kein passendes Spiel gefunden. Bitte scanne einen anderen QR-Code."),
                            actions: [okButton(context)],
                          );
                        },
                      );
                    }
                  },
                ), context),
              ],
            ),
          ),
        ));
  }

  Widget okButton(BuildContext context) {
    return FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context, true);
        Navigator.pop(context, true);
      },
    );
  }

  Widget scanButton(String text, Widget widget, BuildContext context) {
    return /* SPIELEN-BUTTON */
        ImageButton(
            children: <Widget>[],
            /* 302 x 91 sind die Originalmaße der Buttons */
            width: 302 / 1.3,
            height: 91 / 1.3,
            paddingTop: 5,
            /* PressedImage gibt ein Bild für den Button im gedrückten 
                    Zustand an. Bisher nicht implementiert, muss aber mit dem
                    Bild im normalen Zustand angegeben werden. */
            pressedImage: Image.asset(
              "assets/buttons/Spielen_gruen_groß.png",
            ),
            unpressedImage:
                Image.asset("assets/buttons/Spielen_gruen_groß.png"),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => widget));
            });
    /* Alter Spiel-Starten-Button */
    /* return FlatButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => widget));
      },
      child: Text(
        "Scanne QR-Code, um das Spiel zu starten.",
        style: TextStyle(fontSize: 20),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.blue)),
    ); */
  }
}
