import 'package:gelsenkirchen_avatar/data/database_url.dart';
import 'package:gelsenkirchen_avatar/data/datenbankObjekt.dart';

// Stellt die Sammelkategorie als Datenbankobjekt dar
class SammelKategorie extends DatenbankObjekt<SammelKategorie> {
  int id;
  String beschreibung;
  String ortDesTragens;

  static SammelKategorie get shared => SammelKategorie();

  SammelKategorie({this.id, this.beschreibung, this.ortDesTragens})
      : super(
            DatabaseURL.getSammelKategorie.value,
            DatabaseURL.insertIntoSammelKategorie.value,
            DatabaseURL.removeFromSammelKategorie.value,
            '');

  @override
  SammelKategorie objektVonJasonArray(objekt) {
    return SammelKategorie(
        id: int.parse(objekt["id"]),
        beschreibung: objekt["beschreibung"] as String,
        ortDesTragens: objekt["ortDesTragens"] as String);
  }

  @override
  Map<String, String> get map {
    return {
      "id": "$id",
      "beschreibung": "$beschreibung",
      "ortDesTragens": "$ortDesTragens",
    };
  }
}
