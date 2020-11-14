import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class DatenbankObjekt {
  String getFromDatabaseURL;
  String insertIntoDatabaseURL;
  String removeFromDatabaseURL;

  DatenbankObjekt
  (this.getFromDatabaseURL, 
  this.insertIntoDatabaseURL, 
  this.removeFromDatabaseURL);

  List<DatenbankObjekt> _datenbankObjektList = List();

  List<DatenbankObjekt> parseVonJson(dynamic json);

  /// Gibt alle Objekte zurück, die sich in der Datenbank befinden.
  /// Die Daten werden allerdings nur einmal geladen.
  Future<List<DatenbankObjekt>> gibObjekte() async {
    if (_datenbankObjektList.isEmpty) {
      await ladeObjekte();
    }
    return _datenbankObjektList;
  }

  /// Lädt alle Objekte aus der Datenbank.
  /// Kann benutzt werden, um die Objekte zu aktualisieren.
  ladeObjekte() async {
    final response = await http.get(getFromDatabaseURL);
    final jsonData = jsonDecode(response.body);
    _datenbankObjektList = this.parseVonJson(jsonData);
  }

  /// Schreibt das Objekt in die Datenbank.
  Future<Response> insertIntoDatabase() async {
    final response = await http.post(insertIntoDatabaseURL,
        body: _requestBody());
    return response;
  }

  /// Helfermethode der Methode insertToDatabase.
  Map<String, String> _requestBody() {
    var map = this.map;
    map.remove("id");
    return map;
  }

  Future<Response> removeFromDatabaseWithID(Map<String, String> id) async {
    final response = await http
        .post(removeFromDatabaseURL, body: id);
    return response;
  }

  /// Map Representation des Objektes.
  Map<String, String> get map;

  @override
  String toString() {
    return map.toString();
  }

}