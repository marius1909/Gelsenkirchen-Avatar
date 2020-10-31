import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/lernort.dart';

class LernortScreen extends StatelessWidget {
  final Lernort l;

  LernortScreen({Key key, @required this.l}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: NavDrawer(),
      appBar: AppBar(
        /*NAME*/
        title: Text(l.name),
      ),
      body: Column(
        children: [

          /*TITELBILD*/
          /*Todo: Bild muss hier noch das Titelbild des entsprechenden Lernortes eingefügt werden.
          Dieses Bild dient als Platzhalter*/
          Container(
            child: 
              Image.asset('assets/images/lernortPlaceholderTitelbild.jpg', fit: BoxFit.fill)
          ),

          /*BESCHREIBUNG*/
          Container(
            child:
              Text(l.beschreibung, textAlign: TextAlign.justify, style: TextStyle(fontSize: 17),),
              margin: EdgeInsets.only(left:30.0, top:40.0,right:30.0,bottom:10.0)
          ),

          /*KATEGORIE*/
          /*Todo: - Hier muss noch der Kategoriename anstatt die KategorieId eingefügt werden
                  - linksbündig*/
          Container(
            child:
              Text("Kategorie: " + l.kategorieId.toString(), textAlign: TextAlign.left, style: TextStyle(fontSize: 17),),
              margin: EdgeInsets.only(left:30.0, top:20.0,right:30.0,bottom:10.0)
          ),

          /*ADRESSE*/
          /*Todo: - Hier muss noch die Adresse angegeben werden
                  - linksbündig*/
          Container(
            child:
              Text("Adresse: ", textAlign: TextAlign.left, style: TextStyle(fontSize: 17),),
              margin: EdgeInsets.only(left:30.0, top:20.0,right:30.0,bottom:20.0)
          ),

          /*ÖFFNUNGSZEITEN*/
          /*Todo: - Hier müssen noch die Öffnungszeiten angegeben werden
                  - linksbündig*/
          Container(
            child:
              Text("Öffnungszeiten: ", textAlign: TextAlign.left, style: TextStyle(fontSize: 17),),
              margin: EdgeInsets.only(left:30.0, top:20.0,right:30.0,bottom:20.0)
          ),

          /*Todo: Abstand zwischen den Buttons einfügen*/
          ListTile(
            title: Row(
            children: <Widget>[
              Expanded(child:
                RaisedButton.icon(
                  textColor: Colors.white,
                  color: Colors.blue,

                  /*Aktion beim Drücken des Buttons muss noch ergänzt werden, wenn
                  entsprechender Screen fertig ist. Codestück zum Springen in nächsten
                  Screen beim Drücken des Button im nächsten Kommentar schon vorhanden.*/
                  onPressed: () {
                    /*Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => ScreenName()));*/
                  },
                  icon: Icon(Icons.book),
                  label: Text('Lernen'),
                ),
              ),

              Expanded(child: 
                RaisedButton.icon(
                  textColor: Colors.white,
                  color: Colors.blue,

                  /*Aktion beim Drücken des Buttons muss noch ergänzt werden, wenn
                  entsprechender Screen fertig ist. Codestück zum Springen in nächsten
                  Screen beim Drücken des Button im nächsten Kommentar schon vorhanden.*/
                  onPressed: () {
                    /*Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => ScreenName()));*/
                  },
                  icon: Icon(Icons.videogame_asset),
                  label: Text('Spielen'),
                ),
              )]))
        
      ])
    );
  }
}
