import 'package:gelsenkirchen_avatar/data/datenbankObjekt.dart';
import 'package:gelsenkirchen_avatar/data/database_url.dart';

class SammelKategorie extends DatenbankObjekt<SammelKategorie> {
  int id;
  String name;
  String ortDesTragens;

  static SammelKategorie get shared => SammelKategorie();

  SammelKategorie({this.id, this.name, this.ortDesTragens})
      : super(DatabaseURL.getSammelKategorie.value, '', '');

  @override
  SammelKategorie objektVonJasonArray(objekt) {
    return SammelKategorie(
        id: int.parse(objekt["id"]),
        name: objekt["name"] as String,
        ortDesTragens: objekt["ortDesTragens"] as String);
  }

  @override
  Map<String, String> get map {
    return {
      "id": "$id",
      "name": "$name",
      "ortDesTragens": "$ortDesTragens",
    };
  }
}
