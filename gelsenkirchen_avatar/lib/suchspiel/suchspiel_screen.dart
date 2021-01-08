import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/suchspiel/body.dart';
import 'package:gelsenkirchen_avatar/suchspiel/scan_screen.dart';
import 'package:gelsenkirchen_avatar/suchspiel/text_box.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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
