import 'package:flutter/rendering.dart';
import 'package:gelsenkirchen_avatar/data/database_url.dart';
import 'package:gelsenkirchen_avatar/data/datenbankObjekt.dart';
import 'package:gelsenkirchen_avatar/data/database_url.dart';
import '';

class LernKategorie extends DatenbankObjekt<LernKategorie> {
  int id;
  String name;
  String logo;

  static LernKategorie get shared => LernKategorie();

  LernKategorie({this.id, this.name, this.logo})
      : super(
            DatabaseURL.getLernkategorie.value,
            DatabaseURL.insertIntoLernKategorie.value,
            DatabaseURL.removeFromLernKategorie.value);

  @override
  LernKategorie objektVonJasonArray(objekt) {
    return LernKategorie(
        id: int.parse(objekt["id"]),
        name: objekt["name"] as String,
        logo: objekt["logo"] as String);
  }

  @override
  Map<String, String> get map {
    return {
      "id": "$id",
      "name": "$name",
      "logo": "$logo",
    };
  }

  @override
  String toString() {
    return super.toString();
  }
}
