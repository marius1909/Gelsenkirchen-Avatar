class Lernort {
  int id;
  int nord;
  int ost;
  int kategorieId;
  String name;
  String kurzbeschreibung;
  String beschreibung;
  String titelbild;
  int minispielArtId;
  int belohnungenId;
  String weitereBilder;

  Lernort(
      {this.id,
      this.nord,
      this.ost,
      this.kategorieId,
      this.name,
      this.kurzbeschreibung,
      this.beschreibung,
      this.titelbild,
      this.minispielArtId,
      this.belohnungenId,
      this.weitereBilder});

  void setId(int id) {
    this.id = id;
  }

  void setNord(int nord) {
    this.nord = nord;
  }

  void setOst(int ost) {
    this.ost = ost;
  }

  void setKategorieId(int kategorieId) {
    this.kategorieId = kategorieId;
  }

  void setName(String name) {
    this.name = name;
  }

  void setKurzbeschreibung(String kurzbeschreibung) {
    this.kurzbeschreibung = kurzbeschreibung;
  }

  void setBeschreibung(String beschreibung) {
    this.beschreibung = beschreibung;
  }

  void setTitelbild(String titelbild) {
    this.titelbild = titelbild;
  }

  void setMinispielArtId(int minispielArtId) {
    this.minispielArtId = minispielArtId;
  }

  void setBelohnungenId(int belohnungenId) {
    this.belohnungenId = belohnungenId;
  }

  void setWeitereBilder(String weitereBilder) {
    this.weitereBilder = weitereBilder;
  }
}
