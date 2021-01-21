/* 
_typIndex = 0= DerBlaue 1= Der Gelbe usw
_imageIndex = Collectable anpassung

*/

abstract class Avatar {
  int _typIndex;
  int _imageIndex;

  String get imagePath {
    return "";
  }

  int get imageIndex {
    return _imageIndex;
  }
}

class DerBlaue extends Avatar {
  static final String _basePath = "assets/avatar/500px/";
  static final String _avatar = "DerBlaue/";
  static final String _suffix = ".png";

  @override
  String get imagePath {
    return _basePath + _avatar + _imageIndex.toString() + _suffix;
  }

  DerBlaue(int imageIndex) {
    _imageIndex = imageIndex;
    _typIndex = 0;
  }

  DerBlaue.withAccessoir({List<BlauesAccessoir> accessoires}) {
    if (accessoires != null) {
      _imageIndex = accessoires.fold(0, (previousValue, element) {
        return previousValue + element.accessoir;
      });
    }
  }
}

class DerGelbe extends Avatar {
  static final String _basePath = "assets/avatar/500px/";
  static final String _avatar = "DerGelbe/";
  static final String _suffix = ".png";
  int _imageIndex = 0;
  String get imagePath {
    return _basePath + _avatar + _imageIndex.toString() + _suffix;
  }

  DerGelbe(int imageIndex) {
    _imageIndex = imageIndex;
    _typIndex = 1;
  }

  DerGelbe.mitAccessoir({List<GelbesAccessoir> accessoires}) {
    if (accessoires != null) {
      _imageIndex = accessoires.fold(0, (previousValue, element) {
        return previousValue + element.accessoir;
      });
    }
  }
}

class DerGruene extends Avatar {
  static final String _basePath = "assets/avatar/500px/";
  static final String _avatar = "DerGruene/";
  static final String _suffix = ".png";
  int _imageIndex = 0;
  String get imagePath {
    return _basePath + _avatar + _imageIndex.toString() + _suffix;
  }

  DerGruene(int imageIndex) {
    _imageIndex = imageIndex;
    _typIndex = 2;
  }

  DerGruene.mitAccessoir({List<GruenesAccessoir> accessoires}) {
    if (accessoires != null) {
      _imageIndex = accessoires.fold(0, (previousValue, element) {
        return previousValue + element.accessoir;
      });
    }
  }
}

class DerRote extends Avatar {
  static final String _basePath = "assets/avatar/500px/";
  static final String _avatar = "DerRote/";
  static final String _suffix = ".png";
  int _imageIndex = 0;
  String get imagePath {
    return _basePath + _avatar + _imageIndex.toString() + _suffix;
  }

  DerRote(int imageIndex) {
    _imageIndex = imageIndex;
    _typIndex = 3;
  }

  DerRote.mitAccesoir({List<RotesAccessoir> accessoires}) {
    if (accessoires != null) {
      _imageIndex = accessoires.fold(0, (previousValue, element) {
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
