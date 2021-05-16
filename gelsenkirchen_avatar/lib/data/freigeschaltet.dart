import 'package:gelsenkirchen_avatar/data/database_url.dart';
import 'package:gelsenkirchen_avatar/data/datenbankObjekt.dart';

class Freigeschaltet extends DatenbankObjekt<Freigeschaltet> {
  int benutzerID;
  int sammelID;
  bool ausgeruestet;

  static Freigeschaltet get shared => Freigeschaltet();

  Freigeschaltet({this.benutzerID, this.sammelID, this.ausgeruestet})
      : super(
            DatabaseURL.getFreigeschaltet.value,
            DatabaseURL.insertIntoFreigeschaltet.value,
            DatabaseURL.removeFromFreigeschaltet.value,
            '');

  @override
  Freigeschaltet objektVonJasonArray(objekt) {
    return Freigeschaltet(
        benutzerID: int.parse(objekt["benutzerID"]),
        sammelID: int.parse(objekt["sammelID"]),
        ausgeruestet: int.parse(objekt["ausgeruestet"]) == 0 ? false : true);
  }

  int getSammelID() {
    return sammelID;
  }

  @override
  Map<String, String> get map {
    return {
      "benutzerID": "$benutzerID",
      "sammelID": "$sammelID",
      "ausgeruestet": "$ausgeruestet",
    };
  }
}
