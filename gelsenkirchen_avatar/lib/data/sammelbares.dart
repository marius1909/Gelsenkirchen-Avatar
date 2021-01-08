import 'package:gelsenkirchen_avatar/data/database_url.dart';
import 'package:gelsenkirchen_avatar/data/datenbankObjekt.dart';
import 'package:gelsenkirchen_avatar/data/database_url.dart';

class Sammelbares extends DatenbankObjekt<Sammelbares> {
  int id;
  int kategorieID;
  String name;
  String beschreibung;
  String bild;

  static Sammelbares get shared => Sammelbares();

  Sammelbares(
      {this.id, this.kategorieID, this.name, this.beschreibung, this.bild})
      : super(
            DatabaseURL.getSammelbares.value,
            DatabaseURL.insertIntoSammelbares.value,
            DatabaseURL.removeFromSammelbares.value);

  @override
  Sammelbares objektVonJasonArray(objekt) {
    return Sammelbares(
        id: int.parse(objekt["id"]),
        kategorieID: int.parse(objekt["kategorieID"]),
        name: objekt["name"] as String,
        beschreibung: objekt["beschreibung"] as String,
        bild: objekt["bild"] as String);
  }

  @override
  Map<String, String> get map {
    return {
      "id": "$id",
      "kategorieID": "$kategorieID",
      "name": "$name",
      "beschreibung": "$beschreibung",
      "bild": "$bild"
    };
  }
}
