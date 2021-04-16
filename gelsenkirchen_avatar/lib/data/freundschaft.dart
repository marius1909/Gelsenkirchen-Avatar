import 'package:gelsenkirchen_avatar/data/database_url.dart';
import 'package:gelsenkirchen_avatar/data/datenbankObjekt.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Freundschaft extends DatenbankObjekt<Freundschaft> {
  int benutzerID_1;
  int benutzerID_2;

  static Freundschaft get shared => Freundschaft();

  Freundschaft({this.benutzerID_1, this.benutzerID_2})
      : super(
            DatabaseURL.getFreundschaft.value,
            DatabaseURL.insertIntoFreundschaft.value,
            DatabaseURL.removeFromFreundschaft.value,
            '');

  List<Benutzer> _freundesliste = List();

  /* Gibt die aktuellen Freunde des Benutzers zurück */
  Future<List<Benutzer>> gibFreunde(int aktuellerBenutzer) async {
    if (_freundesliste.isEmpty) {
      await _ladeFreunde(aktuellerBenutzer);
    }
    return _freundesliste;
  }

  /* Lädt die Freundesliste aus der Tabelle Freundschaft und die verknüpften Benutzer aus der Tabelle Benutzer*/
  _ladeFreunde(int aktuellerBenutzer) async {
    var body = {"benutzerID_1": aktuellerBenutzer.toString()};
    var url = "http://zukunft.sportsocke522.de/getFreunde.php";

    final response = await http.post(url, body: body);
    final jsonData = jsonDecode(response.body);
    _freundesliste = this._parseFreunde(jsonData);
  }

  /* Erstellt eine Liste vom Typ Benutzer */
  List<Benutzer> _parseFreunde(dynamic json) {
    List<Benutzer> objekte = List();
    for (var objekt in json) {
      objekte.add(Benutzer.shared.objektVonJasonArray(objekt));
    }
    return objekte;
  }

  /* Fügt einen neuen Freund in der Tabelle Freundschaft hinzu */
  Future<Benutzer> neuerFreund(String _name) async {
    var freund = await Benutzer.shared.sucheObjekt("benutzer", _name);
    Benutzer f;
    if (freund.isNotEmpty) {
      f = freund[0];
    }

    return f;
  }

  /// Entfernt das Objekt aus der Datenbank mit der entsprechenden Identifikation.
  Future<Response> removeFreund(int benutzerID_1, int benutzerID_2) async {
    var body = {
      "benutzerID_1": benutzerID_1.toString(),
      "benutzerID_2": benutzerID_2.toString()
    };
    final response = await http.post(removeFromDatabaseURL, body: body);
    return response;
  }

  @override
  Freundschaft objektVonJasonArray(objekt) {
    return Freundschaft(
      benutzerID_1: int.parse(objekt["benutzerID_1"]),
      benutzerID_2: int.parse(objekt["benutzerID_2"]),
    );
  }

  @override
  Map<String, String> get map {
    return {
      "benutzerID_1": "$benutzerID_1",
      "benutzerID_2": "$benutzerID_2",
    };
  }

  @override
  String toString() {
    return super.toString();
  }
}
