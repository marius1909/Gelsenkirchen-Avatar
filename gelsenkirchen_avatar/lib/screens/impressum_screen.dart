import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';

//Sinnloser Kommentar um einen neuen Branche zu starten damit ich den schon mal machen kann und nicht ausversehen das direket in den Master schicke 
//TEST

class ImpressumScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Impressum'),
      ),
      body: Center(
          child: Text(
        "Dies ist eine reine Prototypenanwendung, sie ist nicht für die öffentliche Nutzung bestimmt. \n \nDiese Anwendung ist entstanden als Projekt der Westfählischen Hochschule \n\nDieser Prototyp wurde für die Stadt Gelsenkirchen und ihre Teilnahme an dem Wettbewerbt Zukunftsstadt 2030 erstellt.",
        textAlign: TextAlign.center,
      )),
    );
  }
}
