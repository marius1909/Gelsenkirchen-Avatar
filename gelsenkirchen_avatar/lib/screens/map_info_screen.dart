import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/lernort.dart';

/* Info-Screen mit Infos zu Lernort, der bei Klick auf Marker auf Karte erscheint */
class InfoScreen extends StatelessWidget {
  final Lernort lernort;
  final void Function() onTap;

  InfoScreen({this.lernort, this.onTap});

  @override
  Widget build(BuildContext context) {
    if (lernort != null) {
      return GestureDetector(
        onTap: onTap,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            children: [
              Spacer(),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 70),
                height: 100,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        blurRadius: 20,
                        offset: Offset.zero,
                        color: Colors.grey.withOpacity(0.5))
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        width: 90,
                        height: 100,
                        margin: EdgeInsets.only(left: 0),
                        child: Image.network(lernort.titelbild,
                            fit: BoxFit.fill)),
                    Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              width: 220,
                              child: Text(
                                lernort.name,
                                style: TextStyle(fontSize: 14),
                              )),
                          /* ADRESSE */
                          Container(
                              width: 220,
                              child: Text('${lernort.adresse}',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey))),
                          /* ÖFFNUNGSZEITEN */
                          Container(
                            width: 220,
                            child: Text('${lernort.oeffnungszeiten}',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer()
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
