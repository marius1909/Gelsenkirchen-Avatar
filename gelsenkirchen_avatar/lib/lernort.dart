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

class Lernort extends LernortKlein {
  int id;
  int nord;
  int ost;
  int kategorieID;
  String name;
  String kurzbeschreibung;
  String beschreibung;
  String titelbild;
  int minispielArt;
  int belohnungenID;
  String weitereBilder;

  Lernort(
      {this.id,
      this.nord,
      this.ost,
      this.kategorieID,
      this.name,
      this.kurzbeschreibung,
      this.beschreibung,
      this.titelbild,
      this.minispielArt,
      this.belohnungenID,
      this.weitereBilder});
}
