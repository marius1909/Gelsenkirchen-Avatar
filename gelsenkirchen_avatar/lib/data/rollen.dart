import 'package:gelsenkirchen_avatar/data/database_url.dart';
import 'package:gelsenkirchen_avatar/data/datenbankObjekt.dart';

class Rollen extends DatenbankObjekt<Rollen> {
  int id;
  String name;
  String beschreibung;

  static Rollen get shared => Rollen();

  Rollen({this.id, this.name, this.beschreibung})
      : super(DatabaseURL.getRollen.value, DatabaseURL.insertIntoRollen.value,
            DatabaseURL.removeFromRollen.value);

  @override
  Rollen objektVonJasonArray(objekt) {
    return Rollen(
        id: int.parse(objekt["id"]),
        name: objekt["name"] as String,
        beschreibung: objekt["beschreibung"] as String);
  }

  @override
  Map<String, String> get map {
    return {
      "id": "$id",
      "name": "$name",
      "beschreibung": "$beschreibung",
    };
  }
}
