import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gelsenkirchen_avatar/data/Avatar.dart';
import 'package:gelsenkirchen_avatar/data/dummyprofil.dart';
import 'package:imagebutton/imagebutton.dart';

// ignore: camel_case_types
class Avatarbearbeiten extends StatefulWidget {
  @override
  _AvatarbearbeitenState createState() => _AvatarbearbeitenState();
}

//@Lisa
/* List<List<Avatar>> avatare = loadInfo.loadAlleAvatare();

    for (var i = 0; i < avatare.length; i++) {
      for (var j = 0; j < avatare[i].length; j++) {
        print(b[i][j]);
      }
    }
    */
//Wenn auf Avatar klick => speicher TypID und collectablesausgerüstetID in Datenbank

class _AvatarbearbeitenState extends State<Avatarbearbeiten> {
  List<Avatar> verfuegbareAvatare;

  @override
  void initState() {
    super.initState();

//Basisavatare
    verfuegbareAvatare = [
      Avatar(0, 0),
      Avatar(1, 0),
      Avatar(2, 0),
      Avatar(3, 0)
    ];
  }

  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();

      //TODO: Verfuebarer Avatare zur liste hinzufügen
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Avatar auswählen'),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Text("Wähle deinen Avatar",
                  style: Theme.of(context).textTheme.headline3),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
              child: CarouselSlider(
                /* TODO: (nicht bis S&T machbar) Muss mit allen freigeschalteten Errungenschaften gefüllt werden (Lisa) */
                items: [
                  FlatButton(
                    onPressed: () {
                      dummyprofil.setAvatar(0, [0]);
                    },
                    child: Container(
                      margin: EdgeInsets.all(6.0),
                      child: Image.asset(Avatar(0, 0).imagePath, height: 300),
                    ),
                  ),

                  //1. Bild im Slider Blau
                  FlatButton(
                    onPressed: () {
                      dummyprofil.setAvatar(0, [1]);
                    },
                    child: Container(
                      margin: EdgeInsets.all(6.0),
                      child: Image.asset(Avatar(0, 1).imagePath, height: 300),
                    ),
                  ),
                  //2. Bild im Slider Blau
                  FlatButton(
                    onPressed: () {
                      dummyprofil.setAvatar(0, [2]);
                    },
                    child: Container(
                      margin: EdgeInsets.all(6.0),
                      child: Image.asset(Avatar(0, 2).imagePath, height: 300),
                    ),
                  ),
                  //3. Bild im Slider Blau
                  FlatButton(
                    onPressed: () {
                      dummyprofil.setAvatar(0, [1, 2]);
                    },
                    child: Container(
                      margin: EdgeInsets.all(6.0),
                      child: Image.asset(Avatar(0, 3).imagePath, height: 300),
                    ),
                  ),
                  //3. Bild im Slider Blau
                  FlatButton(
                    onPressed: () {
                      dummyprofil.setAvatar(0, [4]);
                    },
                    child: Container(
                      margin: EdgeInsets.all(6.0),
                      child: Image.asset(Avatar(0, 4).imagePath, height: 300),
                    ),
                  ),
                  //4. Bild im Slider Blau
                  FlatButton(
                    onPressed: () {
                      dummyprofil.setAvatar(0, [1, 4]);
                    },
                    child: Container(
                      margin: EdgeInsets.all(6.0),
                      child: Image.asset(Avatar(0, 5).imagePath, height: 300),
                    ),
                  ),
                  //5. Bild im Slider Blau
                  FlatButton(
                    onPressed: () {
                      dummyprofil.setAvatar(0, [2, 4]);
                    },
                    child: Container(
                      margin: EdgeInsets.all(6.0),
                      child: Image.asset(Avatar(0, 6).imagePath, height: 300),
                    ),
                  ),
                  //6. Bild im Slider Blau
                  FlatButton(
                    onPressed: () {
                      dummyprofil.setAvatar(0, [1, 2, 4]);
                    },
                    child: Container(
                      margin: EdgeInsets.all(6.0),
                      child: Image.asset(Avatar(0, 7).imagePath, height: 300),
                    ),
                  ),

                  //1. Bild im Slider Gelb
                  FlatButton(
                    onPressed: () {
                      dummyprofil.setAvatar(1, [0]);
                    },
                    child: Container(
                      margin: EdgeInsets.all(6.0),
                      child: Image.asset(Avatar(1, 0).imagePath, height: 300),
                    ),
                  ),
                  //2. Bild im Slider Gelb
                  FlatButton(
                    onPressed: () {
                      dummyprofil.setAvatar(1, [1]);
                    },
                    child: Container(
                      margin: EdgeInsets.all(6.0),
                      child: Image.asset(Avatar(1, 1).imagePath, height: 300),
                    ),
                  ),
                  //3. Bild im Slider Gelb
                  FlatButton(
                    onPressed: () {
                      dummyprofil.setAvatar(1, [2]);
                    },
                    child: Container(
                      margin: EdgeInsets.all(6.0),
                      child: Image.asset(Avatar(1, 2).imagePath, height: 300),
                    ),
                  ),
                  //3. Bild im Slider Gelb
                  FlatButton(
                    onPressed: () {
                      dummyprofil.setAvatar(1, [1, 2]);
                    },
                    child: Container(
                      margin: EdgeInsets.all(6.0),
                      child: Image.asset(Avatar(1, 3).imagePath, height: 300),
                    ),
                  ),
                  //1. Bild im Slider Gruen
                  FlatButton(
                    onPressed: () {
                      dummyprofil.setAvatar(2, [0]);
                    },
                    child: Container(
                      margin: EdgeInsets.all(6.0),
                      child: Image.asset(Avatar(2, 0).imagePath, height: 300),
                    ),
                  ),
                  //2. Bild im Slider Gruen
                  FlatButton(
                    onPressed: () {
                      dummyprofil.setAvatar(2, [1]);
                    },
                    child: Container(
                      margin: EdgeInsets.all(6.0),
                      child: Image.asset(Avatar(2, 1).imagePath, height: 300),
                    ),
                  ),
                  //1. Bild im Slider Rot
                  FlatButton(
                    onPressed: () {
                      dummyprofil.setAvatar(3, [0]);
                    },
                    child: Container(
                      margin: EdgeInsets.all(6.0),
                      child: Image.asset(Avatar(3, 0).imagePath, height: 300),
                    ),
                  )
                ],

                //Slider Eigenschaften
                options: CarouselOptions(
                  height: 400,
                  enlargeCenterPage: true,
                  autoPlay: false,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.6,
                ),
              ),
            ),
            ImageButton(
              children: <Widget>[],
              /* 302 x 91 sind die Originalmaße der Buttons */
              width: 302 / 1.3,
              height: 91 / 1.3,
              paddingTop: 0,
              /* PressedImage gibt ein Bild für den Button im gedrückten 
                    Zustand an. Bisher nicht implementiert, muss aber mit dem
                    Bild im normalen zustand angegeben werden. */
              pressedImage: Image.asset(
                "assets/buttons/Speichern_dunkelblau_groß.png",
              ),
              unpressedImage:
                  Image.asset("assets/buttons/Speichern_dunkelblau_groß.png"),
              onTap: () {
                /* TODO: (nicht bis S&T machbar) Ausgewählten Avatar in DB Speichern (Lisa) */

                Navigator.pop(context);
              },
            ),
          ],
        ));
  }
}
