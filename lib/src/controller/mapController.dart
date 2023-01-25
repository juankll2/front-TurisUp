import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' show ChangeNotifier;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turismup/src/controller/image_to_bytes.dart';
import 'package:turismup/src/utils/map_style.dart';
import 'package:turismup/src/pages/datos_places.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

class MapController extends ChangeNotifier {
  Map<MarkerId, Marker> jsonMarkers = Map();
  static List<Datos_Place> registros = <Datos_Place>[];
  Future<List<Datos_Place>> placesFuture = getDatos();

///////////////////////////////
  ///datos para trabajar en local
  // Map<MarkerId, Marker> markers = Map();
  //Set<Marker> get markers => markers.values.toSet();
//////////////////////////////
  ///
  final Completer<GoogleMapController> ctrl = Completer();
  // static const LatLng start = LatLng(-2.899269, -79.010882);
  // static const LatLng end = LatLng(-2.891116, -79.036752);
  // ignore: non_constant_identifier_names
  String google_api_key = "AIzaSyD9m7bZ0SieFUTH7PdJakPdV2cZwIkbXFo";
  List<LatLng> polylineCoordinates = [];
  double latitud = 0.0;
  double longitud = 0.0;

  void onMapCreated(GoogleMapController controller) async {
    cargarMarkers();
    controller.setMapStyle(mapStyle);
  }

  static Future<List<Datos_Place>> getDatos() async {
    const url = 'http://192.168.1.4:8083/api/recurso/todos';
    final response = await http.get(Uri.parse(url));
    var datos = json.decode(utf8.decode(response.bodyBytes));
    for (var i = 0; i < datos.length; i++) {
      registros.add(Datos_Place.formJson(datos[i]));
    }
    return datos.map<Datos_Place>(Datos_Place.formJson).toList();
  }

  void cargarMarkers() async {
    for (var i = 0; i < registros.length; i++) {
      final id = MarkerId((registros[i].id).toString());
      // final icon = await imageToBytes(registros[i].imagenesPaths[0]);
      final icon = await imageToBytes(
          'https://static.vecteezy.com/system/resources/previews/005/337/799/non_2x/icon-image-not-found-free-vector.jpg');
      final marker = Marker(
          markerId: id,
          onDrag: null,
          onDragStart: null,
          icon: icon,
          onTap: () {
            latitud = registros[i].coordenadas['longitud'];
            longitud = registros[i].coordenadas['latitud'];
            // print('$latitud');
            // print('$longitud');
          },
          infoWindow: InfoWindow(title: (registros[i].nombre).toString()),
          position: LatLng(registros[i].coordenadas['longitud'],
              registros[i].coordenadas['latitud']));
      jsonMarkers[id] = marker;
    }
    notifyListeners();
  }

//
  //  Funcion Original
//
  // void getPolyPoints() async {
  //   PolylinePoints polylinePoints = PolylinePoints();
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //       google_api_key,
  //       PointLatLng(currentLocation!.latitude!, currentLocation!.longitude!),
  //       PointLatLng(end.latitude, end.longitude));
  //   if (result.points.isNotEmpty) {
  //     result.points.forEach((PointLatLng point) =>
  //         polylineCoordinates.add(LatLng(point.latitude, point.longitude)));
  //   }
  // }

  void resetearPolyPoints() {
    polylineCoordinates = [];
  }

  void getPolyPoints() async {
    polylineCoordinates = [];
    Position posact = await _determinarPosicion();
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        google_api_key,
        PointLatLng(posact.latitude, posact.longitude),
        PointLatLng(latitud, longitud));
    if (result.points.isNotEmpty) {
      // ignore: avoid_function_literals_in_foreach_calls
      result.points.forEach((PointLatLng point) =>
          polylineCoordinates.add(LatLng(point.latitude, point.longitude)));
    }
    notifyListeners();
  }

  ///
  //// localizicion en el mapa
  ///
  LocationData? currentLocation;

  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then((location) {
      currentLocation = location;
    });
    // cargarMarkers();
    posicionActual();
    print('++++++++++++++++++++++++++++++');
    print(jsonMarkers);
    // GoogleMapController googleMapController = await ctrl.future;
    /*location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              zoom: 16, target: LatLng(newLoc.latitude!, newLoc.longitude!))));
    });*/
  }

  void posicionActual() async {
    // ignore: unrelated_type_equality_checks
    if (Geolocator.isLocationServiceEnabled() != false) {
      Position posact = await _determinarPosicion();
      String url =
          'https://scontent.fgye1-2.fna.fbcdn.net/v/t39.30808-6/279907136_298467455807126_8672320356479345253_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeG6f3alqMqFxb5UqOCuT2buGMt2QRvft6IYy3ZBG9-3ovsEEloXdi5U78cAI9sZKzPF5P67D8cvfcpifpL_zr2u&_nc_ohc=B4EInw8U6yEAX8xOCdN&_nc_ht=scontent.fgye1-2.fna&oh=00_AfBtUG8xPG0tSyIFjDz7GnvwM93K5zjibtYdq_0NNNrZaQ&oe=63C3997A';
      var id1 = MarkerId("currentLocation");
      var marker1 = Marker(
          markerId: const MarkerId("currentLocation"),
          icon: await imageToBytes(url),
          position: LatLng(posact.latitude, posact.longitude),
          infoWindow: const InfoWindow(title: 'ubicacion actual'));
      jsonMarkers[id1] = marker1;
    }
    notifyListeners();
  }
//////
  /// COmentar cuando la api este funcionando
////////
  // void onTap(LatLng position) {
  //   final markerId = MarkerId(_markers.length.toString());
  //   final marker = Marker(
  //     markerId: markerId,
  //     position: position,
  //   );
  //   _markers[markerId] = marker;
  //   notifyListeners();
  // }

  Future<Position> _determinarPosicion() async {
    bool serviceEnable;
    LocationPermission permission;
    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      return Future.error('Location service are disable');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permision denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permision are permanently denied");
    }
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }
}
