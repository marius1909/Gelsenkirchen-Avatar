import 'dart:convert';

class SuchspielArt {
  String loesungswort;
  int lernortID;

  SuchspielArt(this.loesungswort, this.lernortID);

  static SuchspielArt fromQRCode(String json) {
    dynamic object = jsonDecode(json);
    return SuchspielArt(object['loesung'], object['lernortID']);
  }
}
