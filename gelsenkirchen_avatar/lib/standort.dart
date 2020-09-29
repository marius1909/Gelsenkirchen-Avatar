import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

class Standort {
  LatLng _position;
  final String name;
  final Widget symbol;
  
  Standort(this.name, this._position, this.symbol);

  set position(LatLng position) {
    this._position = position;
  }

  LatLng get position {
    return _position;
  }
}
