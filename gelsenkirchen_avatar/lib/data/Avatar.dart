/* 
Klasse Avatar
Diese Klasse ist für das Laden und Speichern des Avatars aus/in der Datenbank zuständig
Avatare befinden im Ordner /assets/avatar/500px/"Basisavatar"/"PfadID"
Um einen Avatar zu laden muss zuerst der ausgewählte Basisavatar geprüft werden um den richtigen Unterordner dem Pfad hinzuzufügen
Danach muss die richtige pfadID angegeben werden. Manchmal muss diese berechnet werden.

Es werden die Datenbank Tabellen Sammelbares und Freigeschaltet benutzt.
Die Tabelle Sammelbares enthält alle Information über ein bestimmtes Collectable und dessen pfadID(!) zuwie zu wessem Basisavatar es gehört.
Die Tabelle Freigeschaltet sagt aus ob ein Benutzer ein Sammelbares Objekt freigeschaltet und ausgerüstet hat
Durch die Tabelle Sammelbares wird oft iteriert und mit der Freigeschaltet Tabelle verglichen.

Jeder Avatar hat 3 Collectables, die einzeln oder auch alle ausgerüstet werden können. Somit bestehen 7 (+1 Basisavatar) Möglichkeiten einen Avatar darzustellen



*/
import 'dart:convert';
import 'package:gelsenkirchen_avatar/data/freigeschaltet.dart';
import 'package:gelsenkirchen_avatar/data/sammelbares.dart';
import 'package:http/http.dart' as http;

class Avatar {
  int avatarTypID;
  int collectableID;

//Assetpfade
  static String _basePathNeu = "assets/avatar/500px/";
  static String _suffixNeu = ".png";

  Avatar(int _avatarTypID, int _collectableID) {
    collectableID = _collectableID;
    avatarTypID = _avatarTypID;
  }

/*Gibt den StandardAvatar eines BasisAvatars zurück */
  static String getDefaultImagePath(int baseID) {
    return _basePathNeu + getBaseAvatar(baseID) + "0" + _suffixNeu;
  }

/* Gibt den Datei-Pfad für den aktuell Ausgerüsteten Avatar eines Benutzers wieder*/
  static Future<String> getImagePath(int userID) async {
    List<Sammelbares> sammelbares = await Sammelbares.shared.gibObjekte();

    String baseAvatar = "";

    List<Freigeschaltet> freigeschalteteErrungenschaften =
        await getFreigeschalteteErrungenschaften(userID);

    List<Sammelbares> ausgeruesteteErrungenschaften = new List();
    int pfadID = 0;

    for (var i = 0; i < freigeschalteteErrungenschaften.length; i++) {
      if (freigeschalteteErrungenschaften[i].ausgeruestet) {
        for (var j = 0; j < sammelbares.length; j++) {
          if (sammelbares[j].id ==
              freigeschalteteErrungenschaften[i].sammelID) {
            if (sammelbares[j].kategorieID == 2) {
              baseAvatar = getBaseAvatar(sammelbares[j].pfadID);
            } else {
              ausgeruesteteErrungenschaften.add(sammelbares[j]);
            }
          }
        }
      }
    }
    for (var i = 0; i < ausgeruesteteErrungenschaften.length; i++) {
      pfadID += ausgeruesteteErrungenschaften[i].pfadID;
    }

    //Falls BaseAvatar nicht korrekt Aus datenbank geladen wird
    if (baseAvatar == "") {
      baseAvatar = getBaseAvatar(0);
    }

    return _basePathNeu + baseAvatar + pfadID.toString() + _suffixNeu;
  }

/* Gibt alle Errungenschaften eines Benutzers zurück */
  static Future<List<String>> getAlleErrungenschaftenPath(int userid) async {
    String path;
    List<String> alleErrungenschaften = new List();
    List<Sammelbares> sammelbares = await Sammelbares.shared.gibObjekte();

    List<Freigeschaltet> freigeschalteteErrungenschaften =
        await getFreigeschalteteErrungenschaften(userid);

    for (var i = 0; i < freigeschalteteErrungenschaften.length; i++) {
      for (var j = 0; j < sammelbares.length; j++) {
        path = _basePathNeu;
        if (sammelbares[j].id == freigeschalteteErrungenschaften[i].sammelID) {
          if (istBasisAvatar(sammelbares[j])) {
            path += getBaseAvatar(sammelbares[j].pfadID) + "0" + _suffixNeu;

            alleErrungenschaften.add(path);
          } else {
            path += getBaseAvatar(sammelbares[j].basisID) +
                sammelbares[j].pfadID.toString() +
                _suffixNeu;
            alleErrungenschaften.add(path);
          }
        }
      }
    }

    //Wenn Datensatz nicht oder nicht richtig geladen wird, Standardavatare füllen
    if (alleErrungenschaften.isEmpty) {
      alleErrungenschaften.add(getDefaultImagePath(0));
      alleErrungenschaften.add(getDefaultImagePath(1));
      alleErrungenschaften.add(getDefaultImagePath(2));
      alleErrungenschaften.add(getDefaultImagePath(3));
    }

    return alleErrungenschaften;
  }

/* Gibt alle Auswählbaren Avatare für einen Benutzer wieder */
  static Future<Map> getAuswaehlbareAvatare(int userid) async {
    List<Sammelbares> sammelbares = await Sammelbares.shared.gibObjekte();
    List<Freigeschaltet> freigeschalteteErrungenschaften =
        await getFreigeschalteteErrungenschaften(userid);

    // ignore: non_constant_identifier_names
    List<Sammelbares> Blau = new List();
    // ignore: non_constant_identifier_names
    List<Sammelbares> Gelb = new List();
    // ignore: non_constant_identifier_names
    List<Sammelbares> Gruen = new List();
    // ignore: non_constant_identifier_names
    List<Sammelbares> Rot = new List();

    for (var i = 0; i < freigeschalteteErrungenschaften.length; i++) {
      for (var j = 0; j < sammelbares.length; j++) {
        if (sammelbares[j].id == freigeschalteteErrungenschaften[i].sammelID) {
          if (!istBasisAvatar(sammelbares[j])) {
            if (sammelbares[j].basisID == 0) {
              Blau.add(sammelbares[j]);
            } else if (sammelbares[j].basisID == 1) {
              Gelb.add(sammelbares[j]);
            } else if (sammelbares[j].basisID == 2) {
              Gruen.add(sammelbares[j]);
            } else if (sammelbares[j].basisID == 3) {
              Rot.add(sammelbares[j]);
            }
          }
        }
      }
    }

    List<List<Sammelbares>> list = new List();
    list.add(Blau);
    list.add(Gelb);
    list.add(Gruen);
    list.add(Rot);
    String path = "";

    List<String> alleKombinationen = new List();
    List<List<int>> pathIDs = new List();
    for (var i = 0; i < list.length; i++) {
      path = _basePathNeu + getBaseAvatar(i);

//1 Kombinationsmöglichkeit
      if (list[i].length == 1) {
        alleKombinationen.add(path + list[i][0].pfadID.toString());
        pathIDs.add([i, list[i][0].pfadID]);

        //3 Kombinationsmöglichkeiten
      } else if (list[i].length == 2) {
        alleKombinationen.add(path + list[i][0].pfadID.toString());
        pathIDs.add([i, list[i][0].pfadID]);

        alleKombinationen.add(path + list[i][1].pfadID.toString());
        pathIDs.add([i, list[i][1].pfadID]);

        alleKombinationen
            .add(path + (list[i][0].pfadID + list[i][1].pfadID).toString());
        pathIDs.add([i, list[i][0].pfadID, list[i][1].pfadID]);

        //7 Kombinationsmöglichkeiten
        /*
        001 0
        010 1
        011 10
        100 2
        101 20
        110 21
        111 210
        */
      } else if (list[i].length == 3) {
        alleKombinationen.add(path + list[i][0].pfadID.toString());
        pathIDs.add([i, list[i][0].pfadID]);

        alleKombinationen.add(path + list[i][1].pfadID.toString());
        pathIDs.add([i, list[i][1].pfadID]);

        alleKombinationen
            .add(path + (list[i][0].pfadID + list[i][1].pfadID).toString());
        pathIDs.add([i, list[i][0].pfadID, list[i][1].pfadID]);

        alleKombinationen.add(path + list[i][2].pfadID.toString());
        pathIDs.add([i, list[i][2].pfadID]);

        alleKombinationen
            .add(path + (list[i][2].pfadID + list[i][0].pfadID).toString());
        pathIDs.add([i, list[i][2].pfadID, list[i][0].pfadID]);

        alleKombinationen
            .add(path + (list[i][2].pfadID + list[i][1].pfadID).toString());
        pathIDs.add([i, list[i][2].pfadID, list[i][1].pfadID]);

        alleKombinationen.add(path +
            (list[i][2].pfadID + list[i][1].pfadID + list[i][0].pfadID)
                .toString());
        pathIDs
            .add([i, list[i][2].pfadID, list[i][1].pfadID, list[i][0].pfadID]);
      }
    }

    for (var i = 0; i < alleKombinationen.length; i++) {
      alleKombinationen[i] += _suffixNeu;
    }

    // print(alleKombinationen);
    Map map = new Map.fromIterables(alleKombinationen, pathIDs);

    return map;
  }

/* Gibt alle auswahlbarenAvatare als Dateipfad zurück*/
  static Future<List<String>> getAuswaehlbareAvatarePath(int userid) async {
    List<String> pathStrings = new List();
    Map map = await getAuswaehlbareAvatare(userid);
    map.keys.forEach((k) => pathStrings.add(k));
    return pathStrings;
  }

/* Gibt alle auswaehlbaren Avatare als PfadIDs zurück */
  static Future<List<List<int>>> getAuswaehlbareAvatarePathIDs(
      int userid) async {
    List<List<int>> pathIDs = new List();
    Map map = await getAuswaehlbareAvatare(userid);
    map.values.forEach((k) => pathIDs.add(k));
    return pathIDs;
  }

/* Prüft ob ein SammelbaresObjekt ein basisAvatar ist */
  static bool istBasisAvatar(Sammelbares sam) {
    if (sam.kategorieID == 2) {
      return true;
    } else {
      return false;
    }
  }

/* Speichert eine Avatarauswahl für einen Benutzer in die Datenbank
*/
  static Future<bool> setAvatarFromPathIDs(
      int benutzerID, List<int> pathIDs) async {
    int basisID = pathIDs[0];

/*Wenn weniger als 3 Collectables erzeugt nachfolgener code Nullwerte für das phpScript
*/
    List<int> collectables = new List();
    int collectable1;
    int collectable2;
    int collectable3;
    collectables.add(collectable1);
    collectables.add(collectable2);
    collectables.add(collectable3);
    for (var i = 1; i < pathIDs.length; i++) {
      collectables[i - 1] = pathIDs[i];
    }
    //

    //colletables umrechnen
    collectables =
        await collectablesUmrechnenInSammelIDs(basisID, collectables);

    // ignore: unused_local_variable
    List<Freigeschaltet> freigeschalteteErrungenschaften =
        await getFreigeschalteteErrungenschaften(benutzerID);

    //Datenbank zugriff

    //DATENBANK UNREGELMÄßIGKEIT in Testdatenbank
    if (basisID == 0) {
      basisID = 4;
    } else if (basisID == 1) {
      basisID = 3;
    } else if (basisID == 2) {
      basisID = 6;
    } else if (basisID == 3) {
      basisID = 5;
    }

    String url = "http://zukunft.sportsocke522.de/updateFreigeschaltet.php";

    var data = {
      "benutzerID": benutzerID.toString(),
      "basisID": basisID.toString(),
      "collectable1": collectables[0].toString(),
      "collectable2": collectables[1].toString(),
      "collectable3": collectables[2].toString(),
    };
    final response = await http.post(url, body: data);
    final nachricht = jsonDecode(response.body);
    bool antwortErhalten = await nachricht == "Avatar erfolgreich geaendert";
    print("Fertig geladen");

    return antwortErhalten;
  }

/* Gibt für einen bestimmten Benutzer alle Freigeschalteten Errungenschaften wieder*/
  static Future<List<Freigeschaltet>> getFreigeschalteteErrungenschaften(
      int userID) async {
    List<Freigeschaltet> userFreigeschaltet = new List();
    List<Freigeschaltet> freigeschaltet =
        await Freigeschaltet.shared.gibObjekte();

    for (var i = 0; i < freigeschaltet.length; i++) {
      if (freigeschaltet[i].benutzerID == userID) {
        userFreigeschaltet.add(freigeschaltet[i]);
      }
    }
    return userFreigeschaltet;
  }

/* Gibt den richtigen pfad für den Basisavatar wieder*/
  // ignore: missing_return
  static String getBaseAvatar(baseID) {
    if (baseID == 0) {
      return "DerBlaue/";
    }
    //Gelb
    else if (baseID == 1) {
      return "DerGelbe/";
    }
    //Gruen
    else if (baseID == 2) {
      return "DerGruene/";
    }
    //Rot
    else if (baseID == 3) {
      return "DerRote/";
    }
  }

/* Rechnet übergebene SammelIDs mithilfe der übergebenen BasisID in die für die Datenbank lesbare PfadID um*/
  static Future<List<int>> collectablesUmrechnenInSammelIDs(
      int basisID, List<int> collectableIDs) async {
    List<Sammelbares> sammelbares = await Sammelbares.shared.gibObjekte();

    List<int> gruppe = new List();

    for (var j = 0; j < collectableIDs.length; j++) {
      {
        if (collectableIDs[j] == null) {
          gruppe.add(null);
        } else {
          for (var i = 0; i < sammelbares.length; i++) {
            if (sammelbares[i].basisID == basisID) {
              if (sammelbares[i].pfadID == collectableIDs[j]) {
                gruppe.add(sammelbares[i].id);
              }
            }
          }
        }
      }
    }
    return gruppe;
  }
}
