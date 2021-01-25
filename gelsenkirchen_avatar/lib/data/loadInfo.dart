// ignore: camel_case_types
import 'dart:convert';

import 'package:flutter/material.dart';

import 'Avatar.dart';
import 'benutzer.dart';
import 'package:http/http.dart' as http;

import 'freigeschaltet.dart';

class loadInfo {
  static String loadName(List<Benutzer> alleBenutzer, int id_user) {
    String name = alleBenutzer.firstWhere((benutzer) {
      return benutzer.id == id_user;
    }).benutzer;

    return name;
  }

//TODO: Avatar klasse muss verbessert werden damit das hier besser gemacht werden kann!
  static Image loadUserAvatarImage(
      int userid, int avatarTypID, int ausgeruesteteCollectableID) {
    return Image.asset(
        Avatar(avatarTypID, ausgeruesteteCollectableID).imagePath,
        width: 250,
        height: 250);

    //return Image.asset("assets/images/profilbild.jpg", width: 250, height: 250);
  }

  static Future<int> loadUserLevel(int user_id) async {
    var url = "http://zukunft.sportsocke522.de/user_score_level.php?id=" +
        user_id.toString();
    var res = await http.get(url);
    if (jsonDecode(res.body) == "Datensatz existiert nicht") {
      print('Datensatz nicht gefunden');
    } else {
      return jsonDecode(res.body)['level'];
    }

    return null;
  }

/* Geht alle Freigeschalteten Errungenschaften durch und gibt eine Liste wieder mit Errungenschaften die vom angegebenen Benutzer freigeschaltet wurden*/

  static List<Freigeschaltet> getFreigeschalteteErrungenschaften(int userID) {
    List<Freigeschaltet> freigeschaltet = new List();

    Freigeschaltet.shared.gibObjekte().then((alleErrungenschaften) {
      for (var i = 0; i < alleErrungenschaften.length; i++) {
        if (alleErrungenschaften[i].benutzerID == userID) {
          freigeschaltet.add(alleErrungenschaften[i]);
        }
      }
    });

    return freigeschaltet;
  }

  static List<Avatar> loadAlleAvatare() {
    List<Avatar> avatare = new List();

    for (var i = 0; i < 4; i++) {
      for (var j = 0; j < 8; j++) {
        avatare.add(new Avatar(i, j));
      }
    }
    return avatare;
  }
}
