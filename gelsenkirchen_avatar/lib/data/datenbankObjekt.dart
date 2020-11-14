import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class DatenbankObjekt {
  String getFromDatabaseURL;
  String insertIntoDatabaseURL;
  String removeFromDatabaseURL;

  DatenbankObjekt(this.getFromDatabaseURL, this.insertIntoDatabaseURL,
      this.removeFromDatabaseURL);

  List<DatenbankObjekt> _datenbankObjektList = List();

  DatenbankObjekt objektVonJasonArray(dynamic objekt);

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
    _datenbankObjektList = this._parseVonJson(jsonData);
  }

  List<DatenbankObjekt> _parseVonJson(dynamic json) {
    List<DatenbankObjekt> objekte = List();
    for (var objekt in json) {
      objekte.add(objektVonJasonArray(objekt));
    }
    return objekte;
  }

  /// Schreibt das Objekt in die Datenbank.
  Future<Response> insertIntoDatabase() async {
    final response = await http.post(insertIntoDatabaseURL,
        body: insertingIntoDatabaseRequestBody);
    return response;
  }

  /// Helfermethode der Methode insertToDatabase.
  Map<String, String> get insertingIntoDatabaseRequestBody => map;

  Future<Response> removeFromDatabaseWithID(Map<String, String> id) async {
    final response = await http.post(removeFromDatabaseURL, body: id);
    return response;
  }

  /// Map Representation des Objektes.
  Map<String, String> get map;

  @override
  String toString() {
    return map.toString();
  }
}
