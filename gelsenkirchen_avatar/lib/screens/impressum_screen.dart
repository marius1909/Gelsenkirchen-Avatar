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
      body: Stack(children: [
        /* IMPRESSUMHINTERGRUND */
        Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage(
                      "assets/images/Foerderturm_Hintergrund.png"),
                  fit: BoxFit.cover)),
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 25),
              /* GElernt!-Logo */
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Image.asset('assets/images/Gesamtlogo_xxhdpi.png',
                    width: 250, fit: BoxFit.fill),
              ),
              SizedBox(height: 25),
              Text(
                "Dies ist eine reine Prototypenanwendung",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(height: 25),
              Text(
                  'Diese Anwendung wurde im Rahmen des Softwareprojektes im Fachbereich Informatik der Westfälischen Hochschule Gelsenkirchen für das Projekt Zukunftsstadt 2030+ der Stadt Gelsenkirchen entwickelt.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1),
              SizedBox(height: 30),
              Text(
                  'Die Projektgruppe besteht aus folgenden Studierenden der Westfälischen Hochschule Gelsenkirchen:',
                  maxLines: 20,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1),
              SizedBox(height: 10),
              Text(
                  'Tobias Hoffmann \n Lisa Narewski \n Simon Schöpke \n Alexander Dünne \n Marius Weise \n Phuong Thao Nguyen',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1),
              SizedBox(height: 70),
              Row(
                children: [
                  SizedBox(width: 50),
                  /* WHS-Logo */
                  Container(
                    child:
                        Image.asset('assets/images/whs_Logo.png', width: 100),
                  ),
                  /* Gelsenkirchen-Logo */
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Image.asset('assets/images/gelsenkirchen_Logo.png',
                        width: 200),
                  ),
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
