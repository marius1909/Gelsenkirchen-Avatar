import 'package:gelsenkirchen_avatar/data/database_url.dart';
import 'package:gelsenkirchen_avatar/data/datenbankObjekt.dart';

class Quiz extends DatenbankObjekt<Quiz> {
  int id;
  int lernortID;
  int fragenAnzahl;
  int punkteProFrage;

  static Quiz get shared => Quiz();

  Quiz({this.id, this.lernortID, this.fragenAnzahl, this.punkteProFrage})
      : super(DatabaseURL.getQuiz.value, DatabaseURL.insertIntoQuiz.value,
            DatabaseURL.removeFromQuiz.value);

  @override
  Quiz objektVonJasonArray(objekt) {
    return Quiz(
        id: int.parse(objekt["id"]),
        lernortID: int.parse(objekt["lernortID"]),
        fragenAnzahl: int.parse(objekt["fragenAnzahl"]),
        punkteProFrage: int.parse(objekt["punkteProFrage"]));
  }

  @override
  Map<String, String> get map {
    return {
      "id": "$id",
      "lernortID": "$lernortID",
      "fragenAnzahl": "$fragenAnzahl",
      "punkteProFrage": "$punkteProFrage"
    };
  }
}
