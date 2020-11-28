import 'package:gelsenkirchen_avatar/data/database_url.dart';
import 'package:gelsenkirchen_avatar/data/datenbankObjekt.dart';

class BenutzerKategorie extends DatenbankObjekt<BenutzerKategorie> {
  int benutzerID;
  int lernKategorieID;
  int erfahrungspunkte;

  static BenutzerKategorie get shared => BenutzerKategorie();

  BenutzerKategorie(
      {this.benutzerID, this.lernKategorieID, this.erfahrungspunkte})
      : super(DatabaseURL.getBenutzerKategorie.value, DatabaseURL.insertIntoLernKategorie.value, '');

  @override
  BenutzerKategorie objektVonJasonArray(objekt) {
    return BenutzerKategorie(
        benutzerID: int.parse(objekt["benutzerID"]),
        lernKategorieID: int.parse(objekt["lernKategorieID"]),
        erfahrungspunkte: int.parse(objekt["erfahrungspunkte"]));
  }

  @override
  Map<String, String> get map {
    return {
      "benutzerID": "$benutzerID",
      "lernKategorieID": "$lernKategorieID",
      "erfahrungspunkte": "$erfahrungspunkte",
    };
  }
}
