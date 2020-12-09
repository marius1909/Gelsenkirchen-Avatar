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
  insertIntoMinispielArt,
  insertIntoLernKategorie,
  insertIntoFreigeschaltet,
  insertIntoBenutzerSpiel,
  insertIntoRollen,
  insertIntoBenutzerKategorie,
  insertIntoSammelKategorie,
  insertIntoSammelbares,
  insertIntoQuiz,
  registrierung,
  lernortVorschau,
  anmeldung,
  quiz,
  removeFromLernort,
  removeFromBenutzerKategorie,
  removeFromBenutzerSpiel,
  removeFromBenutzer,
  removeFromFreigeschaltet,
  removeFromLernKategorie,
  removeFromMinispielArt,
  removeFromQuiz,
  removeFromQuizFragen,
  removeFromRollen,
  removeFromSammelKategorie,
  removeFromSammelbares
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
      case DatabaseURL.getQuiz:
        return _baseURL + "get_lernortID.php?id=";
      case DatabaseURL.removeFromLernort:
        return _baseURL + "removeFromLernort.php";
      case DatabaseURL.insertIntoMinispielArt:
        return _baseURL + "insertIntoMinispielArt.php";
      case DatabaseURL.insertIntoLernKategorie:
        return _baseURL + "insertIntoLernKategorie.php";
      case DatabaseURL.insertIntoFreigeschaltet:
        return _baseURL + "insertIntoFreigeschaltet.php";
      case DatabaseURL.insertIntoRollen:
        return _baseURL + "insertIntoRollen.php";
      case DatabaseURL.insertIntoBenutzerSpiel:
        return _baseURL + "insertIntoBenutzerSpiel.php";
      case DatabaseURL.insertIntoBenutzerKategorie:
        return _baseURL + "insertIntoBenutzerKategorie.php";
      case DatabaseURL.insertIntoSammelKategorie:
        return _baseURL + "insertIntoSammelKategorie.php";
      case DatabaseURL.insertIntoSammelbares:
        return _baseURL + "insertIntoSammelbares.php";
      case DatabaseURL.insertIntoQuiz:
        return _baseURL + "insertIntoQuiz.php";
      case DatabaseURL.removeFromBenutzerKategorie:
        return _baseURL + "removeFromBenutzerKategorie.php";
      case DatabaseURL.removeFromBenutzerSpiel:
        return _baseURL + "removeFromBenutzerSpiel.php";
      case DatabaseURL.removeFromBenutzer:
        return _baseURL + "removeFromBenutzer.php";
      case DatabaseURL.removeFromFreigeschaltet:
        return _baseURL + "removeFromFreigeschaltet.php";
      case DatabaseURL.removeFromLernKategorie:
        return _baseURL + "removeFromLernKategorie.php";
      case DatabaseURL.removeFromMinispielArt:
        return _baseURL + "removeFromMinispielArt.php";
      case DatabaseURL.removeFromQuiz:
        return _baseURL + "removeFromQuiz.php";
      case DatabaseURL.removeFromQuizFragen:
        return _baseURL + "removeFromQuizFragen.php";
      case DatabaseURL.removeFromRollen:
        return _baseURL + "removeFromRollen.php";
      case DatabaseURL.removeFromSammelKategorie:
        return _baseURL + "removeFromSammelKategorie.php";
      case DatabaseURL.removeFromSammelbares:
        return _baseURL + "removeFromSammelbares.php";
      default:
        return null;
    }
  }
}
