import 'package:gelsenkirchen_avatar/data/datenbankObjekt.dart';

class Rollen extends DatenbankObjekt<Rollen> {
  int benutzerID;
  int spielbenutzerID;
  int bewaeltigteAufgaben;

  static Rollen get shared => Rollen();

  Rollen({this.benutzerID, this.spielbenutzerID, this.bewaeltigteAufgaben})
      : super("getFromDatabaseURL", "insertIntoDatabaseURL",
            "removeFromDatabaseURL");

  @override
  Rollen objektVonJasonArray(objekt) {
    return Rollen(
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