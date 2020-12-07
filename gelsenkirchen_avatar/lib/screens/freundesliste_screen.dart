import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';
import 'package:gelsenkirchen_avatar/screens/testfreund.dart';

class Freundesliste extends StatefulWidget {
  //loadFreunde

  @override
  _FreundeslisteState createState() => _FreundeslisteState();
}

class _FreundeslisteState extends State<Freundesliste> {
  var showAddFriendTextField = false;
  final List<Testfreund> testfreunde = [
    Testfreund("Freund1", "1", "*"),
    Testfreund("Freund2", "23", "*"),
    Testfreund("Freund3", "400", "*"),
    Testfreund("Freund4", "3", "*"),
    Testfreund("Freund5", "1", "*"),
    Testfreund("Freund6", "20", "*"),
    Testfreund("Freund7", "80", "*"),
    Testfreund("Freund8", "100", "*"),
    Testfreund("Freund9", "122", "*"),
    Testfreund("Freund10", "12", "*"),
    Testfreund("Freund11", "15", "*"),
    Testfreund("Freund12", "41", "*"),
    Testfreund("Freund13", "25", "*"),
    Testfreund("Freund14", "2", "*"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        appBar: AppBar(
          title: Text('Freundesliste'),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(05.0, 05.0, 30.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(width: 5),
                  Text("Level",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: 22),
                  Text("Name",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: 10),
                  Text("Sortieren",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  FlatButton(
                      onPressed: () {
                        // var neuerBenutzer = Benutzer(
                        //     email: "hans@gmail.com",
                        //     benutzer: "Hans",
                        //     passwort: "1234567",
                        //     rolleID: 1);
                        // neuerBenutzer.insertIntoDatabase();

                        // print("Neuer Benutzer hinzugefügt");

                        // Benutzer.shared.removeFromDatabaseWithID({"id": "5"});

                        // var alleBenutzerFuture = Benutzer.shared.gibObjekte();
                        // alleBenutzerFuture.then((benutzer) {
                        //   benutzer.forEach((element) {
                        //     print(element);
                        //   });
                        // });
                      },
                      child: Icon(Icons.sort, color: Colors.white))
                ],
              ),
              SizedBox(height: 2),
              Expanded(
                child: SizedBox(
                  height: 400.00,
                  child: ListView.builder(
                      itemCount: testfreunde.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: ListTile(
                          onTap: () {},
                          title: Text(testfreunde[index].name,
                              style: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 1.8,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)),
                          leading: Text(testfreunde[index].level),
                        ));
                      }),
                ),
              ),
              SizedBox(height: 5),
              FlatButton(
                color: Colors.blue[400],
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                splashColor: Colors.black,
                onPressed: () {
                  setState(() {
                    showAddFriendTextField = true;
                  });
                },
                child: Text(
                  "Freund hinzufügen",
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
              if (showAddFriendTextField == true)
                Expanded(
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                          width: 200,
                          child: new TextFormField(
                            decoration: InputDecoration(hintText: "Name"),
                          )),
                      new FlatButton(
                          onPressed: () {
                            setState(() {
                              showAddFriendTextField = false;
                            });
                          },
                          child: Icon(
                            Icons.check_box,
                            size: 30,
                          ))
                    ],
                  ),
                ),
            ],
          ),
        ));
  }
}
