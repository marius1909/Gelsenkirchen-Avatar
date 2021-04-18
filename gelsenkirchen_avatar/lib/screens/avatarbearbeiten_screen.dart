import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gelsenkirchen_avatar/data/Avatar.dart';
import 'package:imagebutton/imagebutton.dart';
import 'package:gelsenkirchen_avatar/screens/profil_screen.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';

// ignore: camel_case_types
class Avatarbearbeiten extends StatefulWidget {
  @override
  _AvatarbearbeitenState createState() => _AvatarbearbeitenState();
}

class _AvatarbearbeitenState extends State<Avatarbearbeiten> {
  var _result;
  List<String> auswaehlbareAvatare = new List();

  @override
  void initState() {
    super.initState();

    loadAsyncData().then((result) {
      setState(() {
        _result = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    auswaehlbareAvatare.add(Avatar.getDefaultImagePath(0));
    auswaehlbareAvatare.add(Avatar.getDefaultImagePath(1));
    auswaehlbareAvatare.add(Avatar.getDefaultImagePath(2));
    auswaehlbareAvatare.add(Avatar.getDefaultImagePath(3));
    if (_result == null) {
      return new Container();
    } else {
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
                child: CarouselSlider.builder(
                    itemCount: auswaehlbareAvatare.length,
                    itemBuilder: (context, index) {
                      print(auswaehlbareAvatare.length);
                      return Container(
                        margin: EdgeInsets.all(6.0),
                        child: Image.asset(auswaehlbareAvatare[index],
                            height: 300),
                      );
                    },
                    options: CarouselOptions(
                      height: 100,
                      enlargeCenterPage: true,
                      autoPlay: false,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 0.3,
                    )),
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

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profil(Benutzer.current.id)),
                  );
                },
              ),
            ],
          ));
    }
  }

  Future<bool> loadAsyncData() async {
    List<String> a =
        await Avatar.getAuswaehlbareAvatareList(Benutzer.current.id);
    print("he");
    setState(() {
      auswaehlbareAvatare = a;
    });
    return true;
  }
}
