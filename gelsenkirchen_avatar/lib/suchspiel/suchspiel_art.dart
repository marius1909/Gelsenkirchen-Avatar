enum SuchspielArt { rotbuche, edelweiss, korkeiche }

extension SuchspielExtension on SuchspielArt {
  String get associatedStartphrase {
    switch (this) {
      case SuchspielArt.rotbuche:
        return "rotbuche";
      case SuchspielArt.edelweiss:
        return "edelweiß";
      case SuchspielArt.korkeiche:
        return "korkeiche";
      default:
        return null;
    }
  }

  static SuchspielArt fromAssociatedStartphrase(String associatedStartphrase) {
    switch (associatedStartphrase) {
      case "rotbuche":
        return SuchspielArt.rotbuche;
      case "edelweiß":
        return SuchspielArt.edelweiss;
      case "korkeiche":
        return SuchspielArt.korkeiche;
      default:
        return null;
    }
  }
}
