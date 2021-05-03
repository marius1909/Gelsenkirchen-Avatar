import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/lernort.dart';
import 'package:gelsenkirchen_avatar/data/lern_kategorie.dart';
import 'package:gelsenkirchen_avatar/quiz/start_quiz.dart';
import 'package:gelsenkirchen_avatar/memory/start_memory.dart';
import 'package:gelsenkirchen_avatar/widgets/colored_tabbar.dart';
import 'package:gelsenkirchen_avatar/screens/lernen_screen.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:gelsenkirchen_avatar/suchspiel/suchspiel_screen.dart';
import 'package:gelsenkirchen_avatar/widgets/ladescreen.dart';

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
  List<LernKategorie> lernKategorieList;
  // ignore: unused_field
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
        lernKategorieList = List();
        /* Alphabetische Sortierung der Liste */
        // lernkategorie.sort((a, b) => a.name.compareTo(b.name));
        lernKategorieList.addAll(lernkategorie);
        _listLength = lernKategorieList.length;
      });
    });
  }

  void setKategorienSymbol(int kategorienID) {
    Color symbolcolor = Color(0xff0e53c9);
    double symbolsize = 20;
    switch (kategorienID) {
      case 0:
        {
          kategorienSymbol = Icon(FlutterIcons.cube_faw5s,
              size: symbolsize, color: symbolcolor);
        }
        break;

      // Kategorie: Abenteuer
      case 1:
        {
          kategorienSymbol = Icon(FlutterIcons.explore_mdi,
              size: symbolsize, color: symbolcolor);
        }
        break;

      // Kategorie: Natur
      case 2:
        {
          kategorienSymbol = Icon(FlutterIcons.local_florist_mdi,
              size: symbolsize, color: symbolcolor);
        }
        break;

      // Kategorie: Sport
      case 3:
        {
          kategorienSymbol = Icon(FlutterIcons.directions_bike_mdi,
              size: symbolsize, color: symbolcolor);
        }
        break;

      // Kategorie: Kunst
      case 4:
        {
          kategorienSymbol = Icon(FlutterIcons.color_lens_mdi,
              size: symbolsize, color: symbolcolor);
        }
        break;

      // Kategorie: Klima
      case 5:
        {
          kategorienSymbol = Icon(FlutterIcons.temperature_low_faw5s,
              size: symbolsize, color: symbolcolor);
        }
        break;

      // Kategorie: Geschichte
      case 6:
        {
          kategorienSymbol = Icon(FlutterIcons.book_faw5s,
              size: symbolsize, color: symbolcolor);
        }
        break;

      // Kategorie: Soziales Miteinander
      case 7:
        {
          kategorienSymbol = Icon(FlutterIcons.hand_holding_heart_faw5s,
              size: symbolsize, color: symbolcolor);
        }
        break;

      // Kategorie: Musik
      case 8:
        {
          kategorienSymbol = Icon(FlutterIcons.music_note_mdi,
              size: symbolsize, color: symbolcolor);
        }
        break;

      // Kategorie: Technik
      case 9:
        {
          kategorienSymbol = Icon(FlutterIcons.computer_mdi,
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
    if (lernKategorieList == null) {
      return Ladescreen();
    } else {
      return Scaffold(
        appBar: AppBar(
          /* LERNORTNAME */
          title: Text(widget.l.name),
          bottom: ColoredTabBar(
              Color(0xff0e53c9),
              /* TABS */
              TabBar(
                unselectedLabelColor: Colors.white,
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
              )),
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
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    /* KATEGORIE*/
                    Row(children: [
                      kategorienSymbol,
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                            lernKategorieList[lernort.kategorieID - 1].name,
                            style: Theme.of(context).textTheme.headline4),
                      )
                    ]),
                    SizedBox(height: 20),

                    /* ADRESSE */
                    Row(children: [
                      Icon(FlutterIcons.location_on_mdi,
                          size: 20, color: Color(0xff0e53c9)),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                            lernort.adresse == ""
                                ? "Keine Adresse vorhanden"
                                : lernort.adresse,
                            style: Theme.of(context).textTheme.headline4),
                      ),
                    ]),
                    SizedBox(height: 20),

                    /* ÖFFNUNGSZEITEN */
                    Row(children: [
                      Icon(FlutterIcons.access_time_mdi,
                          size: 20, color: Color(0xff0e53c9)),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                            lernort.oeffnungszeiten == ""
                                ? "Keine Öffnungszeiten vorhanden"
                                : lernort.oeffnungszeiten,
                            style: Theme.of(context).textTheme.headline4),
                      )
                    ]),
                    SizedBox(height: 20),

                    /* KOSTEN */
                    Row(children: [
                      Icon(FlutterIcons.attach_money_mdi,
                          size: 20, color: Color(0xff0e53c9)),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                            lernort.kosten == ""
                                ? "Keine Angaben"
                                : lernort.kosten,
                            style: Theme.of(context).textTheme.headline4),
                      )
                    ]),
                    SizedBox(height: 20),

                    /* BARRIEREFREIHEIT */
                    Row(children: [
                      Icon(FlutterIcons.accessible_mdi,
                          size: 20, color: Color(0xff0e53c9)),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                            lernort.barrierefrei == 0
                                ? "nicht barrierefrei"
                                : "barrierefrei",
                            style: Theme.of(context).textTheme.headline4),
                      )
                    ]),
                    SizedBox(height: 20),

                    /* WEBSITE */
                    Container(child: setWebsite(widget.l)),
                    SizedBox(height: 20),

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
            SingleChildScrollView(
                child: Column(
              children: [
                /* SPIEL 1 - QUIZ */
                Container(
                    child: Card(
                        elevation: 1,
                        child: Column(children: <Widget>[
                          ListTile(
                            leading:
                                Image.asset("assets/icons/Quiz_gelb_Icon.png"),
                            title: Text('Quiz', style: TextStyle(fontSize: 16)),
                            subtitle: Text(
                              'Teste dein Wissen in einem klassischen Quiz',
                            ),
                            /* damit der subtitle in die Zeile passt */
                            dense: true,
                          ),
                          ButtonBar(children: <Widget>[
                            FlatButton(
                              child: Text('Spielen',
                                  style: TextStyle(
                                      color: Color(0xffff9f1c),
                                      fontWeight: FontWeight.bold)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            StartQuiz(widget.l.id)));
                              },
                            )
                          ])
                        ]))),

                /* SPIEL 2 - QR-SPIEL */
                Container(
                    child: Card(
                        elevation: 1,
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Image.asset(
                                    "assets/icons/QR_gruen_Icon.png"),
                                title: Text('QR-Spiel',
                                    style: TextStyle(fontSize: 16)),
                                subtitle: Text(
                                  'Finde QR-Codes und rate',
                                ),
                                /* damit der subtitle in die Zeile passt */
                                dense: true,
                              ),
                              ButtonBar(children: <Widget>[
                                FlatButton(
                                  child: Text('Spielen',
                                      style: TextStyle(
                                          color: Color(0xff98ce00),
                                          fontWeight: FontWeight.bold)),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                Suchspiel()));
                                  },
                                )
                              ])
                            ]))),
                /* SPIEL 3 - Memory */
                Container(
                    child: Card(
                        elevation: 1,
                        child: Column(children: <Widget>[
                          ListTile(
                            leading:
                                Image.asset("assets/icons/Memory_rot_Icon.png"),
                            title:
                                Text('Memory', style: TextStyle(fontSize: 16)),
                            subtitle: Text(
                              'Finde die richtigen Paare',
                            ),
                            /* damit der subtitle in die Zeile passt */
                            dense: true,
                          ),
                          ButtonBar(children: <Widget>[
                            FlatButton(
                              child: Text('Spielen',
                                  style: TextStyle(
                                      color: Color(0xffe54b4b),
                                      fontWeight: FontWeight.bold)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            StartMemory(widget.l.id)));
                              },
                            )
                          ])
                        ]))),
              ],
            ))
          ],
          controller: _tabController,
        ),
      );
    }
  }
}

/* WEBSITE-WIDGET */
Widget setWebsite(Lernort l) {
  if (l.website == "") {
    return null;
  } else {
    return Row(children: [
      Icon(FlutterIcons.web_fou, size: 20, color: Color(0xff0e53c9)),
      SizedBox(width: 10),
      Flexible(
        child: Text(
          l.website,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xff0b3e99)),
        ),
      )
    ]);
  }
}

/* TITELBILD-WIDGET */
Widget setTitelbild(Lernort l) {
  if (l.titelbild.isEmpty) {
    return new Image.asset('assets/images/lernortPlaceholderTitelbild.jpg',
        fit: BoxFit.cover);
  } else {
    return new Image.network(l.titelbild, fit: BoxFit.cover);
  }
}

// ignore: missing_return
Widget getWidgetTabs(Lernort l, BuildContext context) {
  int anzahl = 0;
  // ignore: unused_local_variable
  bool text = false;
  // ignore: unused_local_variable
  bool videos = false;
  // ignore: unused_local_variable
  bool sounds = false;
  // ignore: unused_local_variable
  bool bilder = false;

  if (l.beschreibung.isNotEmpty) {
    anzahl++;
    text = true;
  }
  if (l.videos.isNotEmpty) {
    anzahl++;
    videos = true;
  }
  if (l.sounds.isNotEmpty) {
    anzahl++;
    sounds = true;
  }
  if (l.weitereBilder.isNotEmpty) {
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
                  labelColor: Color(0xff0b3e99),
                  indicatorColor: Color(0xff0b3e99),
                  unselectedLabelColor: Color(0xff0e53c9),
                  tabs: [
                    getTabsTitel(
                      1,
                      true,
                    ),
                    getTabsTitel(
                      2,
                      true,
                    ),
                    getTabsTitel(
                      3,
                      true,
                    ),
                    getTabsTitel(
                      4,
                      true,
                    ),
                  ],
                ),
              ),
              Container(
                  padding: new EdgeInsets.all(15.0),
                  height: MediaQuery.of(context).size.height,
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
                    /* TAB: VIDEOS */
                    Container(
                      child: Center(
                        child: getWidgetVideos(l, context),
                      ),
                    ),
                    /* TAB: AUDIO */
                    Container(
                      child: Center(
                        child: getWidgetSound(l, context),
                      ),
                    ),
                    /* TAB: BILDER */
                    Container(
                        child: Center(
                          child: getWidgetWeitereBilder(l, context),
                        ),
                        height: 400),
                  ]))
            ]));
  }
}
