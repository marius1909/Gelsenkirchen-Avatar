import 'package:gelsenkirchen_avatar/data/datenbankObjekt.dart';

class Freigeschaltet extends DatenbankObjekt<Freigeschaltet> {
  int benutzerID;
  int sammelID;
  bool ausgeruestet;

  static Freigeschaltet get shared => Freigeschaltet();

  Freigeschaltet({this.benutzerID, this.sammelID, this.ausgeruestet})
      : super("getFromDatabaseURL", "insertIntoDatabaseURL",
            "removeFromDatabaseURL");

  @override
  Freigeschaltet objektVonJasonArray(objekt) {
    return Freigeschaltet(
        benutzerID: int.parse(objekt["benutzerID"]),
        sammelID: int.parse(objekt["sammelID"]),
        ausgeruestet: objekt["ausgeruestet"] as bool);
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