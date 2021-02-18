import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/lernort.dart';

class InfoScreen extends StatefulWidget {
  final Lernort lernort;
  final void Function() onTap;

  InfoScreen({this.lernort, this.onTap});

  @override
  State<StatefulWidget> createState() => InfoScreenState();
}

class InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.lernort != null) {
      return GestureDetector(
        onTap: widget.onTap,
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
                      child: Image.network(widget.lernort.titelbild,
                              fit: BoxFit.fill)
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              width: 220,
                              child: Text(
                                widget.lernort.name,
                                style: TextStyle(fontSize: 14),
                              )),
                          Container(
                              width: 220,
                              child: Text('${widget.lernort.adresse}',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey))),
                          Container(
                            width: 220,
                            child: Text('${widget.lernort.oeffnungszeiten}',
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
