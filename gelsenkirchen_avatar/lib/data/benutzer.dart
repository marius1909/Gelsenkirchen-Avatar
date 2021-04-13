import 'dart:convert';
import 'database_url.dart';
import 'datenbankObjekt.dart';
import 'package:gelsenkirchen_avatar/data/benutzer_invalid_login_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

/// Representiert einen einzelnen Benutzer in der Datenbank
class Benutzer extends DatenbankObjekt<Benutzer> {
  int id;
  String email;
  String benutzer;
  String passwort;
  int rolleID;
  int erfahrung;

  static Benutzer get shared => Benutzer();

  /// Der derzeitig eingeloggte Benutzer.
  static Benutzer current;

  Benutzer(
      {this.id,
      this.email,
      this.benutzer,
      this.passwort,
      this.rolleID,
      this.erfahrung})
      : super(
            DatabaseURL.getBenutzer.value,
            DatabaseURL.registrierung.value,
            DatabaseURL.removeFromBenutzer.value,
            DatabaseURL.updateBenutzer.value);

  /// Ruft einen vorhandenen Benutzer aus der Datenbank mit zugehörigem Login ab.
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

  void erwerbZusaetzlicherErfahrungspunkte(int erfahrungspunkte) {
    this.erfahrung += erfahrungspunkte;
    super.updateDatabaseWithID("erfahrung", "$erfahrung", this.id);
  }

  @override
  Benutzer objektVonJasonArray(dynamic objekt) {
    return Benutzer(
        id: int.parse(objekt["id"]),
        email: objekt["email"] as String,
        benutzer: objekt["benutzer"] as String,
        passwort: objekt["passwort"] as String,
        rolleID: int.parse(objekt["rolleID"]),
        erfahrung: int.parse(objekt["erfahrung"]));
  }

  @override
  Map<String, String> get insertingIntoDatabaseRequestBody {
    var map = this.map;
    map.remove("id");
    return map;
  }

  @override
  Map<String, String> get map {
    return {
      "id": "$id",
      "email": "$email",
      "benutzer": "$benutzer",
      "passwort": "$passwort",
      "rolleID": "$rolleID",
      "erfahrung": "$erfahrung"
    };
  }
}
