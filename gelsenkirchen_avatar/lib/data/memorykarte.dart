import 'package:gelsenkirchen_avatar/data/database_url.dart';
import 'package:gelsenkirchen_avatar/data/datenbankObjekt.dart';

// Stellt eine Memorykarte als Datenbankobjekt dar
class Memorykarte extends DatenbankObjekt<Memorykarte> {
  int id;
  int memoryID;
  int paarID;
  // Kartentypen 1: Bild, 2: Begriff //
  int kartentyp;
  String kartenInhalt;

  static Memorykarte get shared => Memorykarte();

  Memorykarte(
      {this.id, this.memoryID, this.paarID, this.kartentyp, this.kartenInhalt})
      : super(DatabaseURL.getMemorykarte.value,
            DatabaseURL.insertIntoMemorykarte.value, '', '');

  @override
  Memorykarte objektVonJasonArray(objekt) {
    return Memorykarte(
        id: int.parse(objekt["id"]),
        memoryID: int.parse(objekt["memoryID"]),
        paarID: int.parse(objekt["paarID"]),
        kartentyp: int.parse(objekt["kartentyp"]),
        kartenInhalt: objekt["kartenInhalt"] as String);
  }

  @override
  Map<String, String> get map {
    return {
      "id": "$id",
      "memoryID": "$memoryID",
      "paarID": "$paarID",
      "kartentyp": "$kartentyp",
      "kartenInhalt": "$kartenInhalt",
    };
  }

  @override
  String toString() {
    return super.toString();
  }
}
