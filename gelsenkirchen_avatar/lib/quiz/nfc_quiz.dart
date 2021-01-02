import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';

class NFCQuiz extends StatefulWidget {
  @override
  _NFCQuizState createState() => _NFCQuizState();
}

class _NFCQuizState extends State<NFCQuiz> {
  List<Flexible> buchstabenFelder;

  List<String> wortList = new List();

  Widget build(BuildContext context) {
    String loesungswort = "Rotbuche";
    wortList = loesungswort.split("");
    print(wortList);

    buchstabenFelder = buildTextFields();

    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('NFC QUIZ'),
      ),
      body: Row(
        children: [
          for (int i = 0; i < buchstabenFelder.length; i++) buchstabenFelder[i]
        ],
      ),
    );
  }

  List<Flexible> buildTextFields() {
    List<Flexible> temp = new List();

    for (int i = 0; i < wortList.length; i++) {
      temp.add(Flexible(
          child: Padding(
              padding: const EdgeInsets.all(8.0), child: new TextFormField())));
    }

    return temp;
  }
}
