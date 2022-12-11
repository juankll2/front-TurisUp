import 'package:flutter/material.dart';
import 'package:turismup/src/pages/inputs_page.dart';
import 'package:turismup/src/pages/getPlaces.dart';

class RoutePage extends StatefulWidget {
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
      body: CargarJson(),
      floatingActionButton: _CrearBoton(),
    );
  }

  Widget _CrearBoton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        const SizedBox(
          width: 30.0,
        ),
        FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                // MaterialPageRoute(builder: (context) => CrearRecursoPage()),
                MaterialPageRoute(builder: (context) => InputsPage()),
              );
            }),
        const SizedBox(
          width: 10.0,
        ),
      ],
    );
  }
}
