import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:gelsenkirchen_avatar/screens/Lernort_vorschau_screen.dart';
>>>>>>> scoreboard
import 'package:gelsenkirchen_avatar/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gelsenkirchen Avatar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
