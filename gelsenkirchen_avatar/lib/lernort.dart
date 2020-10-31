import 'package:gelsenkirchen_avatar/lernort_klein.dart';

class Lernort {
  int id;
  int nord;
  int ost;
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

  int get getId => id;

  //set setId(int id) => this.id = id;

  int get getNord => nord;

  set setNord(int nord) => this.nord = nord;

  int get getOst => ost;

  set setOst(int ost) => this.ost = ost;

  int get getKategorieID => kategorieID;

  set setKategorieID(int kategorieID) => this.kategorieID = kategorieID;

  String get getName => name;

  //set setName(String name) => this.name = name;

  String get getKurzbeschreibung => kurzbeschreibung;

  set setKurzbeschreibung(String kurzbeschreibung) =>
      this.kurzbeschreibung = kurzbeschreibung;

  String get getBeschreibung => beschreibung;

  set setBeschreibung(String beschreibung) => this.beschreibung = beschreibung;

  String get getTitelbild => titelbild;

  set setTitelbild(String titelbild) => this.titelbild = titelbild;

  int get getMinispielArt => minispielArt;

  set setMinispielArt(int minispielArt) => this.minispielArt = minispielArt;

  int get getBelohnungenID => belohnungenID;

  set setBelohnungenID(int belohnungenID) => this.belohnungenID = belohnungenID;

  String get getWeitereBilder => weitereBilder;

  set setWeitereBilder(String weitereBilder) =>
      this.weitereBilder = weitereBilder;

  void setId(int resultID) {
    this.id = resultID;
  }

  void setName(resultText) {
    this.name = resultText;
  }
}
