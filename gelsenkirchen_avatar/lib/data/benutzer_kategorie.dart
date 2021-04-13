import 'database_url.dart';
import 'datenbankObjekt.dart';

/// Benutzer sammeln in verschiedenen Kategorien Punkte, die mit Hilfe
/// dieser Klasse dargestellt werden.
class BenutzerKategorie extends DatenbankObjekt<BenutzerKategorie> {
  int benutzerID;
  int lernKategorieID;
  int erfahrungspunkte;

  static BenutzerKategorie get shared => BenutzerKategorie();

  BenutzerKategorie(
      {this.benutzerID, this.lernKategorieID, this.erfahrungspunkte})
      : super(
            DatabaseURL.getBenutzerKategorie.value,
            DatabaseURL.insertIntoLernKategorie.value,
            DatabaseURL.removeFromBenutzerKategorie.value,
            '');

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
