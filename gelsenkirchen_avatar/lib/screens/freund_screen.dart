import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:gelsenkirchen_avatar/data/Avatar.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';
import 'package:gelsenkirchen_avatar/widgets/ladescreen.dart';
import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Freund extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final Benutzer freund;
  final int level;
  Freund(this.freund, this.level);

  @override
  _FreundState createState() => _FreundState();
}

class _FreundState extends State<Freund> {
  int anzahlErrungenschaften;
  var _asyncResult;
  List<String> alleFreigeschaltetenErrungenschaften = new List();
  Image avatar;

  @override
  void initState() {
    super.initState();
    ladeAsyncDaten().then((result) {
      setState(() {
        _asyncResult = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_asyncResult == null) {
      return Ladescreen();
    } else {
      return Scaffold(
          //drawer: NavDrawer(),
          appBar: AppBar(
            title: Text('Freund'),
          ),
          body: Stack(children: [
            /* BILD */
            Container(
              //padding: EdgeInsets.fromLTRB(15, 40, 15, 10),
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      image: new AssetImage(
                          "assets/images/Profil_Hintergrund.png"),
                      fit: BoxFit.cover)),
            ),
            SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(15, 40, 15, 40),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                              child: Text(
                            widget.freund.benutzer,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Ccaps",
                                fontSize: 35.0,
                                color: Color(0xff0b3e99)),
                          )),
                        ],
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Container(
                          height: 22,
                          width: 200,
                          color: Colors.blue[50],
                          child: Align(
                              alignment: Alignment(0, 0),
                              child: LinearPercentIndicator(
                                  width: 200,
                                  lineHeight: 22,
                                  percent: 1,
                                  backgroundColor: Color(0xff0d4dbb),
                                  progressColor: Color(0xff2d75f0),
                                  center: Text(
                                    "Level: " + widget.level.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ))),
                        ),
                      ),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /* Icon-Button nur da, damit Name zentriert ist */
                          IconButton(
                            icon: Icon(
                              FlutterIcons.edit_faw5s,
                              color: Color(0xff999999).withOpacity(0),
                              size: 15,
                            ),
                            onPressed: () {},
                          ),
                          avatar,
                          IconButton(
                            icon: Icon(
                              FlutterIcons.edit_faw5s,
                              color: Color(0xff999999).withOpacity(0),
                              size: 15,
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                      SizedBox(height: 70),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              "Errungenschaften von " +
                                  widget.freund.benutzer +
                                  ": " +
                                  (anzahlErrungenschaften).toString(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline3),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      CarouselSlider.builder(
                          itemCount:
                              alleFreigeschaltetenErrungenschaften.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(6.0),
                              child: Image.asset(
                                  alleFreigeschaltetenErrungenschaften[index],
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
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            viewportFraction: 0.3,
                          ))
                    ],
                  ),
                )
              ],
            ))
          ]));
    }
  }

  Future<bool> ladeAsyncDaten() async {
    print(widget.freund.id);
    avatar = Image.asset(await Avatar.getImagePath(widget.freund.id),
        width: 250, height: 250);

    alleFreigeschaltetenErrungenschaften =
        await Avatar.getAlleErrungenschaftenPath(widget.freund.id);
    anzahlErrungenschaften = alleFreigeschaltetenErrungenschaften.length;

    return true;
  }
}
