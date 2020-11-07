enum DatabaseURL {
  dbconfig, getLernorte, insertIntoLernort, registrierung, lernortVorschau, anmeldung, quiz
}

extension DatabaseURLExtension on DatabaseURL {
  static String _baseURL = "http://zukunft.sportsocke522.de/";

  /// Assoziierte URL
  String get value {
    switch (this) {
      case DatabaseURL.dbconfig:
        return _baseURL + "dbconfig.php";
      case DatabaseURL.getLernorte:
        return _baseURL + "getLernorte.php";
      case DatabaseURL.insertIntoLernort:
        return _baseURL + "insertIntoLernort.php";
      case DatabaseURL.registrierung:
        return _baseURL + "registrierung.php";
      case DatabaseURL.lernortVorschau:
        return _baseURL + "lernortVorschau.php";
      case DatabaseURL.anmeldung:
        return _baseURL + "anmeldung.php";
      case DatabaseURL.quiz:
        return _baseURL + "quiz.php";
      default:
        return null;
    }
  }
}