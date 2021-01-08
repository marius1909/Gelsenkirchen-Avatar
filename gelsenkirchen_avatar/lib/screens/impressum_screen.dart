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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: Image.asset('assets/images/wettbewerb_Logo.png',
                            width: 150, fit: BoxFit.fill),
                      ),
                      Text(
                        '''Dies ist eine reine Prototypenanwendung \n''',
                        maxLines: 20,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Center(
                        child: Text(
                          'Diese Anwendung ist für den Wettbewerb \nZukunftsstadt 2030 Für die Stadt Gelsenkrichen gedacht.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: Image.asset(
                            'assets/images/gelsenkirchen_Logo.png',
                            width: 250,
                            fit: BoxFit.fill),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        //padding: EdgeInsets.all(20),
                        //color: Colors.cyan,
                        child: Image.asset('assets/images/whs_Logo.png',
                            width: 275, fit: BoxFit.fill),
                      ),
                      Text(
                        '''Entwickelt wurde diese Anwednung im Rahmen des \nSoftware Prjektes der Westfählischen Hochsuchel im \nFachbereich Informatik.\n''',
                        maxLines: 20,
                        textAlign: TextAlign.center,
                      ),
                      Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Center(
                            child: Text(
                              'Die Projektgruppe besteht aus: \n\n Tobias Hoffmann \n Lisa Narewski \n Simon Schöpke \n Alexander Dünne \n Marisu Weise \n Phuong Thao Nguyen',
                              textAlign: TextAlign.center,
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ],

            //Container(padding: EdgeInsets.fromLTRB(10, 20, 30, 40), //Space Inside
            //margin: EdgeInsets.all(30),   //space Outsite
            //color: Colors.grey[400],
            //child: Text('TEST')),

            //child: Image(
            //  image: AssetImage('assets/images/whs_Logo.png'),
            //),

            //    child: Text(
            //  "Dies ist eine reine Prototypenanwendung, sie ist nicht für die öffentliche Nutzung bestimmt. \n \nDiese Anwendung ist entstanden als Projekt der Westfählischen Hochschule \n\nDieser Prototyp wurde für die Stadt Gelsenkirchen und ihre Teilnahme an dem Wettbewerbt Zukunftsstadt 2030 erstellt.",
            //  textAlign: TextAlign.center,
          ),
        ));
  }
}
