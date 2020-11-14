import 'package:gelsenkirchen_avatar/data/database_url.dart';
import 'package:gelsenkirchen_avatar/data/datenbankObjekt.dart';

class Lernort extends DatenbankObjekt {
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
      this.weitereBilder}) : 
      super(DatabaseURL.getLernorte.value, 
      DatabaseURL.insertIntoLernort.value, 
      DatabaseURL.removeFromLernort.value);

  @override
  List<Lernort> parseVonJson(dynamic json) {
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

  /// Map Representation des Lernortes.
  @override
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
}
