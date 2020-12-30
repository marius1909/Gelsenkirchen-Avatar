import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';
import 'package:gelsenkirchen_avatar/data/quiz_fragen.dart';
import 'package:gelsenkirchen_avatar/data/benutzer_spiel.dart';
import 'package:gelsenkirchen_avatar/screens/Lernort_vorschau_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gelsenkirchen_avatar/data/lernort.dart';
// Für Map-Style
import 'package:flutter/services.dart' show rootBundle;

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
    zoom: 17,
  );

  // Camera bounds: Bourges, Danzig
  LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(47.0810, 2.3988), northeast: LatLng(54.3520, 18.6466));

  @override
  void initState() {
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
        myLocationButtonEnabled: true,
        cameraTargetBounds: CameraTargetBounds(bounds),
        minMaxZoomPreference: MinMaxZoomPreference(5, 20),
      ),
    );
  }

  void addMarkersForLernorte() {
    var lernorte = Lernort.shared.gibObjekte();
    lernorte.then((value) {
      value.forEach((element) {
        final marker = Marker(
          markerId: MarkerId(element.id.toString()),
          position: LatLng(element.nord, element.ost),
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
  }
}
