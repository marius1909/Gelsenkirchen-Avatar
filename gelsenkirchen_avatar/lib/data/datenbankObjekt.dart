import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

/// Representation eines Objektes in der Datenbank
abstract class DatenbankObjekt<D extends DatenbankObjekt<D>> {
  String getFromDatabaseURL;
  String insertIntoDatabaseURL;
  String removeFromDatabaseURL;
  String updateDatabaseURL;

  /// Erstellt ein DatenbankObjekt, mit Hilfe von URL, um Objekte aus der Daten-
  /// bank zu holen, einzufügen, entfernen und zu ändern.
  DatenbankObjekt(this.getFromDatabaseURL, this.insertIntoDatabaseURL,
      this.removeFromDatabaseURL, this.updateDatabaseURL);

  /// Enthält die in der Datenbank befindenden Objekte nachdem `gibObjekte`
  /// aufgerufen wurde.
  List<D> _datenbankObjektList = List();

  /// Erstellt aus dem Jason Array `objekt` ein neues Objekt vom Typ `D`.
  D objektVonJasonArray(dynamic objekt);

  /// Gibt alle Objekte zurück, die sich in der Datenbank befinden.
  /// Die Daten werden allerdings nur einmal geladen.
  Future<List<D>> gibObjekte() async {
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

  /// Erstellt aus JSON-Daten eine Liste mit Elementen des Typs `D`.
  List<D> _parseVonJson(dynamic json) {
    List<D> objekte = List();
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

  /// Entfernt das Objekt aus der Datenbank mit der entsprechenden Identifikation.
  Future<Response> removeFromDatabaseWithID(Map<String, String> id) async {
    final response = await http.post(removeFromDatabaseURL, body: id);
    return response;
  }

  /// Updaten des Datensatzes anhand der ID.
  Future<Response> updateDatabaseWithID(
      String attribut, String neuerWert, int id) async {
    var data = {
      "attribut": attribut,
      "neuerWert": neuerWert,
      "id": id.toString()
    };
    final response = await http.post(updateDatabaseURL, body: data);
    return response;
  }

  /// Map Representation des Objektes.
  Map<String, String> get map;

  @override
  String toString() {
    return map.toString();
  }
}
