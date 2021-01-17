import 'package:flutter/material.dart';

class Ladescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: CircularProgressIndicator(),
    ));
  }
}
