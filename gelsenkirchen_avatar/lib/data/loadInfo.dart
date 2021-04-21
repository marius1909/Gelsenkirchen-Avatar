// ignore: camel_case_types
import 'package:flutter/material.dart';
import 'Avatar.dart';
import 'package:http/http.dart' as http;
import 'freigeschaltet.dart';
import 'package:http/http.dart';

class LoadInfo {
  /*static String loadName(List<Benutzer> alleBenutzer, int userID) {
    String name = alleBenutzer.firstWhere((benutzer) {
      return benutzer.id == userID;
    }).benutzer;

    return name;
  }*/

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

  static Future<Response> testAvatarAenderung() async {
    int benutzerID = 131;
    List<int> sammelIDs = new List();
    sammelIDs.add(3);
    sammelIDs.add(8);
    sammelIDs.add(9);

    int basisID = 5;

    String url = "http://zukunft.sportsocke522.de/updateFreigeschaltet.php";

    var data = {
      "benutzerID": benutzerID.toString(),
      "basisID": basisID.toString()
    };
    final response = await http.post(url, body: data);

    return response;
  }
}
