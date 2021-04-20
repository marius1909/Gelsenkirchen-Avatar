import 'package:gelsenkirchen_avatar/data/database_url.dart';
import 'package:gelsenkirchen_avatar/data/datenbankObjekt.dart';


class Memoryspiel extends DatenbankObjekt<Memoryspiel> {
  int id;
  int lernortID;
  String aufgabe;
  int erfahrungspunkte;

  static Memoryspiel get shared => Memoryspiel();

  Memoryspiel({this.id, this.lernortID, this.aufgabe, this.erfahrungspunkte})
      : super(DatabaseURL.getMemoryspiel.value,
            DatabaseURL.insertIntoMemoryspiel.value, '', '');

  int idAbfrage = 0;

  @override
  Memoryspiel objektVonJasonArray(objekt) {
    return Memoryspiel(
        id: int.parse(objekt["id"]),
        lernortID: int.parse(objekt["lernortID"]),
        aufgabe: objekt["aufgabe"] as String,
        erfahrungspunkte: int.parse(objekt["erfahrungspunkte"]));
  }

  @override
  Map<String, String> get map {
    return {
      "id": "$id",
      "lernortID": "$lernortID",
      "aufgabe": "$aufgabe",
      "erfahrungspunkte": "$erfahrungspunkte",
    };
  }

  @override
  Map<String, String> get insertingIntoDatabaseRequestBody {
    var map = this.map;
    map.remove("id");
    return map;
  }

  @override
  String toString() {
    return super.toString();
  }
}
