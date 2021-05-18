import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/lernort.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';
import 'package:gelsenkirchen_avatar/widgets/chewie_list_item.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Lernen extends StatelessWidget {
  final Lernort l;
  Lernen({Key key, @required this.l}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(l.name),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            /*TITELBILD*/
            Container(child: getWidgetTitelbild(l)),

            /*TABS*/
            Container(
              child: getWidgetTabs(l, context),
            ),
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
                  labelColor: Colors.green,
                  unselectedLabelColor: Colors.black,
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
                  height: 400,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.grey, width: 0.5))),
                  child: TabBarView(children: <Widget>[
                    Container(
                      child: Center(
                        child: Text(
                          l.beschreibung.replaceAll('<br>', '\n'),
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
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

Widget getTabsTitel(int i, bool sollRein) {
  //1 = Text  //2= Video   //3 = Sounds    //4= Bilder
  if (sollRein) {
    if (i == 1) {
      return Tab(text: 'Texte', icon: Icon(FlutterIcons.text_document_ent));
    } else if (i == 2) {
      return Tab(text: 'Videos', icon: Icon(FlutterIcons.video_camera_ent));
    } else if (i == 3) {
      return Tab(text: 'Audio', icon: Icon(FlutterIcons.audiotrack_mdi));
    } else if (i == 4) {
      return Tab(text: 'Bilder', icon: Icon(FlutterIcons.image_faw5s));
    } else if (i == 0) {
      return Tab(text: 'Fehler', icon: Icon(FlutterIcons.error_mdi));
    }
  }
  return null;
}

Widget getWidgetSound(Lernort l, BuildContext context) {
  if (l.sounds.isEmpty) {
    return new Text(
      'Derzeit sind leider keine Audiodateien verfügbar.',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline3,
    );
  } else {
    return new Text(
      'Diese Funktion wird derzeit leider noch nicht unterstützt.',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline3,
    );
  }
}

Widget getWidgetVideos(Lernort l, BuildContext context) {
  if (l.videos.isEmpty) {
    return new Text(
      'Derzeit sind leider keine Videos verfügbar.',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline3,
    );
  } else {
    return ChewieListItem(
        videoPlayerController: VideoPlayerController.network(
          //'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4',
          l.videos,
        ),
        looping: false);
  }
}

Widget getWidgetWeitereBilder(Lernort l, BuildContext context) {
  if (l.weitereBilder.isEmpty) {
    return new Text(
      'Derzeit sind leider keine weiteren Bilder verfügbar.',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline3,
    );
  } else {
    /* Trennzeichen für die Links */
    var arr = l.weitereBilder.split('; ');

    // ignore: unused_local_variable
    var i = 0;

    // ignore: unused_local_variable
    var ii = 0;
    return new GridView.builder(
      itemCount: arr.length,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return new Card(
          child: new InkResponse(
            child: Image.network(
              arr[index],
              fit: BoxFit.cover,
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
      appBar: AppBar(),
      body: GestureDetector(
        child: Center(
            child: Hero(
                tag: 'imageHero',
                child: PhotoView(
                  imageProvider: NetworkImage(url),
                ))),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
