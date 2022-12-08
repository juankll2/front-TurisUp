import 'package:flutter/material.dart';
////
import 'package:turismup/src/pages/home_page.dart';
import 'package:turismup/src/providers/menu_providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TurismUp App',
        debugShowCheckedModeBanner: false,
        home: HomePage());
  }
}
