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
  late GoogleMapController googleMapController;
  // static CameraPosition initalCameraPosition = CameraPosition(target: LatLng);

  final _controller = MapController();

  @override
  void initState() {
    // TODO: implement initState
    //cargarRuta();
    _controller.getCurrentLocation();
    //_controller.obtenerDatos();
    _controller.addListener(() {
      setState(() {});
    });
    super.initState();

    // _controller.cargarMarkers();
    // _controller.posicionActual();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapas'),
      ),
      body: Center(
          child: FutureBuilder<List<Datos_Place>>(
        future: _controller.placesFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData && _controller.currentLocation != null) {
            final places = snapshot.data!;
            return crearMapa();
          } else {
            return const Center(child: Text('Cargando datos'));
          }
        },
      )),
      floatingActionButton: _controller.botonCamino(),
    );
  }

  void changeLocation() {
    setState(() {
      _controller.getCurrentLocation();
    });
  }

  Widget crearMapa() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
          target: LatLng(_controller.currentLocation!.latitude!,
              _controller.currentLocation!.longitude!),
          zoom: 16),
      markers: Set.of(_controller.jsonMarkers.values),
      polylines: {
        Polyline(
          polylineId: PolylineId("ruta 1"),
          points: _controller.polylineCoordinates,
          color: Colors.blue[400]!,
          width: 10,
        ),
      },
      onMapCreated: (mapController) {
        _controller.onMapCreated(mapController);
      },
      myLocationEnabled: false,
      zoomControlsEnabled: false,
      mapType: MapType.normal,
      // onTap: _controller.onTap
    );
  }
}
