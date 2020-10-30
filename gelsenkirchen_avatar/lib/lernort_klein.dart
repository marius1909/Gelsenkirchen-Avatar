import 'dart:core';

class LernortKlein {
  int id;
  String name;
  String kurzbeschreibung;

  LernortKlein({this.id, this.name, this.kurzbeschreibung});

  String gibLernortname() {
    return this.name;
  }
}
