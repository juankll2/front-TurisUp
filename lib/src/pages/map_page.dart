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

    super.initState();
    _controller.getCurrentLocation();
    _controller.addListener(() {
      setState(() {});
    });

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
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            // final places = snapshot.data!;
            return crearMapa();
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return const CircularProgressIndicator();
            //return const Center(child: Text('Cargando datos'));
          }
        },
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        // mainAxisSize: MainAxisSize.max,
        children: [
          botonCamino(),
          botonEliminarCamino(),
        ],
      ),
    );
  }

  Widget botonCamino() {
    return GestureDetector(
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          const SizedBox(
            width: 30.0,
          ),
          FloatingActionButton(
              child: const Icon(Icons.navigation_outlined),
              onPressed: () {
                setState(() {
                  _controller.getPolyPoints();
                });
              }),
          const SizedBox(
            width: 10.0,
          )
        ],
      ),
    );
  }

  Widget botonEliminarCamino() {
    return GestureDetector(
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          const SizedBox(
            width: 30.0,
          ),
          FloatingActionButton(
              child: const Icon(Icons.delete_forever_outlined),
              onPressed: () {
                setState(() {
                  _controller.resetearPolyPoints();
                });
              }),
          const SizedBox(
            width: 10.0,
          )
        ],
      ),
    );
  }

  Widget crearMapa() {
    return GoogleMap(
      onMapCreated: (mapController) {
        _controller.onMapCreated(mapController);
      },
      // initialCameraPosition: CameraPosition(
      //     target: LatLng(_controller.currentLocation!.latitude!,
      //         _controller.currentLocation!.longitude!),
      //     zoom: 16),
      initialCameraPosition:
          CameraPosition(target: LatLng(-2.899224, -79.010808), zoom: 10),
      markers: Set.of(_controller.jsonMarkers.values),
      polylines: {
        Polyline(
          polylineId: PolylineId("ruta 1"),
          points: _controller.polylineCoordinates,
          color: Colors.blue[400]!,
          width: 10,
        ),
      },

      myLocationEnabled: true,
      // myLocationButtonEnabled: true,
      zoomControlsEnabled: false,
      mapType: MapType.normal,
      // onTap: _controller.onTap
    );
  }
}
