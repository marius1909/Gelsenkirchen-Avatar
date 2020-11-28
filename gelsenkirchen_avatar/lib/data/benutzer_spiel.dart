import 'package:gelsenkirchen_avatar/data/datenbankObjekt.dart';

import 'database_url.dart';

class BenutzerSpiel extends DatenbankObjekt<BenutzerSpiel> {
  int benutzerID;
  int spielID;
  int bewaeltigteAufgaben;

  static BenutzerSpiel get shared => BenutzerSpiel();

  BenutzerSpiel(
      {this.benutzerID, this.spielID, this.bewaeltigteAufgaben})
      : super("getFromDatabaseURL", DatabaseURL.insertIntoBenutzerSpiel.value,
            "removeFromDatabaseURL");

  @override
  BenutzerSpiel objektVonJasonArray(objekt) {
    return BenutzerSpiel(
        benutzerID: int.parse(objekt["benutzerID"]),
        spielID: int.parse(objekt["spielID"]),
        bewaeltigteAufgaben: int.parse(objekt["bewaeltigteAufgaben"]));
  }

  @override
  Map<String, String> get map {
    return {
      "benutzerID": "$benutzerID",
      "spielID": "$spielID",
      "bewaeltigteAufgaben": "$bewaeltigteAufgaben",
    };
  }
}
