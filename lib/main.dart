import 'package:flutter/material.dart';
import 'package:bitcoin_ticker_app/price_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.lightBlue,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const PriceScreen(),
    );
  }
}
