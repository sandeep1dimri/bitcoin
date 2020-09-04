import 'package:flutter/material.dart';

void main() {
  runApp(BitCoinApp());
}

class BitCoinApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.lightBlue,
          scaffoldBackgroundColor: Colors.white),
      home: SafeArea(
        child: Container(
          width: 30,
          height: 60,
          child: Text("Bitcoin Price"),
        ),
      ),
    );
  }
}
