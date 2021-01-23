import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/lernort.dart';
import 'package:gelsenkirchen_avatar/data/lern_kategorie.dart';
import 'package:gelsenkirchen_avatar/quiz/start_quiz.dart';
import 'package:imagebutton/imagebutton.dart';
import 'package:gelsenkirchen_avatar/screens/lernen_screen.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
  Lernort lernort;
  Icon kategorienSymbol;
  List<LernKategorie> lernKategorieList = List();
  int _listLength = 0;
  LernKategorie lk;

  @override
  void initState() {
    super.initState();
    lernort = widget.l;
    _tabController = TabController(length: 3, vsync: this);
    setKategorienSymbol(lernort.kategorieID);

    /* Wird für den Lernortkategorienamen benötigt */
    var lernKategorieFuture = LernKategorie.shared.gibObjekte();
    lernKategorieFuture.then((lernkategorie) {
      setState(() {
        /* Alphabetische Sortierung der Liste */
        lernkategorie.sort((a, b) => a.name.compareTo(b.name));
        lernKategorieList.addAll(lernkategorie);
        _listLength = lernKategorieList.length;
      });
    });
  }

  void setKategorienSymbol(int kategorienID) {
    Color symbolcolor = Color(0xff0b3e99);
    double symbolsize = 20;
    switch (kategorienID) {
      case 0:
        {
          kategorienSymbol = Icon(FlutterIcons.cube_faw5s,
              size: symbolsize, color: symbolcolor);
        }
        break;

      case 1:
        {
          kategorienSymbol = Icon(FlutterIcons.compass_faw5s,
              size: symbolsize, color: symbolcolor);
        }
        break;

      case 2:
        {
          kategorienSymbol = Icon(FlutterIcons.seedling_faw5s,
              size: symbolsize, color: symbolcolor);
        }
        break;

      case 3:
        {
          kategorienSymbol = Icon(FlutterIcons.futbol_faw5s,
              size: symbolsize, color: symbolcolor);
        }
        break;

      case 4:
        {
          kategorienSymbol = Icon(FlutterIcons.palette_faw5s,
              size: symbolsize, color: symbolcolor);
        }
        break;

      case 5:
        {
          kategorienSymbol = Icon(FlutterIcons.temperature_low_faw5s,
              size: symbolsize, color: symbolcolor);
        }
        break;

      case 6:
        {
          kategorienSymbol = Icon(FlutterIcons.book_faw5s,
              size: symbolsize, color: symbolcolor);
        }
        break;

      case 7:
        {
          kategorienSymbol = Icon(FlutterIcons.hand_holding_heart_faw5s,
              size: symbolsize, color: symbolcolor);
        }
        break;

      case 8:
        {
          kategorienSymbol = Icon(FlutterIcons.music_faw5s,
              size: symbolsize, color: symbolcolor);
        }
        break;

      case 9:
        {
          kategorienSymbol = Icon(FlutterIcons.laptop_code_faw5s,
              size: symbolsize, color: symbolcolor);
        }
        break;
      default:
        {
          kategorienSymbol =
              Icon(Icons.category, size: symbolsize, color: symbolcolor);
        }
    }
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
          //labelColor: Color(0xffe54b4b),
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
            Container(child: setTitelbild(widget.l)),
            Container(
              padding: new EdgeInsets.all(15.0),
              child: Column(
                children: [
                  /* KATEGORIE*/
                  /* TODO: - Hier muss noch der Kategoriename anstatt die KategorieId eingefügt werden */
                  /* TODO: Kategorieicon anzeigen (Lisa) */
                  /* TODO: Kategoriename aus DB anzeigen (Lisa) */
                  Row(children: [
                    kategorienSymbol,
                    SizedBox(width: 10),
                    /* TODO: "lernKategorieList[lernort.kategorieID].name" verursacht einen Fehler, von dem ich nicht weiß, wie ich ihn beheben soll. Deshalb auch auskommentiert. (Lisa) */
                    Text("Kategorie",
                        //lernKategorieList[lernort.kategorieID].name,
                        style: Theme.of(context).textTheme.headline3),
                  ]),
                  SizedBox(height: 20),

                  /* ADRESSE */
                  Row(children: [
                    Icon(FlutterIcons.location_arrow_faw5s,
                        size: 20, color: Color(0xff0b3e99)),
                    SizedBox(width: 10),
                    Flexible(
                      child: Text(
                          lernort.adresse == ""
                              ? "Keine Adresse vorhanden"
                              : lernort.adresse,
                          style: Theme.of(context).textTheme.headline3),
                    ),
                  ]),
                  SizedBox(height: 20),

                  /* ÖFFNUNGSZEITEN */
                  Row(children: [
                    Icon(FlutterIcons.clock_faw5s,
                        size: 20, color: Color(0xff0b3e99)),
                    SizedBox(width: 10),
                    Text(
                      lernort.oeffnungszeiten == ""
                          ? "Keine Öffnungszeiten vorhanden"
                          : lernort.oeffnungszeiten,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ]),
                  SizedBox(height: 40),

                  /*BESCHREIBUNG*/
                  Text(
                    lernort.kurzbeschreibung,
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
              child: getWidgetTabs(lernort, context),
            ),
          ])),

          /* Tab: SPIELEN */
          /* TODO: Inhalt einfügen (Lisa) */
          Column(
            children: [
              Text("In Bearbeitung"),
              ImageButton(
                children: <Widget>[],
                /* 302 x 91 sind die Originalmaße der Buttons */
                width: 302 / 1.5,
                height: 91 / 1.5,
                paddingTop: 5,
                /* PressedImage gibt ein Bild für den Button im gedrückten 
                    Zustand an. Bisher nicht implementiert, muss aber mit dem
                    Bild im normalen zustand angegeben werden. */
                pressedImage: Image.asset(
                  "assets/buttons/Spielen_dunkelblau_groß.png",
                ),
                unpressedImage:
                    Image.asset("assets/buttons/Spielen_dunkelblau_groß.png"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              StartQuiz(widget.l.id)));
                },
              )
            ],
          )
        ],
        controller: _tabController,
      ),
    );
  }
}

Widget setTitelbild(Lernort l) {
  if (l.titelbild.isEmpty) {
    return new Image.asset('assets/images/lernortPlaceholderTitelbild.jpg',
        fit: BoxFit.cover);
  } else {
    return new Image.network(l.titelbild, fit: BoxFit.cover);
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
                  padding: new EdgeInsets.all(15.0),
                  /* TODO: Die Inhalte sollen das gesamte Display einnehmen und ggf. scrollbar sein (Lisa) */
                  height: 500,
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
