enum DatabaseURL {
  dbconfig,
  getLernorte,
  getRollen,
  getFreigeschaltet,
  getSammelKategorie,
  getSammelbares,
  getBenutzerKategorie,
  getLernkategorie,
  getBenutzerSpiel,
  getMinispielArt,
  getQuiz,
  insertIntoLernort,
  getQuizFragen,
  insertIntoQuizFragen,
  getBenutzer,
  registrierung,
  lernortVorschau,
  anmeldung,
  quiz,
  removeFromLernort
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
      case DatabaseURL.getRollen:
        return _baseURL + "getRollen.php";
      case DatabaseURL.getFreigeschaltet:
        return _baseURL + "getFreigeschaltet.php";  
      case DatabaseURL.getSammelKategorie:
        return _baseURL + "getSammelKategorie.php";
      case DatabaseURL.getSammelbares:
        return _baseURL + "getSammelbares.php";
      case DatabaseURL.getBenutzerKategorie:
        return _baseURL + "getBenutzerKategorie.php";
      case DatabaseURL.getLernkategorie:
        return _baseURL + "getLernKategorie.php";
      case DatabaseURL.getBenutzerSpiel:
        return _baseURL + "getBenutzerSpiel.php";
      case DatabaseURL.getMinispielArt:
        return _baseURL + "getMinispielArt.php";
      case DatabaseURL.getQuiz:
        return _baseURL + "getQuiz.php";
      case DatabaseURL.getBenutzer:
        return _baseURL + "getBenutzer.php";
      case DatabaseURL.registrierung:
        return _baseURL + "registrierung.php";
      case DatabaseURL.lernortVorschau:
        return _baseURL + "lernortVorschau.php";
      case DatabaseURL.anmeldung:
        return _baseURL + "anmeldung.php";
      case DatabaseURL.getQuizFragen:
        return _baseURL + "getQuizFragen.php";
      case DatabaseURL.insertIntoQuizFragen:
        return _baseURL + "insertIntoQuizFragen.php";
      case DatabaseURL.quiz:
        return _baseURL + "quiz.php";
      case DatabaseURL.removeFromLernort:
        return _baseURL + "removeFromLernort.php";
      default:
        return null;
    }
  }
}
