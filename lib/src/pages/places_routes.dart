// ignore: file_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:readmore/readmore.dart';
import 'package:turismup/src/pages/datos_places.dart';
import 'package:http/http.dart' as http;
import 'package:turismup/src/pages/inputs_page.dart';

import '../controller/rutasController.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CargarJsonPlaces extends StatefulWidget {
  const CargarJsonPlaces({super.key});

  @override
  State<CargarJsonPlaces> createState() => CargarJsonPlacesState();
}

class CargarJsonPlacesState extends State<CargarJsonPlaces> {
  Future<List<Datos_Place>> placesFuture = getPlaces();
  Map<int, List> rutas = {};
  List lugares = [];
  final controller = RutasController();

  static Future<List<Datos_Place>> getPlaces() async {
    Map<String, String> modelo = <String, String>{};
    String model = json.encode(modelo);
    const url = 'http://192.168.43.127:8083/api/recurso/todos';
    final response = await http.get(
      Uri.parse(url),
    );
    // final body = json.decode(response.body);
    final body = json.decode(utf8.decode(response.bodyBytes));
    return body.map<Datos_Place>(Datos_Place.formJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(252, 251, 251, 1),
      body: Center(
          child: FutureBuilder<List<Datos_Place>>(
              future: placesFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final places = snapshot.data!;
                  return buildPlaces(places);
                } else {
                  return const Text('Cargando datos');
                }
              })),
    );
  }

  List urlimagen = [];

  Widget buildPlaces(List<Datos_Place> places) => ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) {
        final place = places[index];
        return Card(
          // ignore: sort_child_properties_last
          child: ListTile(
            leading: const SizedBox(
              width: 100,
              height: 100,
              child: FadeInImage(
                placeholder: AssetImage('assets/jar-loading.gif'),
                //falta poner el condicional para encontrar la imagen
                // image: NetworkImage((place.imagenesPaths[0])),
                image: NetworkImage(
                    ('https://static.vecteezy.com/system/resources/previews/005/337/799/non_2x/icon-image-not-found-free-vector.jpg')),
              ),
            ),
            title: Text((place.nombre).toString()),
            subtitle: ReadMoreText(
              (place.descripcion).toString(),
              trimMode: TrimMode.Line,
              trimLines: 4,
              trimCollapsedText: 'Leer mas',
              trimExpandedText: 'Leer menos',
              colorClickableText: Colors.blue[300],
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.blue[200],
            ),
            onLongPress: () {
              controller.eliminarLugares(index);
            },
            onTap: () {
              controller.agregarLugares(index, place.coordenadas['latitud'],
                  place.coordenadas['longitud']);
            },
          ),
        );
      });
}
