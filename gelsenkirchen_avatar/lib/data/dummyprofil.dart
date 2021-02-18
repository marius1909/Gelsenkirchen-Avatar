class dummyprofil {
  static int _avatarBaseID = 0;
  static List<freigeschaltet> _freigeschaltetList = [
    freigeschaltet(0, 7, 1, false),
    freigeschaltet(0, 8, 2, false),
    freigeschaltet(0, 9, 4, false),
    freigeschaltet(1, 10, 1, false),
    freigeschaltet(1, 11, 2, false),
    freigeschaltet(2, 13, 1, false),
  ];

  static List<freigeschaltet> get freigeschalteCollectables {
    return _freigeschaltetList;
  }

  static int get avatarBaseID {
    return _avatarBaseID;
  }

  static int berechneCollectablesID() {
    int id = 0;

    for (var i = 0; i < _freigeschaltetList.length; i++) {
      if (_freigeschaltetList[i].ausgeruestet) {
        id += _freigeschaltetList[i].calcID;
      }
    }

    return id;
  }

  static void setAvatar(int baseID, List<int> frei) {
    _avatarBaseID = baseID;

    for (var i = 0; i < _freigeschaltetList.length; i++) {
      _freigeschaltetList[i].ausgeruestet = false;
    }
    for (var i = 0; i < _freigeschaltetList.length; i++) {
      for (var j = 0; j < frei.length; j++) {
        if (_freigeschaltetList[i].baseAvatarTyp == baseID &&
            _freigeschaltetList[i].calcID == frei[j]) {
          _freigeschaltetList[i].ausgeruestet = true;
        }
      }
    }
  }
}

class freigeschaltet {
  int baseAvatarTyp;
  int sammelID;
  int calcID;
  bool ausgeruestet;

  freigeschaltet(
      int baseAvatarTypx, int sammelIDx, int calcIDx, bool ausgeruestetx) {
    baseAvatarTyp = baseAvatarTypx;
    sammelID = sammelIDx;
    calcID = calcIDx;
    ausgeruestet = ausgeruestetx;
  }
}
