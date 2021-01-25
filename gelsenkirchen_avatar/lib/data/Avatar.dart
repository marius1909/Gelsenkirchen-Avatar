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

class Avatar {
  int avatarTypID;
  int collectableID;

//Assetpaths
  String _basePath = "assets/avatar/500px/";
  String _avatar;
  String _suffix = ".png";

  Avatar(int _avatarTypID, int _collectableID) {
    avatarTypID = _avatarTypID;
    collectableID = _collectableID;

//AvatarTypen

    //Blau
    if (avatarTypID == 0) {
      _avatar = "DerBlaue/";
    }
    //Gelb
    else if (avatarTypID == 1) {
      _avatar = "DerGelbe/";
    }
    //Gruen
    else if (avatarTypID == 2) {
      _avatar = "DerGruene/";
    }
    //Rot
    else if (avatarTypID == 3) {
      _avatar = "DerRote/";
    }
  }

  //Gibt den gesamten Pfad des Bildes zurueck (inklusive Collectable)
  String get imagePath {
    return _basePath + _avatar + collectableID.toString() + _suffix;
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
