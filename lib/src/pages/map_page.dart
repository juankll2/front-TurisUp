import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turismup/src/pages/datos_places.dart';

import '../controller/mapController.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final _controller = MapController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_controller.obtenerDatos();
    _controller.addListener(() {
      setState(() {});
    });
    // _controller.cargarMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapas'),
      ),
      // body: Mapa(),
      body: Center(
          child: FutureBuilder<List<Datos_Place>>(
        future: _controller.placesFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final places = snapshot.data!;
            return crearMapa();
          } else {
            return const Text('Cargando datos');
          }
        },
      )),
    );
  }

  Widget crearMapa() {
    return GoogleMap(
      // markers: _controller.markersJson,
      markers: Set.of(_controller.jsonMarkers.values),
      onMapCreated: _controller.onMapCreated,
      initialCameraPosition: _controller.initialCameraPosition,
      myLocationEnabled: false,
      zoomControlsEnabled: false,
      mapType: MapType.normal,
      // onTap: _controller.onTap
    );
  }
}
