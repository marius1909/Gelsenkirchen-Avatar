// ignore: camel_case_types
import 'dart:convert';
import 'package:flutter/material.dart';
import 'Avatar.dart';
import 'benutzer.dart';
import 'package:http/http.dart' as http;
import 'freigeschaltet.dart';

class LoadInfo {
  static String loadName(List<Benutzer> alleBenutzer, int userID) {
    String name = alleBenutzer.firstWhere((benutzer) {
      return benutzer.id == userID;
    }).benutzer;

    return name;
  }

//NEUE FUNKTION

  static Future<Image> loadUserAvatarImageNeu(int userid) async {
    String imagePath = await Avatar.getImagePath(userid);

    return Image.asset(imagePath, width: 250, height: 250);
  }

//ALT
//TODo: Avatar klasse muss verbessert werden damit das hier besser gemacht werden kann! (nicht bis S&T machbar)
  static Image loadUserAvatarImage(
      int userid, int avatarTypID, int ausgeruesteteCollectableID) {
    return Image.asset(
        Avatar(avatarTypID, ausgeruesteteCollectableID).imagePath,
        width: 250,
        height: 250);

    //return Image.asset("assets/images/profilbild.jpg", width: 250, height: 250);
  }

//TODO:existiert nur temporär um richtige größe für homescreen zu laden
  static Image loadUserAvatarImage2(
      int userid, int avatarTypID, int ausgeruesteteCollectableID) {
    return Image.asset(
        Avatar(avatarTypID, ausgeruesteteCollectableID).imagePath,
        width: 100,
        height: 100);

    //return Image.asset("assets/images/profilbild.jpg", width: 250, height: 250);
  }

  static Future<int> loadUserLevel(int userID) async {
    var url = "http://zukunft.sportsocke522.de/user_score_level.php?id=" +
        userID.toString();
    var res = await http.get(url);
    if (jsonDecode(res.body) == "Datensatz existiert nicht") {
      print('Datensatz nicht gefunden');
    } else {
      return jsonDecode(res.body)['level'];
    }

    return null;
  }

/* Geht alle Freigeschalteten Errungenschaften durch und gibt eine Liste wieder mit Errungenschaften die vom angegebenen Benutzer freigeschaltet wurden*/

  static Future<List<Freigeschaltet>> getFreigeschalteteErrungenschaften(
      int userID) async {
    List<Freigeschaltet> userFreigeschaltet = new List();
    List<Freigeschaltet> freigeschaltet =
        await Freigeschaltet.shared.gibObjekte();

    for (var i = 0; i < freigeschaltet.length; i++) {
      if (freigeschaltet[i].benutzerID == userID) {
        userFreigeschaltet.add(freigeschaltet[i]);
      }
    }
    return userFreigeschaltet;
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
