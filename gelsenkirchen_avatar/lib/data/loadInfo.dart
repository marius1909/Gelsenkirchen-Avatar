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

  static Image loadAvatar(List<Benutzer> alleBenutzer) {
    return Image.asset(DerBlaue().imagePath, width: 250, height: 250);
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
  }

  static int loadErrungenschaften(List<Benutzer> alleBenutzer) {
    // var freigeschalteteErrungenschaften =
    //   await Freigeschaltet.shared.gibObjekte();

    //for (int i = 0; i < freigeschalteteErrungenschaften.length; i++) {}

    //DUMMY
    return 12;
  }
}
