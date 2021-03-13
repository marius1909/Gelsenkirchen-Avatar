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

import 'package:flutter_icons/flutter_icons.dart';
import 'package:gelsenkirchen_avatar/data/freigeschaltet.dart';
import 'package:gelsenkirchen_avatar/data/loadInfo.dart';
import 'package:gelsenkirchen_avatar/data/sammelbares.dart';
import 'package:http/http.dart';

class Avatar {
  int avatarTypID;
  int collectableID;

//Assetpaths
  String _basePath = "assets/avatar/500px/";
  String _avatar;
  String _suffix = ".png";

  Avatar(int _avatarTypID, int _collectableID) {
    collectableID = _collectableID;
    avatarTypID = _avatarTypID;
  }

  String get imagePath {
    return _basePath +
        getBaseAvatar(avatarTypID) +
        collectableID.toString() +
        _suffix;
  }

  Future<String> getImagePath(int userID) async {
    List<Sammelbares> sammelbares = await Sammelbares.shared.gibObjekte();
    List<Freigeschaltet> freigeschalteteErrungenschaften =
        LoadInfo.getFreigeschalteteErrungenschaften(userID);
    List<Sammelbares> ausgeruesteteErrungenschaften = new List();
    int pfadID = 0;

    for (var i = 0; i < freigeschalteteErrungenschaften.length; i++) {
      print(i);

      if (freigeschalteteErrungenschaften[i].ausgeruestet) {
        for (var j = 0; j < sammelbares.length; j++) {
          if (sammelbares[j].id ==
              freigeschalteteErrungenschaften[i].sammelID) {
            //wenn basisavatar ausgerüstet ist finde raus welcher und gib direkt pfad zurück
            if (sammelbares[j].kategorieID == 2) {
              return _basePath + getBaseAvatar(sammelbares[i].pfadID) + _suffix;
            } else {
              ausgeruesteteErrungenschaften.add(sammelbares[j]);
            }
          }
        }
      }

      for (var i = 0; i < ausgeruesteteErrungenschaften.length; i++) {
        pfadID += ausgeruesteteErrungenschaften[i].pfadID;
      }
    }

    return _basePath + pfadID.toString() + _suffix;
  }

  Future<String> pfadIDBasisAvatar(int sammelID) async {
    List<Sammelbares> sammelbares = await getSammelbares();
    for (var i = 0; i < sammelbares.length; i++) {
      return _basePath + getBaseAvatar(sammelbares[i].pfadID) + _suffix;
    }
  }

  @override
  String toString() {
    return "AvatarTyp= " +
        _avatar +
        " CollectableID= " +
        collectableID.toString();
  }

//_____________________________unused
  Avatar.withAccessoir({List<BlauesAccessoir> accessoires}) {
    if (accessoires != null) {
      collectableID = accessoires.fold(0, (previousValue, element) {
        return previousValue + element.accessoir;
      });
    }
  }

  Future<List<Sammelbares>> getSammelbares() async {
    print("sasd");
    List<Sammelbares> a = await Sammelbares.shared.gibObjekte();
    print(a);

    return a;
  }

  String getBaseAvatar(baseID) {
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

class BlauesAccessoir {
  final int accessoir;
  BlauesAccessoir._(this.accessoir);
  static final BlauesAccessoir pinkesHaar = BlauesAccessoir._(1);
  static final BlauesAccessoir schnurrbart = BlauesAccessoir._(2);
  static final BlauesAccessoir lilaSchuhe = BlauesAccessoir._(4);
}

class GelbesAccessoir {
  final int accessoir;
  GelbesAccessoir._(this.accessoir);
  static final GelbesAccessoir gestreifteHoerner = GelbesAccessoir._(1);
  static final GelbesAccessoir krawatte = GelbesAccessoir._(2);
  static final GelbesAccessoir zauberstab = GelbesAccessoir._(4);
}

class GruenesAccessoir {
  final int accessoir;
  GruenesAccessoir._(this.accessoir);
  static final GruenesAccessoir schnurrbart = GruenesAccessoir._(1);
  static final GruenesAccessoir hut = GruenesAccessoir._(2);
  static final GruenesAccessoir blaueSchuhe = GruenesAccessoir._(4);
}

class RotesAccessoir {
  final int accessoir;
  RotesAccessoir._(this.accessoir);
  static final RotesAccessoir monokel = RotesAccessoir._(1);
  static final RotesAccessoir kappe = RotesAccessoir._(2);
  static final RotesAccessoir blaueShorts = RotesAccessoir._(4);
}
