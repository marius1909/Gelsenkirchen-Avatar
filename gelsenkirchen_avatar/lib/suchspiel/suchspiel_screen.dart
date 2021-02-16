import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/suchspiel/body.dart';
import 'package:gelsenkirchen_avatar/suchspiel/scan_screen.dart';

class Suchspiel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScanScreen(
      onScanned: (art) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Body(art: art,)));
      },
    );
  }
}
