import 'package:gelsenkirchen_avatar/data/database_url.dart';
import 'package:gelsenkirchen_avatar/data/datenbankObjekt.dart';
import 'package:gelsenkirchen_avatar/data/benutzer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Freundschaft extends DatenbankObjekt<Freundschaft> {
  int benutzerID_1;
  int benutzerID_2;

  static Freundschaft get shared => Freundschaft();

  Freundschaft({this.benutzerID_1, this.benutzerID_2})
      : super(DatabaseURL.getFreundschaft.value,
            DatabaseURL.insertIntoFreundschaft.value, '', '');

  List<Benutzer> _freundesliste = List();

  Future<List<Benutzer>> gibFreunde(int aktuellerBenutzer) async {
    if (_freundesliste.isEmpty) {
      await _ladeFreunde(aktuellerBenutzer);
    }
    return _freundesliste;
  }

  _ladeFreunde(int aktuellerBenutzer) async {
    var body = {"benutzerID_1": aktuellerBenutzer.toString()};
    var url = "http://zukunft.sportsocke522.de/getFreunde.php";

    final response = await http.post(url, body: body);
    final jsonData = jsonDecode(response.body);
    _freundesliste = this._parseFreunde(jsonData);
  }

  List<Benutzer> _parseFreunde(dynamic json) {
    List<Benutzer> objekte = List();
    for (var objekt in json) {
      objekte.add(Benutzer.shared.objektVonJasonArray(objekt));
    }
    return objekte;
  }

  Future<Benutzer> neuerFreund(String _name) async {
    var freund = await Benutzer.shared.sucheObjekt("benutzer", _name);
    Benutzer f = freund[0];

    return f;
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
