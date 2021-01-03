import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/screens/lernort_screen.dart';
import 'package:gelsenkirchen_avatar/widgets/nav-drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:gelsenkirchen_avatar/data/lernort.dart';

class LernortListeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('Lernorte'),
          actions: [
            IconButton(
                icon: Icon(Icons.search, color: Colors.white), onPressed: null),
            IconButton(
                icon: Icon(Icons.filter_alt, color: Colors.white),
                onPressed: null)
          ],
        ),
        body: LernortListView());
  }
}

class LernortListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LernortListState();
}

class LernortListState extends State<LernortListView> {
  int _listLength = 0;
  List<Lernort> lernortList = List();
  List<Lernort> lernortListGefiltert = List();

  @override
  void initState() {
    super.initState();
    var lernorteFuture = Lernort.shared.gibObjekte();
    lernorteFuture.then((lernorte) {
      setState(() {
        _listLength = lernorte.length;
        lernortList = lernorte;
        print(lernortList);
      });
    });
  }

  void filterLernortList(value) {
    setState(() {
      lernortListGefiltert = lernortList
          .where((lernort) =>
              lernort.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _listLength,
      itemBuilder: erstelleListViewItem,
      padding: EdgeInsets.all(0.0),
    );
  }

  /* Diese Methode erstellt die ListViewItems */
  Widget erstelleListViewItem(BuildContext context, int index) {
    return new Card(
        color: null,
        elevation: 0,
        child: new Column(
          children: <Widget>[
            /* BILD */

            new ListTile(
              //dense: true,
              /* TODO: Lernortbilder aus DB anzeigen (Lisa) */
              /* leading: new Image.asset(
                "assets/" + lernortList[index].titelbild,
                fit: BoxFit.cover,
                width: 100.0,
              ), */
              /* Folgende Zeile dient nur zur Anschauung. Kann durch obrigen Absatz "leading" ersetzt werden, wenn Bilder aus DB angezeigt werden können. */
              leading: Icon(Icons.home),
              title: new Text(
                /* NAME */
                lernortList[index].name != null
                    ? lernortList[index].name
                    : 'empty',
              ),

              /* "subtitle" muss wieder einkommentiert werden, wenn die Kategorie angezeigt werden soll */
              /* subtitle: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    /* Kurzbeschreibung nimmt doch zu viel Platz ein, deshalb vorerst auskommentiert */
                    /* KURZBESCHREIBUNG */
                    /* new Text(
                      lernortList[index].kurzbeschreibung != null
                          ? lernortList[index].kurzbeschreibung
                          : '',
                    ), */

                    /* KATEGORIE */
                    /* TODO: Kategoriename aus DB anzeigen (Lisa) */
                    /* new Text('Kategorie: ${lernortList[index].kategorieId}',
                  style: new TextStyle(
                      fontSize: 11.0, fontWeight: FontWeight.normal)),*/
                  ]), */
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            LernortScreen(l: lernortList[index])));
              },
            )
          ],
        ));
  }
}
