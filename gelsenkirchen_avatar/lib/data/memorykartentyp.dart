import 'package:gelsenkirchen_avatar/data/database_url.dart';
import 'package:gelsenkirchen_avatar/data/datenbankObjekt.dart';

// Stellt den Memorykartentyp als Datenbankobjekt dar
class Memorykartentyp extends DatenbankObjekt<Memorykartentyp> {
  int id;
  String beschreibung;

  static Memorykartentyp get shared => Memorykartentyp();

  Memorykartentyp({this.id, this.beschreibung})
      : super(DatabaseURL.getMemorykartentyp.value, '', '', '');

  @override
  Memorykartentyp objektVonJasonArray(objekt) {
    return Memorykartentyp(
      id: int.parse(objekt["id"]),
      beschreibung: objekt["beschreibung"] as String,
    );
  }

  @override
  Map<String, String> get map {
    return {
      "id": "$id",
      "beschreibung": "$beschreibung",
    };
  }

  @override
  String toString() {
    return super.toString();
  }
}
