import 'package:gelsenkirchen_avatar/data/database_url.dart';
import 'package:gelsenkirchen_avatar/data/datenbankObjekt.dart';

class Sammelbares extends DatenbankObjekt<Sammelbares> {
  int id;
  int kategorieID;
  String name;
  String beschreibung;
  String bild;
  int pfadID;
  int basisID;

  static Sammelbares get shared => Sammelbares();

  Sammelbares(
      {this.id,
      this.kategorieID,
      this.name,
      this.beschreibung,
      this.bild,
      this.pfadID,
      this.basisID})
      : super(
            DatabaseURL.getSammelbares.value,
            DatabaseURL.insertIntoSammelbares.value,
            DatabaseURL.removeFromSammelbares.value,
            '');

  @override
  Sammelbares objektVonJasonArray(objekt) {
    return Sammelbares(
        id: int.parse(objekt["id"]),
        kategorieID: int.parse(objekt["kategorieID"]),
        name: objekt["name"] as String,
        beschreibung: objekt["beschreibung"] as String,
        bild: objekt["bild"] as String,
        //int.parse wirft error wenn pfadID NULL ist \Marius
        pfadID: objekt["pfadID"] == null ? null : int.parse(objekt["pfadID"]),
        basisID:
            objekt["basisID"] == null ? null : int.parse(objekt["basisID"]));
  }

  @override
  Map<String, String> get map {
    return {
      "id": "$id",
      "kategorieID": "$kategorieID",
      "name": "$name",
      "beschreibung": "$beschreibung",
      "bild": "$bild",
      "pfadID": "$pfadID",
      "basisID": "$basisID"
    };
  }
}
