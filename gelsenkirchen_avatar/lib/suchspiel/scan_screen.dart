import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/suchspiel/qrcode_reader.dart';
import 'package:gelsenkirchen_avatar/suchspiel/suchspiel_art.dart';

class ScanScreen extends StatelessWidget {
  ScanScreen({this.onScanned});

  final Function(SuchspielArt) onScanned;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Suchspiel"),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image(
                image: AssetImage('assets/images/hand_phone.png'),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            scanButton("Scanne QR-Code, um das Spiel zu starten.", QRCodeReader(
              onQRCodeScanned: (code) {
                SuchspielArt art =
                    SuchspielExtension.fromAssociatedStartphrase(code);
                if (art != null) {
                  onScanned(art);
                } else {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Text("Ungültiger Code"),
                        content:
                            Text("Kein passendes Spiel zum QRCode gefunden."),
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
    );
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
    return FlatButton(
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
    );
  }
}
