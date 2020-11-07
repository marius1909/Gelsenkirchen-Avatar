import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'lernort.dart';

class Map extends StatefulWidget {
  @override
  State<Map> createState() => MapSampleState();
}

class MapSampleState extends State<Map> {
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

    print(this._markers);

    // var lernorte = Lernort.shared.gibLernorte();
    // lernorte.then((value) {
    //   value.forEach((element) {
    //     var marker = Marker(
    //         markerId: MarkerId(element.id.toString()),
    //         position: LatLng(element.nord, element.ost),
    //         infoWindow: InfoWindow(
    //             title: element.name, snippet: element.kurzbeschreibung));
    //     setState(() {
    //       _markers.add(marker);
    //     });
    //   });
    // });
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
}
