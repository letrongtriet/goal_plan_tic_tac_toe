import 'dart:async';
import 'package:flutter/material.dart';
import 'package:goal_plan_tic_tac_toe/ui/home_page.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

String title = "Welcome to Goalplan Tic-Tac-Toe";

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    new Future.delayed(
        const Duration(seconds: 2),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: 
        Text(
          "Welcome to Goalplan Tic-Tac-Toe",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        )
    ));
  }
}