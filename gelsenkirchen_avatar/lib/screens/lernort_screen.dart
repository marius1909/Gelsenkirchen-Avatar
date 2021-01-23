import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/lernort.dart';
import 'package:gelsenkirchen_avatar/data/lern_kategorie.dart';
import 'package:gelsenkirchen_avatar/quiz/start_quiz.dart';
import 'package:imagebutton/imagebutton.dart';
import 'package:gelsenkirchen_avatar/screens/lernen_screen.dart';

/* TODO: Kategorieicon einfügen */
class LernortScreen extends StatefulWidget {
  final Lernort l;
  final String k;

  LernortScreen({Key key, @required this.l, @required this.k})
      : super(key: key);

  @override
  _LernortScreenState createState() => _LernortScreenState();
}

class _LernortScreenState extends State<LernortScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<LernKategorie> lernKato = List();
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      //drawer: NavDrawer(),
      appBar: AppBar(
        /*NAME*/
        title: Text(widget.l.name),
        bottom: TabBar(
          unselectedLabelColor: Colors.white,
          //labelColor: Colors.green,
          tabs: [
            Tab(
              child: Text("Überblick"),
            ),
            Tab(
              child: Text("Lernen"),
            ),
            Tab(
              child: Text("Spielen"),
            )
          ],
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        bottomOpacity: 1,
      ),
      body: TabBarView(
        children: [
          /* Tab: INFO */
          SingleChildScrollView(
              child: Column(children: [
            /* TITELBILD */
            Container(child: getWidgetTitelbild(widget.l)),
            Container(
              padding: new EdgeInsets.all(15.0),
              child: Column(
                children: [
                  /* KATEGORIE*/
                  /* TODO: - Hier muss noch der Kategoriename anstatt die KategorieId eingefügt werden */
                  /* TODO: Kategorieicon anzeigen (Lisa) */
                  /* TODO: Kategoriename aus DB anzeigen (Lisa) */
                  Row(children: [
                    Text("Abenteuer",
                        style: Theme.of(context).textTheme.bodyText1),
                  ]),
                  SizedBox(height: 10),

                  /* ADRESSE */
                  Row(children: [
                    Text(widget.l.adresse,
                        style: Theme.of(context).textTheme.bodyText1),
                  ]),
                  SizedBox(height: 10),

                  /* ÖFFNUNGSZEITEN */
                  Row(children: [
                    Text(widget.l.oeffnungszeiten,
                        style: Theme.of(context).textTheme.bodyText1),
                  ]),
                  SizedBox(height: 10),

                  /*BESCHREIBUNG*/
                  Text(
                    '' + widget.l.kurzbeschreibung,
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            )
          ])),

          /* Tab: LERNEN */
          SingleChildScrollView(
              child: Column(children: [
            Container(
              child: getWidgetTabs(widget.l, context),
            ),
          ])),

          /* Tab: SPIELEN */
          Center(child: Text("Contacts Tab Bar View")),
        ],
        controller: _tabController,
      ),
    );
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

Widget getWidgetTabs(Lernort l, BuildContext context) {
  int anzahl = 0;
  bool text = false;
  bool videos = false;
  bool sounds = false;
  bool bilder = false;

  if (!l.beschreibung.isEmpty) {
    anzahl++;
    text = true;
  }
  if (!l.videos.isEmpty) {
    anzahl++;
    videos = true;
  }
  if (!l.sounds.isEmpty) {
    anzahl++;
    sounds = true;
  }
  if (!l.weitereBilder.isEmpty) {
    anzahl++;
    bilder = true;
  }
  if (anzahl > 0) {
    return DefaultTabController(
        length: 4,
        initialIndex: 0,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: TabBar(
                  labelColor: Color(0xffe54b4b),
                  unselectedLabelColor: Color(0xff0b3e99),
                  tabs: [
                    get_TabsTitel(
                      1,
                      true,
                    ),
                    get_TabsTitel(
                      2,
                      true,
                    ),
                    get_TabsTitel(
                      3,
                      true,
                    ),
                    get_TabsTitel(
                      4,
                      true,
                    ),
                  ],
                ),
              ),
              Container(
                  height: 400,
                  decoration: BoxDecoration(
                      /* border: Border(
                          top: BorderSide(color: Colors.grey, width: 0.5)) */
                      ),
                  child: TabBarView(children: <Widget>[
                    SingleChildScrollView(
                        child: Container(
                      child: Center(
                        child: Text(
                          l.beschreibung.replaceAll('<br>', '\n'),
                          textAlign: TextAlign.justify,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    )),
                    Container(
                      child: Center(
                        child: getWidgetVideos(l, context),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: getWidgetSound(l, context),
                      ),
                    ),
                    Container(
                        child: Center(
                          child: getWidgetWeitereBilder(l, context),
                        ),
                        height: 400),
                  ]))
            ]));
  }
}
