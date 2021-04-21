/* 
Klasse Avatar

Erstellt einen Avatar mit angebenen Typ und angebenen Collectable

avatarTypId: Der (Farb)Typ des Avatars. Blau = 0, Gruen = 1, Gelb = 2, Rot = 3
collectableId: Das ausgerüstete Collectable das angezeigt werden soll

Assetpaths: Erstellt den Dateipfad zum richtigem Avatarbild

Um einen neuen Avatar zu implementieren muss eine weiteres "else if" unter "AvatarTypen" eingefügt:

 else if (avatarTypID == "i") {
      _avatar = "TYP/";
    }

AvatarImage kann über Image.asset(Avatar(i,j).imagePath) geladen werden
Um einen Avatar für einen bestimmen Benutzer zu laden bitte die loadAvatarImage in loadInfo.dart benutzen.

*/
import 'package:gelsenkirchen_avatar/data/freigeschaltet.dart';
import 'package:gelsenkirchen_avatar/data/loadInfo.dart';
import 'package:gelsenkirchen_avatar/data/sammelbares.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Avatar {
  int avatarTypID;
  int collectableID;

//Assetpaths
  String _basePath = "assets/avatar/500px/";
  String _suffix = ".png";

  static String _basePathNeu = "assets/avatar/500px/";
  static String _suffixNeu = ".png";

  Avatar(int _avatarTypID, int _collectableID) {
    collectableID = _collectableID;
    avatarTypID = _avatarTypID;
  }

  String get imagePath {
    return _basePath +
        getBaseAvatarAlt(avatarTypID) +
        collectableID.toString() +
        _suffix;
  }

  static String getDefaultImagePath(int baseID) {
    return _basePathNeu + getBaseAvatar(baseID) + "0" + _suffixNeu;
  }

  static Future<String> getImagePath(int userID) async {
    List<Sammelbares> sammelbares = await Sammelbares.shared.gibObjekte();

    String baseAvatar = "";

    List<Freigeschaltet> freigeschalteteErrungenschaften =
        await LoadInfo.getFreigeschalteteErrungenschaften(userID);

    // print(userID);
    //  print(freigeschalteteErrungenschaften);

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

    return _basePathNeu + baseAvatar + pfadID.toString() + _suffixNeu;
  }

  static Future<List<String>> getAlleErrungenschaftenPath(int userid) async {
    String path;
    List<String> alleErrungenschaften = new List();
    List<Sammelbares> sammelbares = await Sammelbares.shared.gibObjekte();

    List<Freigeschaltet> freigeschalteteErrungenschaften =
        await LoadInfo.getFreigeschalteteErrungenschaften(userid);

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
    // print(alleErrungenschaften);
    return alleErrungenschaften;
  }

  static Future<Map> getAuswaehlbareAvatare(int userid) async {
    List<Sammelbares> sammelbares = await Sammelbares.shared.gibObjekte();
    List<Freigeschaltet> freigeschalteteErrungenschaften =
        await LoadInfo.getFreigeschalteteErrungenschaften(userid);

    List<Sammelbares> Blau = new List();
    List<Sammelbares> Gelb = new List();
    List<Sammelbares> Gruen = new List();
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

  static Future<List<String>> getAuswaehlbareAvatarePath(int userid) async {
    List<String> pathStrings = new List();
    Map map = await getAuswaehlbareAvatare(userid);
    map.keys.forEach((k) => pathStrings.add(k));
    return pathStrings;
  }

  static Future<List<List<int>>> getAuswaehlbareAvatarePathIDs(
      int userid) async {
    List<List<int>> pathIDs = new List();
    Map map = await getAuswaehlbareAvatare(userid);
    map.values.forEach((k) => pathIDs.add(k));
    return pathIDs;
  }

  static bool istBasisAvatar(Sammelbares sam) {
    if (sam.kategorieID == 2) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getImagePathAlt(int userID) async {
    List<Sammelbares> sammelbares = await Sammelbares.shared.gibObjekte();

    String baseAvatar = "";

    List<Freigeschaltet> freigeschalteteErrungenschaften =
        await LoadInfo.getFreigeschalteteErrungenschaften(userID);

    // print(userID);
    //print(freigeschalteteErrungenschaften);

    List<Sammelbares> ausgeruesteteErrungenschaften = new List();
    int pfadID = 0;

    for (var i = 0; i < freigeschalteteErrungenschaften.length; i++) {
      if (freigeschalteteErrungenschaften[i].ausgeruestet) {
        for (var j = 0; j < sammelbares.length; j++) {
          if (sammelbares[j].id ==
              freigeschalteteErrungenschaften[i].sammelID) {
            if (sammelbares[j].kategorieID == 2) {
              baseAvatar = getBaseAvatarAlt(sammelbares[j].pfadID);
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

    return _basePath + baseAvatar + pfadID.toString() + _suffix;
  }

  static Future<Response> setAvatarFromPathIDs(
      int benutzerID, List<int> pathIDs) async {
    int basisID = pathIDs[0];

    //DATENBANK UNREGELMÄßIGKEIT
    if (basisID == 0) {
      basisID = 4;
    } else if (basisID == 1) {
      basisID = 3;
    } else if (basisID == 2) {
      basisID = 6;
    } else if (basisID == 3) {
      basisID = 5;
    }

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
      collectables[i] = pathIDs[i];
    }

//Consolenprints zum Testen
    List<Freigeschaltet> freigeschalteteErrungenschaften =
        await LoadInfo.getFreigeschalteteErrungenschaften(benutzerID);
    print("\n");
    print("_______________");
    print("\n");

    print("Errungenschaften vor DatenbankUpdate\n" +
        freigeschalteteErrungenschaften.toString());

    print("Für den Benutzer(ID) " +
        benutzerID.toString() +
        " sollen folgende sammelIDs ausgerüstet werden: \nBasisID:" +
        basisID.toString() +
        "\nCollectables:" +
        collectables.toString());
    print("\nUm zu überprüfen -> nochmal Avatar auswählen");

//Datenbank zugriff

    String url = "http://zukunft.sportsocke522.de/updateFreigeschaltet.php";

    var data = {
      "benutzerID": benutzerID.toString(),
      "basisID": basisID.toString(),
      "collectable1": collectables[0].toString(),
      "collectable2": collectables[1].toString(),
      "collectable3": collectables[2].toString(),
    };
    final response = await http.post(url, body: data);

    return response;
  }

  // ignore: missing_return
  String getBaseAvatarAlt(baseID) {
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
}
