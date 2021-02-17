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
                margin: EdgeInsets.all(20),
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(45)),
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
                      width: 70,
                      height: 70,
                      margin: EdgeInsets.only(left: 10),
                      child: ClipOval(
                          child: Image.network(widget.lernort.titelbild,
                              fit: BoxFit.fill)),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(widget.lernort.name),
                          Flexible(
                            child: Text('${widget.lernort.adresse}',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          ),
                          Text('${widget.lernort.oeffnungszeiten}',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey)),
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
