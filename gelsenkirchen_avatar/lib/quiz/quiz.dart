import 'dart:convert';
import 'package:gelsenkirchen_avatar/data/database_url.dart';
import 'package:http/http.dart' as http;

class Quiz {
  int quizID;
  static Quiz shared = Quiz();

  Quiz({
    this.quizID,
  });

  static Quiz _QuizVonJson(dynamic json) {
    return new Quiz(quizID: int.parse(json["quizID"]));
  }

  Future<Quiz> getQuiz(int id) async {
    final response = await http.get(DatabaseURL.getQuiz.value + id.toString());
    final jsonData = jsonDecode(response.body);
    return Quiz._QuizVonJson(jsonData);
  }

  Map<String, String> get map {
    return {
      "id": "$quizID",
    };
  }

  @override
  String toString() {
    return map.toString();
  }
}
