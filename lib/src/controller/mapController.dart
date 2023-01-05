import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart' show ChangeNotifier;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turismup/src/controller/image_to_bytes.dart';
import 'package:turismup/src/pages/getPlaces.dart';
import 'package:turismup/src/utils/map_style.dart';
import 'package:turismup/src/pages/datos_places.dart';
import 'package:http/http.dart' as http;

class MapController extends ChangeNotifier {
  Map<MarkerId, Marker> jsonMarkers = Map();
  static List<Datos_Place> registros = <Datos_Place>[];
  Future<List<Datos_Place>> placesFuture = getDatos();

  static Future<List<Datos_Place>> getDatos() async {
    const url = 'http://192.168.1.9:8001/api/place/all/aceptados';
    final response = await http.get(Uri.parse(url));
    var datos = json.decode(utf8.decode(response.bodyBytes));
    for (var i = 0; i < datos.length; i++) {
      registros.add(Datos_Place.formJson(datos[i]));
    }
    return datos.map<Datos_Place>(Datos_Place.formJson).toList();
  }

  void cargarMarkers() async {
    for (var i = 0; i < registros.length; i++) {
      if (registros[i].latitud != null && registros[i].longitud != null) {
        final id = MarkerId((registros[i].placeId).toString());
        final icon = await imageToBytes(registros[i].imagesPaths[0]);
        final marker = Marker(
            markerId: id,
            onDrag: null,
            onDragStart: null,
            icon: icon,
            infoWindow: InfoWindow(title: (registros[i].title).toString()),
            position: LatLng(double.parse(registros[i].latitud),
                double.parse(registros[i].longitud)));
        jsonMarkers[id] = marker;
      }
    }
    notifyListeners();
  }

  final initialCameraPosition =
      CameraPosition(target: LatLng(-2.899083, -79.010601), zoom: 16);
  //Modificar el estilo del mapa

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(mapStyle);
    //var llamada = getDatos();
    cargarMarkers();
    print('*************************');
    print(jsonMarkers);
  }

  void onTap(LatLng position) {
    // final markerId = MarkerId(_markers.length.toString());
    // final marker = Marker(
    //   markerId: markerId,
    //   position: position,
    // );
    // _markers[markerId] = marker;
    // print(markersJson);
    // notifyListeners();
  }
}
