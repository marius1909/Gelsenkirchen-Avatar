class DerBlaue {
  static final String _basePath = "assets/avatar/500px/";
  static final String _avatar = "DerBlaue/";
  static final String _suffix = ".png";
  int _imageIndex = 0;
  String get imagePath {
    return _basePath + _avatar + _imageIndex.toString() + _suffix;
  }

  DerBlaue({List<BlauesAccessoir> accessoires}) {
    if (accessoires != null) {
      _imageIndex = accessoires.fold(0, (previousValue, element) {
        return previousValue + element.accessoir;
      });
    }
  }
}

class DerGelbe {
  static final String _basePath = "assets/avatar/500px/";
  static final String _avatar = "DerGelbe/";
  static final String _suffix = ".png";
  int _imageIndex = 0;
  String get imagePath {
    return _basePath + _avatar + _imageIndex.toString() + _suffix;
  }

  DerGelbe({List<GelbesAccessoir> accessoires}) {
    if (accessoires != null) {
      _imageIndex = accessoires.fold(0, (previousValue, element) {
        return previousValue + element.accessoir;
      });
    }
  }
}

class DerGruene {
  static final String _basePath = "assets/avatar/500px/";
  static final String _avatar = "DerGruene/";
  static final String _suffix = ".png";
  int _imageIndex = 0;
  String get imagePath {
    return _basePath + _avatar + _imageIndex.toString() + _suffix;
  }

  DerGruene({List<GruenesAccessoir> accessoires}) {
    if (accessoires != null) {
      _imageIndex = accessoires.fold(0, (previousValue, element) {
        return previousValue + element.accessoir;
      });
    }
  }
}

class DerRote {
  static final String _basePath = "assets/avatar/500px/";
  static final String _avatar = "DerRote/";
  static final String _suffix = ".png";
  int _imageIndex = 0;
  String get imagePath {
    return _basePath + _avatar + _imageIndex.toString() + _suffix;
  }

  DerRote({List<RotesAccessoir> accessoires}) {
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
