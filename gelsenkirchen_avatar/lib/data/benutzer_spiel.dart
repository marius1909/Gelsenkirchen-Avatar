import 'package:gelsenkirchen_avatar/data/datenbankObjekt.dart';

class BenutzerSpiel extends DatenbankObjekt<BenutzerSpiel> {
  int benutzerID;
  int spielbenutzerID;
  int bewaeltigteAufgaben;

  static BenutzerSpiel get shared => BenutzerSpiel();

  BenutzerSpiel(
      {this.benutzerID, this.spielbenutzerID, this.bewaeltigteAufgaben})
      : super("getFromDatabaseURL", "insertIntoDatabaseURL",
            "removeFromDatabaseURL");

  @override
  BenutzerSpiel objektVonJasonArray(objekt) {
    return BenutzerSpiel(
        benutzerID: int.parse(objekt["benutzerID"]),
        spielbenutzerID: int.parse(objekt["spielbenutzerID"]),
        bewaeltigteAufgaben: int.parse(objekt["bewaeltigteAufgaben"]));
  }

  @override
  Map<String, String> get map {
    return {
      "benutzerID": "$benutzerID",
      "spielbenutzerID": "$spielbenutzerID",
      "bewaeltigteAufgaben": "$bewaeltigteAufgaben",
    };
  }
}
