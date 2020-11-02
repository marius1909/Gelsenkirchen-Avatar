import 'dart:convert';
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

  static Future<List<Lernort>> gibLernorte() async {
    final url = "http://zukunft.sportsocke522.de/getLernorte.php";
    final response = await http.get(url);
    final jsonData = jsonDecode(response.body);
    return Lernort._lernorteVonJson(jsonData);
  }

  Future<Response> insertToDatabase() async {
    final response = await http.post(
        "http://zukunft.sportsocke522.de/insertIntoLernort.php",
        body: _requestBody());
    return response;
  }

  Map<String, String> _requestBody() {
    var map = toMap();
    map.remove("id");
    return map;
  }

  Map<String, String> toMap() {
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
    return toMap().toString();
  }
}
