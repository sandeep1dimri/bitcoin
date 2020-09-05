import 'package:flutter/material.dart';
import 'price_screen.dart';

void main() {
  runApp(BitCoinApp());
}

class BitCoinApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
            primaryColor: Colors.lightBlue,
            scaffoldBackgroundColor: Colors.white),
        home: PriceScreen());
  }
}
