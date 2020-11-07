import 'dart:convert';
import 'package:gelsenkirchen_avatar/database_url.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Lernort {
  int id;
  double nord;
  double ost;
  int kategorieID;
  String name;
  String kurzbeschreibung;
  String beschreibung;
  String titelbild;
  int minispielArt;
  int belohnungenID;
  String weitereBilder;
  List<Lernort> _lernortList = List();

  /// Wird genutzt zur konsitenten Anzeige aller Lernorte
  /// und um die Abrufe aus der Datenbank zu minimieren.
  /// Beispiel: Lernort.shared.gibLernorte();
  static Lernort shared = Lernort();

  Lernort(
      {this.id,
      this.nord,
      this.ost,
      this.kategorieID,
      this.name,
      this.kurzbeschreibung,
      this.beschreibung,
      this.titelbild,
      this.minispielArt,
      this.belohnungenID,
      this.weitereBilder});

  static List<Lernort> _lernorteVonJson(dynamic json) {
    List<Lernort> lernorte = List();
    for (var ort in json) {
      final lernort = Lernort(
          id: int.parse(ort["id"]),
          nord: double.parse(ort["nord"]),
          ost: double.parse(ort["ost"]),
          kategorieID: int.parse(ort["kategorieID"]),
          name: ort["name"] as String,
          kurzbeschreibung: ort["kurzbeschreibung"] as String,
          beschreibung: ort["beschreibung"] as String,
          titelbild: ort["titelbild"] as String,
          minispielArt: int.parse(ort["minispielArtID"]),
          belohnungenID: int.parse(ort["belohnungenID"]),
          weitereBilder: ort["weitereBilder"] as String);
      lernorte.add(lernort);
    }
    return lernorte;
  }

  /// Gibt alle Lernorte zurück, die sich in der Datenbank befinden.
  /// Die Daten werden allerdings nur einmal geladen.
  Future<List<Lernort>> gibLernorte() async {
    if (_lernortList.isEmpty) {
      await ladeLernorte();
    }
    return _lernortList;
  }

  /// Lädt alle Lernorte aus der Datenbank.
  ladeLernorte() async {
    final response = await http.get(DatabaseURL.getLernorte.value);
    final jsonData = jsonDecode(response.body);
    _lernortList = Lernort._lernorteVonJson(jsonData);
  }
  
  /// Schreibt den Lernort in die Datenbank.
  Future<Response> insertToDatabase() async {
    final response = await http.post(
        DatabaseURL.insertIntoLernort.value,
        body: _requestBody());
    return response;
  }

  static Future<Response> removeFromDatabaseWithID(int lerordID) async {
    final response = await http.post(
        "http://zukunft.sportsocke522.de/removeFromLernort.php",
        body: {"id": "$lerordID"});
    print(response.body);
    return response;
  }

  /// Helfermethode der Methode insertToDatabase.
  Map<String, String> _requestBody() {
    var map = this.map;
    map.remove("id");
    return map;
  }

  /// Map Representation des Lernortes.
  Map<String, String> get map {
    return {
      "id": "$id",
      "nord": "$nord",
      "ost": "$ost",
      "kategorieID": "$kategorieID",
      "name": "$name",
      "kurzbeschreibung": "$kurzbeschreibung",
      "beschreibung": "$beschreibung",
      "titelbild": "$belohnungenID",
      "minispielArtID": "$minispielArt",
      "belohnungenID": "$belohnungenID",
      "weitereBilder": "$weitereBilder"
    };
  }

  @override
  String toString() {
    return map.toString();
  }
}
