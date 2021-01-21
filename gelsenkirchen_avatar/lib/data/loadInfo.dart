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
  static Image loadAvatar(
      int userid, int avatarTypID, int ausgeruesteteCollectablesID) {
    if (avatarTypID == 0) {
      return Image.asset(DerBlaue(avatarTypID).imagePath,
          width: 250, height: 250);
    } else if (avatarTypID == 1) {
      return Image.asset(DerGelbe(avatarTypID).imagePath,
          width: 250, height: 250);
    } else if (avatarTypID == 2) {
      return Image.asset(DerGruene(avatarTypID).imagePath,
          width: 250, height: 250);
    } else if (avatarTypID == 3) {
      return Image.asset(DerRote(avatarTypID).imagePath,
          width: 250, height: 250);
    }
    return null;
    //Error
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

  static List<List<Avatar>> loadAlleAvatare() {
    List<List<Avatar>> avatare = new List();

    List<Avatar> blau = new List();
    List<Avatar> gelb = new List();
    List<Avatar> gruen = new List();
    List<Avatar> rot = new List();

    for (var i = 0; i < 8; i++) {
      blau.add(new DerBlaue(i));
      gelb.add(new DerGelbe(i));
      gruen.add(new DerGruene(i));
      rot.add(new DerRote(i));
    }

    avatare.add(blau);
    avatare.add(gelb);
    avatare.add(gruen);
    avatare.add(rot);
    return avatare;
  }
}
