import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gelsenkirchen_avatar/screens/Lernort_vorschau_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gelsenkirchen_avatar/data/lernort.dart';
import 'package:gelsenkirchen_avatar/screens/map_info_screen.dart';
// Für Map-Style
import 'package:flutter/services.dart' show rootBundle;

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => MapSampleState();
}

class MapSampleState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  Lernort lernort;

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
        body: Stack(
      children: [
        GoogleMap(
          mapToolbarEnabled: true,
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
          zoomControlsEnabled: false,
          padding: EdgeInsets.only(top: 120),
          cameraTargetBounds: CameraTargetBounds(bounds),
          minMaxZoomPreference: MinMaxZoomPreference(5, 20),
        ),
        InfoScreen(
          lernort: lernort,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LernortVorschau(l: lernort)),
            );
          },
        )
      ],
    ));
  }

  void addMarkersForLernorte() {
    final markerImageFuture = BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 4.0),
        "assets/icons/Mapmarker_rot.png");

    markerImageFuture.then((markerImage) {
      var lernorteFuture = Lernort.shared.gibObjekte();

      lernorteFuture.then((lernorte) {
        lernorte.forEach((lernort) {
          final marker = Marker(
            icon: markerImage,
            markerId: MarkerId(lernort.id.toString()),
            position: LatLng(lernort.nord, lernort.ost),
            onTap: () {
              setState(() {
                this.lernort = lernort;
              });
            },
          );
          setState(() {
            _markers.add(marker);
          });
        });
      });
    });
  }
}
