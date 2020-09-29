import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gelsenkirchen_avatar/standort.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';
import 'locationService.dart';

class MyMap extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: missing_required_param
    return StreamProvider<UserLocation>(
      // ignore: deprecated_member_use
      builder: (context) => LocationService().locationStream,
      child: MaterialApp(
        title: 'Map View',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Map(),
    );
  }
}

class Map extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
    return FlutterMap(
      options: MapOptions(
        center: LatLng(userLocation.latitude, userLocation.longitude),
        zoom: 13.0,
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.de/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
            retinaMode: true),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(userLocation.latitude, userLocation.longitude),
              builder: (ctx) => Container(
                child: FlutterLogo(),
              ),
            ), 
            for(Standort standort in Lernorte.lernorte()) Marker(width: 80, height: 80, point: standort.position, builder: (ctx) => Container(
                child: standort.symbol,
              )),
          ],
        ),
      ],
    );
  }
}

class Lernorte {
  Standort standorte;
  static List<Standort> lernorte() {
    final waltLabor = Standort(
        "Waldalbor Rheineelbe", LatLng(51.4968, 7.1075), FlutterLogo());
    final whs = Standort("Whs", LatLng(51.5744, 7.0260), FlutterLogo());
    return [waltLabor, whs];
  }
}
