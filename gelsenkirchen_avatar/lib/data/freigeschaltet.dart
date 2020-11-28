import 'package:gelsenkirchen_avatar/data/database_url.dart';
import 'package:gelsenkirchen_avatar/data/datenbankObjekt.dart';
import 'package:gelsenkirchen_avatar/data/database_url.dart';

class Freigeschaltet extends DatenbankObjekt<Freigeschaltet> {
  int benutzerID;
  int sammelID;
  bool ausgeruestet;

  static Freigeschaltet get shared => Freigeschaltet();

  Freigeschaltet({this.benutzerID, this.sammelID, this.ausgeruestet})
      : super(DatabaseURL.getFreigeschaltet.value, DatabaseURL.insertIntoFreigeschaltet.value, '');

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
