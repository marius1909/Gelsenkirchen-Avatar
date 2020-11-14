import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gelsenkirchen_avatar/data/lernort.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => MapSampleState();
}

class MapSampleState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};

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
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _whsGelsenkrichen,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
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
    var lernorte = Lernort.shared.ladeObjekte();
    lernorte.then((value) {
      value.forEach((element) {
        final marker = Marker(
          markerId: MarkerId(element.id.toString()),
          position: LatLng(element.nord, element.ost),
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
