import 'package:flutter/material.dart';
import 'profil_bearbeiten.dart';

class  Profil extends StatelessWidget {


   Text spielername = new Text(
    "Spielername",
    style: TextStyle(
      color: Colors.amberAccent[200],
      letterSpacing: 1.8,
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text('Profil'),
          centerTitle: true,
          backgroundColor: Colors.grey[850],
          elevation: 0.0,

        ),
        body: Padding(
            padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[ Text(
                        'NAME',
                        style: TextStyle(
                            color: Colors.grey,
                            letterSpacing: 1.8
                        ),
                      ),
                        SizedBox(height: 10.0),
                        spielername,
                      ],
                    ),
                    SizedBox(width: 40.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[  Text(
                        'Level',
                        style: TextStyle(
                            color: Colors.grey,
                            letterSpacing: 1.8
                        ),
                      ),
                        SizedBox(height: 10.0),
                        Text(
                          '8',
                          style: TextStyle(
                            color: Colors.amberAccent[200],
                            letterSpacing: 1.8,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),


                  ],
                ),

                Divider(
                  height: 50.0,
                  color: Colors.grey[800],
                ),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/profilbild.jpg'),
                  radius: 100,

                ),
                SizedBox(height: 200),

                FlatButton(
                  color: Colors.grey[800],
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilBearbeiten()),
                    );
                  },
                  child: Text(
                    "Profil bearbeiten",
                    style: TextStyle(fontSize: 20.0),
                  ),
                )
              ],

            )
        )
    );
  }

  String getText(){
    return spielername.data;
   }
}
