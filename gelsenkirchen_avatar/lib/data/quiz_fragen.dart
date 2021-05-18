import 'package:gelsenkirchen_avatar/data/database_url.dart';
import 'package:gelsenkirchen_avatar/data/datenbankObjekt.dart';

// Stellt die Quizfragen als Datenbankobjekt dar
class QuizFragen extends DatenbankObjekt<QuizFragen> {
  int id;
  int quizID;
  String frage;
  String antwort1;
  String antwort2;
  String antwort3;
  String antwort4;
  int position;
  String loesungsText;

  static QuizFragen get shared => QuizFragen();

  QuizFragen(
      {this.id,
      this.quizID,
      this.frage,
      this.antwort1,
      this.antwort2,
      this.antwort3,
      this.antwort4,
      this.position,
      this.loesungsText})
      : super(
            DatabaseURL.getQuizFragen.value,
            DatabaseURL.insertIntoQuizFragen.value,
            DatabaseURL.removeFromQuizFragen.value,
            DatabaseURL.updateQuizFragen.value);

  @override
  QuizFragen objektVonJasonArray(objekt) {
    return QuizFragen(
      id: int.parse(objekt["id"]),
      quizID: int.parse(objekt["quizID"]),
      frage: objekt["frage"] as String,
      antwort1: objekt["antwort1"] as String,
      antwort2: objekt["antwort2"] as String,
      antwort3: objekt["antwort3"] as String,
      antwort4: objekt["antwort4"] as String,
      position: int.parse(objekt["position"]),
      loesungsText: objekt["loesungsText"] as String,
    );
  }

  @override
  Map<String, String> get insertingIntoDatabaseRequestBody {
    var map = this.map;
    map.remove("id");
    return map;
  }

  @override
  Map<String, String> get map {
    return {
      "id": "$id",
      "quizID": "$quizID",
      "frage": "$frage",
      "antwort1": "$antwort1",
      "antwort2": "$antwort2",
      "antwort3": "$antwort3",
      "antwort4": "$antwort4",
      "position": "$position",
      "loesungsText": "$loesungsText",
    };
  }
}
