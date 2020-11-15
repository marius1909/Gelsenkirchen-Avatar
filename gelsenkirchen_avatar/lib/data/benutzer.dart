import 'dart:convert';
import 'package:gelsenkirchen_avatar/data/database_url.dart';
import 'package:gelsenkirchen_avatar/data/datenbankObjekt.dart';
import 'package:http/http.dart' as http;

class Benutzer extends DatenbankObjekt<Benutzer> {
  int id;
  String email;
  String benutzername;
  String passwort;
  String rolleID;

  static Benutzer get shared => Benutzer();

  Benutzer(
      {this.id, this.email, this.benutzername, this.passwort, this.rolleID})
      : super('', '', '');

  static Future<Benutzer> getBenutzer(String email, String passwort) async {
    final response = await http.post(DatabaseURL.anmeldung.value,
        body: shared._requestBody);
    final jsonArray = jsonDecode(response.body);
    return shared.objektVonJasonArray(jsonArray);
  }

  Map<String, String> get _requestBody {
    var map = this.map;
    map.remove("id");
    map.remove("benutzername");
    map.remove("rolleID");
    return map;
  }

  @override
  Benutzer objektVonJasonArray(dynamic objekt) {
    return Benutzer(
        id: int.parse(objekt["id"]),
        email: objekt["email"] as String,
        benutzername: objekt["benutzername"] as String,
        passwort: objekt["passwort"],
        rolleID: objekt["rolleID"]);
  }

  @override
  Map<String, String> get insertingIntoDatabaseRequestBody {
    var map = this.map;
    map.remove("id");
    return map;
  }

  /// Map Representation des Benutzers.
  @override
  Map<String, String> get map {
    return {
      "id": "$id",
      "email": "$email",
      "benutzername": "$benutzername",
      "passwort": "$passwort",
      "rolleID": "$rolleID"
    };
  }
}
