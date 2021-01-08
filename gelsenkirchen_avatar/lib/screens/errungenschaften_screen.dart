import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/sammelbares.dart';

class ErrungenschaftenScreen extends StatefulWidget {
  @override
  _ErrungenschaftenScreen createState() => _ErrungenschaftenScreen();
}

class _ErrungenschaftenScreen extends State<ErrungenschaftenScreen> {
  List<Sammelbares> sammelbaresList;

  @override
  Widget build(BuildContext context) {
    loadErrungenschaften();

    return Scaffold(
        appBar: AppBar(
          title: Text('Profil'),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Padding(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
            child: Column(children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 400.00,
                  child: ListView.builder(
                      itemCount: sammelbaresList.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: <Widget>[
                            Text(sammelbaresList[index].beschreibung),
                            //Text(sammelbaresList[index].id.toString()),
                            // Text(sammelbaresList[index].name.toString())
                          ],
                        );
                      }),
                ),
              )
            ])));
  }

//Placeholder lädt Errungenschaften. Muss erweiteret werden das nur die Errungenschaften des aktuellen nutzers geladen werden
  Future<void> loadErrungenschaften() async {
    List<Sammelbares> a = await Sammelbares.shared.gibObjekte();

    setState(() {
      sammelbaresList = a;
    });
  }
}
