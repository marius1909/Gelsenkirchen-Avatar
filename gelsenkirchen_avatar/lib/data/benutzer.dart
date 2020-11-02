import 'package:flutter/material.dart';

class Benutzer {
  String id;
  String email;
  String benutzername;
  String passwort;
  String rolleID;

  Benutzer(
      {this.id, this.email, this.benutzername, this.passwort, this.rolleID});

  String gibBenutzername() {
    return this.benutzername;
  }
}
