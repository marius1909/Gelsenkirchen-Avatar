import 'package:flutter/material.dart';
import 'package:profil/profil.dart';

void main() => runApp(MaterialApp(
  home: ProfilBearbeiten(),
));




class  ProfilBearbeiten extends StatefulWidget {



  @override
  _ProfilBearbeitenState createState() => _ProfilBearbeitenState();
}

class _ProfilBearbeitenState extends State<ProfilBearbeiten> {
  final _controller = TextEditingController(text: "Spielername");  //get name from datenbank

  String nameString = ""; //get from Datenbank
  // bild von datenbank

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text('Profil bearbeiten'),
          centerTitle: true,
          backgroundColor: Colors.grey[850],
          elevation: 0.0,

        ),
        body: Padding(
            padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[ Text(
                        "Spielername",
                        style: TextStyle(
                            color: Colors.grey,
                            letterSpacing: 1.8
                        ),
                      ),
                        SizedBox(height: 10.0),
                        Container(width:100,
                          child:
                          TextField(
                            style: TextStyle(
                              color: Colors.amberAccent[200],
                              letterSpacing: 1.8,
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                            ),
                            controller: _controller,
                          ),


                       )
                      ],
                    ),


                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
                      child: IconButton(
                          icon: Icon(Icons.edit,
                              color: Colors.white),
                        onPressed: (){

                            setState(() {

                              nameString = _controller.text;
                            });

                        },
                       ),
                    )

                  ],
                ),

                Divider(
                  height: 50.0,
                  color: Colors.grey[800],
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/profilbild.jpg'),
                      radius: 50,

                    ),

                    IconButton(
                      icon: Icon(Icons.edit,
                          color: Colors.white),
                    ) ],
                ),
                SizedBox(height: 250),
                Divider(
                  height: 40.0,
                  color: Colors.grey[800],
                ),

                FlatButton(
                  color: Colors.grey[800],
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.black,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Speichern",
                    style: TextStyle(fontSize: 25.0),
                  ),
                )  ],

            )
        )
    );
  }
}
