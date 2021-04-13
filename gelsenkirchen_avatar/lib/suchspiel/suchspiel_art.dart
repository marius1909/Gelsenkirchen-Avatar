import 'dart:convert';

class SuchspielArt {
  String loesungswort;
  int lernortID;
  int suchID;

  SuchspielArt(this.loesungswort, this.lernortID, this.suchID);

  static SuchspielArt fromQRCode(String json) {
    dynamic object = jsonDecode(json);
    return SuchspielArt(object['loesung'], object['lernortID'], object['suchID']);
  }
}
