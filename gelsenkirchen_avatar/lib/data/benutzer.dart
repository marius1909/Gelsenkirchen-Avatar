import 'dart:convert';
import 'database_url.dart';
import 'datenbankObjekt.dart';
import 'package:gelsenkirchen_avatar/data/benutzer_invalid_login_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Benutzer extends DatenbankObjekt<Benutzer> {
  int id;
  String email;
  String benutzer;
  String passwort;
  int rolleID;

  static Benutzer get shared => Benutzer();
  static Benutzer current;

  Benutzer({this.id, this.email, this.benutzer, this.passwort, this.rolleID})
      : super(DatabaseURL.getBenutzer.value, DatabaseURL.registrierung.value,
            DatabaseURL.removeFromBenutzer.value, '');

  static Future<Benutzer> getBenutzer(String email, String passwort) async {
    final response = await http.post(DatabaseURL.anmeldung.value,
        body: {"email": "$email", "passwort": "$passwort"});
    final responseBody = jsonDecode(response.body);
    if (responseBody == InvalidLoginExceptionCause.emailNotFound.message) {
      throw InvalidLoginException(InvalidLoginExceptionCause.emailNotFound);
    } else if (responseBody ==
        InvalidLoginExceptionCause.passwordIncorrect.message) {
      throw InvalidLoginException(InvalidLoginExceptionCause.passwordIncorrect);
    } else {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString("benutzer", response.body);
      current = shared.objektVonJasonArray(responseBody);
      return current;
    }
  }

  void setCurrent(dynamic objekt) {
    current = shared.objektVonJasonArray(objekt);
  }

  @override
  Benutzer objektVonJasonArray(dynamic objekt) {
    return Benutzer(
        id: int.parse(objekt["id"]),
        email: objekt["email"] as String,
        benutzer: objekt["benutzer"] as String,
        passwort: objekt["passwort"] as String,
        rolleID: int.parse(objekt["rolleID"]));
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
      "benutzer": "$benutzer",
      "passwort": "$passwort",
      "rolleID": "$rolleID"
    };
  }
}
