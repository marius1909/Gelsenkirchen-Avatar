import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/screens/Lernort_vorschau_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gelsenkirchen_avatar/data/lernort.dart';
// Für Map-Style
import 'package:flutter/services.dart' show rootBundle;

/* TODO: Mapmarker_rot.png als Marker einbinden */

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => MapSampleState();
}

class MapSampleState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};

  /* Inhalt der map_style.txt */
  String _mapStyle;

  static final CameraPosition _whsGelsenkrichen = CameraPosition(
    target: LatLng(51.5744, 7.0260),
    zoom: 12,
  );

  // Camera bounds: Bourges, Danzig
  LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(47.0810, 2.3988), northeast: LatLng(54.3520, 18.6466));

  @override
  void initState() {
    /*Lernort.shared.updateDatabaseWithID(
        "beschreibung",
        "Im Jahr 1248 erschien die Adelsfamilie von Berge das erste Mal als Eigentümer der Burg. Es ist jedoch zu vermuten das die Ursprünge der Anlage weiter zurück liegen. Anschließend wurde die Burg über sechs Generationen in der Familie von Berge vererbt bis ins Jahr 1433 als der letzte Vertreter des Geschlechts kinderlos verstarb. Seine Witwe verkaufte das Haus und die umliegenden Güter an den Ritter Heinrich von Backem von Haus Lythe. Als die männliche Linie dieser Familie erlosch brachte dessen Erbtochter Harlieb Haus Berge im Jahr 1521 in den Besitzt ihres Mannes Georg von Boenen. Unter seiner Anordnung wurde die Anlage 1530 zu einem Schluss umgebaut. Dabei entstand unteranderem ein großer teil des Hauptflügel des Herrenhauses und des Nordflügels. Unter der Führung der Familie von Boenen erlangte das Anwesens in den darauffolgenden 250 Jahren zunehmend ansehen. Um 1700 erfolge der nächste nennenswerte umbau des Geländes. So wurde der Haupttrakt erweitert und der erste Park angelegt. Dieser wurde als geometrisch gestalteter Barockgarten nach Französischen Vorbild angelegt. In den Jahren 1785 – 1788 wurde ein Teil der Anlage abgetragen, um dort den Südflügel neu aufzubauen und dies im Frühklassizistischem Stil. Dies war durch einen angeheirateten Grafen von Westerholt Titel begründet. Zudem wurde die Parkanlage mit einem englischen Landschaftsgarten erweitert. Nachdem am 20. März 1900 die Gräfin Jenny von Westerholt-Gysenberg verstarb wurde im Schloss ein Wirtschafsbetreib das die Stadt Buer ab 1920 pachtete. Vier Jahre später erwarb die Stadt das gesamte Gelände. In der Zeit des Nationalsozialismus sollte auf der Vorburginsel eine Kreisschulungsburg der NSDAP entstehen. Dazu wurden die dortigen, 1876 bis 1878 erbauten Wirtschaftsgebäude mehrheitlich abgerissen. Lediglich der Remise genannte Westflügel, in dem früher Pferdeställe untergebracht waren, stand noch bis 1983, wurde dann aber auch niedergelegt, um für einen geplanten Hotelbau Platz zu schaffen.Nach dem Zweiten Weltkrieg ließ die Stadt Gelsenkirchen Schloss Berge 1952/53 restaurieren. Gleichzeitig erfolgte ein umfassender Innenumbau, um dort im Anschluss einem Hotel-Restaurant Platz zu bieten. Nach einer umfangreichen Modernisierung in den Jahren 1977 und 1978 folgten in den Jahren 2003 und 2004 erneut Renovierungs- und Restaurierungsarbeiten.",
        44);*/

    super.initState();
    addMarkersForLernorte();

    /* Lädt das map_style.txt File als ein String ein */
    rootBundle.loadString('assets/styles/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _whsGelsenkrichen,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);

          /* Style setzen */
          controller.setMapStyle(_mapStyle);
        },
        markers: _markers,
        myLocationEnabled: true,
        padding: EdgeInsets.only(
          top: 150,
        ),
        myLocationButtonEnabled: true,
        cameraTargetBounds: CameraTargetBounds(bounds),
        minMaxZoomPreference: MinMaxZoomPreference(5, 20),
      ),
    );
  }

  /* TODO: Hier werden doch komischerweise nicht alle Lernorte angezeigt, oder?! */
  void addMarkersForLernorte() {
    final markerImageFuture = BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 4.0),
        "assets/icons/Mapmarker_rot.png");

    markerImageFuture.then((markerImage) {
      var lernorte = Lernort.shared.gibObjekte();

      lernorte.then((value) {
        value.forEach((element) {
          final marker = Marker(
            icon: markerImage,
            markerId: MarkerId(element.id.toString()),
            position: LatLng(element.nord, element.ost),
            /* TODO: Bei onTap direkt zur Lernortvorschau ist hier vielleicht nicht sinnvoll. (Lisa)
          Denke es wäre sinnvoller zunächst das infoWindow anzuzeigen und bei erneutem Tap die LernortVorschau anzuzeigen. */
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          LernortVorschau(l: element)));
            },
            infoWindow: InfoWindow(
                title: element.name, snippet: element.kurzbeschreibung),
          );
          setState(() {
            _markers.add(marker);
          });
        });
      });
    });
  }
}
