import 'package:flutter/material.dart';
import 'package:turismup/src/pages/inputs_page.dart';
import 'package:turismup/src/pages/getPlaces.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({super.key});

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  //const RoutePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recursos'),
      ),
      body: Center(child: Text('Pagina de rutas')),
    );
  }

  // ignore: non_constant_identifier_names

}
