import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:turismup/src/pages/home_page.dart';
import 'package:turismup/src/pages/inputs_page.dart';
import 'package:turismup/src/pages/mapRoutes_page.dart';
import 'package:turismup/src/pages/map_page.dart';
////

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    () async {
      final Directory docDir = await getApplicationDocumentsDirectory();
      final String localPath = docDir.path;
      File file = File('$localPath/${'assets/ecuador.map'.split('/').last}');
      if (!file.existsSync()) {
        final imageBytes = await rootBundle.load('assets/ecuador.map');
        final buffer = imageBytes.buffer;
        await file.writeAsBytes(buffer.asUint8List(
            imageBytes.offsetInBytes, imageBytes.lengthInBytes));
      }
    }();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      title: 'TurismUp App',
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      // home: HomePage());
      routes: {
        '/': (context) => const HomePage(),
        '/addPlace': (context) => const InputsPage(),
        // '/mapa': (context) => MapPage(),
        // '/mapaRutas': (context) => const MapRoutesPage(),
      },
    );
  }
}
