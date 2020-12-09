import 'package:flutter/material.dart';
//import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';
import 'package:gelsenkirchen_avatar/data/lernort.dart';
import 'package:photo_view/photo_view.dart';

//ToDo Weitere Medien einfügen

class Lernen extends StatelessWidget {
  final Lernort l;
  Lernen({Key key, @required this.l}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
        //drawer: NavDrawer(),
        appBar: AppBar(
          title: Text(l.name),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            /*TITELBILD*/
            Container(child: getWidgetTitelbild(l)),

            /*Beschreibung*/
            Container(
                child: Text(
                  l.beschreibung.replaceAll('<br>', '\n'),
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 17),
                ),
                margin: EdgeInsets.only(
                    left: 30.0, top: 40.0, right: 30.0, bottom: 10.0)),

            /*Weitere Bilder*/
            Container(
              child: getWidgetWeitereBilder(l, context),
              height: 400,
            )
          ]),
        ));
  }
}

Widget getWidgetTitelbild(Lernort l) {
  if (l.titelbild.isEmpty) {
    return new Image.asset('assets/images/lernortPlaceholderTitelbild.jpg',
        fit: BoxFit.fill);
  } else {
    return new Image.network(l.titelbild, fit: BoxFit.fill);
  }
}

Widget getWidgetWeitereBilder(Lernort l, BuildContext context) {
  if (l.weitereBilder.isEmpty) {
    return new Text(
      'Leider sind keine Weiteren Bilder Vorhanden',
      textAlign: TextAlign.justify,
      style: TextStyle(fontSize: 17),
    );
  } else {
    var arr = l.weitereBilder.split('; '); //Trennzeichen für Die links
    var i = 0;
    var ii = 0;
    return new GridView.builder(
      itemCount: arr.length,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return new Card(
          child: new InkResponse(
            child: Image.network(
              arr[i++],
              fit: BoxFit.scaleDown,
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return DetailScreen(url: arr[index]);
              }));
            },
          ),
          color: Colors.grey,
        );
      },
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String url;

  DetailScreen({Key key, @required this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //title: Text(l.name),
          ),
      body: GestureDetector(
        child: Center(
            child: Hero(
                tag: 'imageHero',
                child: PhotoView(
                  imageProvider: NetworkImage(url),
                )
                /*child: Image.network(
                  url,
                  fit: BoxFit.cover,
                )*/
                )),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
