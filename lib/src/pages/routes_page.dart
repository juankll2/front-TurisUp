import 'package:flutter/material.dart';
import 'package:turismup/src/pages/mapRoutes_page.dart';
import 'package:turismup/src/pages/places_routes.dart';

import '../controller/rutasController.dart';
import 'mapOffline_page.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({super.key});

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  final controller = RutasController();
  Map<int, List<double>> rutas = {
    2: [-79.2406654584792, -2.7773300757122845],
    0: [-79.231095209251, -2.7786369457571896],
    1: [-79.2238729252344, -2.7810314375778487]
  };
  // Map<int, List> rutas = controller.devolverRutas();

  @override
  void initState() {
    // TODO: implement initState
    const CargarJsonPlaces();
    super.initState();
  }

  //const RoutePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rutas'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 80,
            child: Center(child: Text('Boton para crear rutas')),
          ),
          Expanded(child: CargarJsonPlaces()),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        // mainAxisSize: MainAxisSize.max,
        children: [botonCrearRuta(), botonMapaOffline()],
      ),
    );
  }

  Widget botonCrearRuta() {
    return GestureDetector(
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          const SizedBox(
            width: 30.0,
          ),
          FloatingActionButton(
              heroTag: "btn1",
              child: const Icon(Icons.create_outlined),
              onPressed: () {
                setState(() {
                  // print('------------routes_page----------------');
                  // print(controller.lugares);
                  Navigator.push(
                    context,
                    // MaterialPageRoute(builder: (context) => CrearRecursoPage()),
                    MaterialPageRoute(
                        builder: (context) =>
                            // MapRoutesPage(rutas: controller.devolverRutas())),
                            MapRoutesPage(rutas: rutas)),
                  );
                });
              }),
          const SizedBox(
            width: 10.0,
          )
        ],
      ),
    );
  }

  Widget botonMapaOffline() {
    return GestureDetector(
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          const SizedBox(
            width: 30.0,
          ),
          FloatingActionButton(
              heroTag: "btn2",
              child: const Icon(Icons.map_outlined),
              onPressed: () {
                setState(() {
                  // print('------------routes_page----------------');
                  // print(controller.lugares);
                  Navigator.push(
                      context,
                      // MaterialPageRoute(builder: (context) => CrearRecursoPage()),
                      MaterialPageRoute(
                        builder: (context) => const MapsOffline(),
                      ));
                });
              }),
          const SizedBox(
            width: 10.0,
          )
        ],
      ),
    );
  }
}
