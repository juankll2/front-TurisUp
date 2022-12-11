import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:turismup/src/pages/datos_places.dart';
import 'package:http/http.dart' as http;

class CargarJson extends StatefulWidget {
  const CargarJson({super.key});

  @override
  State<CargarJson> createState() => _CargarJsonState();
}

class _CargarJsonState extends State<CargarJson> {
  Future<List<Datos_Place>> placesFuture = getPlaces();

  static Future<List<Datos_Place>> getPlaces() async {
    const url = 'http://192.168.43.127:8000/api/place/all';
    final response = await http.get(Uri.parse(url));
    final body = json.decode(response.body);
    return body.map<Datos_Place>(Datos_Place.formJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder<List<Datos_Place>>(
              future: placesFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final places = snapshot.data!;
                  return buildPlaces(places);
                } else {
                  return const Text('No existen datos');
                }
              })),
    );
  }

  Widget buildPlaces(List<Datos_Place> places) => ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) {
        final place = places[index];
        return Card(
          child: ListTile(
            leading: Container(
              width: 100,
              height: 100,
              child: FadeInImage(
                placeholder: const AssetImage('assets/jar-loading.gif'),
                image: NetworkImage((place.imagesPaths[1])),
              ),
              // backgroundImage: NetworkImage((place.imagesPaths[1])),
            ),
            title: Text((place.title).toString()),
            subtitle: Text((place.descripcion).toString()),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.blue[200],
            ),
            onTap: () {},
          ),
        );
      });
}
