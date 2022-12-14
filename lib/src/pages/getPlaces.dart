// ignore: file_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:readmore/readmore.dart';
import 'package:turismup/src/pages/datos_places.dart';
import 'package:http/http.dart' as http;
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CargarJson extends StatefulWidget {
  const CargarJson({super.key});

  @override
  State<CargarJson> createState() => CargarJsonState();
}

class CargarJsonState extends State<CargarJson> {
  Future<List<Datos_Place>> placesFuture = getPlaces();

  static Future<List<Datos_Place>> getPlaces() async {
    const url = 'http://192.168.1.9:8001/api/place/all/aceptados';
    final response = await http.get(Uri.parse(url));
    // final body = json.decode(response.body);
    final body = json.decode(utf8.decode(response.bodyBytes));
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

  Widget buildPresentation(String title, String place, List paths,
      String descripcion, String etiqueta) {
    // ignore: prefer_const_constructors
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 0),
              width: double.infinity,
              height: 250,
              child: Image(
                image: NetworkImage(paths[0]),
                // color: Colors.amber,
                height: 100,
                width: double.infinity,
              ),
            ),
            Container(
              // color: Colors.amber,
              margin: EdgeInsets.only(left: 15.0, top: 0),
              alignment: Alignment.centerLeft,
              child: Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25.0)),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 70,
                    height: 20,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text('$etiqueta',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10.0,
                            color: Colors.blue)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 65, right: 20),
                    child: Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                  ),
                  Container(
                    child: Text('4.8  (1.234 Opiniones)'),
                  )
                ],
              ),
            ),
            Divider(
              indent: 40.0,
              height: 40,
              endIndent: 40.0,
              color: Colors.grey,
            ),
            Container(
              // Dentro de esto se sybe la foto de la orgabizacion
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  // ignore: prefer_const_constructors
                  Padding(
                    padding: const EdgeInsets.all(20),
                    // ignore: prefer_const_constructors
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(paths[0]),
                      radius: 30,
                    ),
                  ),
                  Container(
                    width: 180,
                    alignment: Alignment.centerLeft,
                    child: Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        // ignore: prefer_const_constructors
                        Text(
                          'Nombre Organizacion ',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                        Text(
                          'Promocionado por',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12.0,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                      child: Icon(
                    Icons.account_box_rounded,
                    size: 55,
                  ))
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20.0),
              child: Text(
                'Descripci??n',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Container(
              // width: 10,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20.0, top: 10.0),
              child: ReadMoreText('$descripcion',
                  trimLines: 4,
                  trimCollapsedText: 'Leer mas',
                  trimExpandedText: 'Leer menos',
                  style: TextStyle(fontSize: 13.0)),
            )
          ],
        ),
      ),
    );
  }

  Widget buildPlaces(List<Datos_Place> places) => ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) {
        final place = places[index];
        return Card(
          // ignore: sort_child_properties_last
          child: ListTile(
            leading: SizedBox(
              width: 100,
              height: 100,
              child: FadeInImage(
                placeholder: const AssetImage('assets/jar-loading.gif'),
                //falta poner el condicional para encontrar la imagen
                image: NetworkImage((place.imagesPaths[0])),
              ),
            ),
            title: Text((place.title).toString()),
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
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => buildPresentation(
                          (place.title).toString(),
                          (place.descripcion).toString(),
                          place.imagesPaths,
                          (place.descripcion).toString(),
                          (place.label).toString())));
              // buildPresentation(index);
              // print(index);
            },
          ),
        );
      });
}
