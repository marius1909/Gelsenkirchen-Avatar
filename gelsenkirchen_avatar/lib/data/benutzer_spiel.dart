import 'package:gelsenkirchen_avatar/data/datenbankObjekt.dart';
import 'package:gelsenkirchen_avatar/data/database_url.dart';

class BenutzerSpiel extends DatenbankObjekt<BenutzerSpiel> {
  int benutzerID;
  int spielbenutzerID;
  int bewaeltigteAufgaben;

  static BenutzerSpiel get shared => BenutzerSpiel();

  BenutzerSpiel(
      {this.benutzerID, this.spielbenutzerID, this.bewaeltigteAufgaben})
      : super(DatabaseURL.getBenutzerSpiel.value, '', '');

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
