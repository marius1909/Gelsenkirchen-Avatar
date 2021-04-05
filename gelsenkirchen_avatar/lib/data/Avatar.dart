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

  static String getDefaultImagePath() {
    return _basePathNeu + getBaseAvatar(0) + _suffixNeu;
  }

  static Future<String> getImagePath(int userID) async {
    List<Sammelbares> sammelbares = await Sammelbares.shared.gibObjekte();

    String baseAvatar = "";

    List<Freigeschaltet> freigeschalteteErrungenschaften =
        await LoadInfo.getFreigeschalteteErrungenschaften(userID);

    // print(userID);
    print(freigeschalteteErrungenschaften);

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

  static Future<List<String>> getAuswaehlbareAvatareList(int userid) async {
    List<String> auswaehlbareAvatare = new List();
    List<Sammelbares> sammelbares = await Sammelbares.shared.gibObjekte();

    List<Freigeschaltet> freigeschalteteErrungenschaften =
        await LoadInfo.getFreigeschalteteErrungenschaften(userid);

    for (var i = 0; i < freigeschalteteErrungenschaften.length; i++) {}

    return auswaehlbareAvatare;
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
