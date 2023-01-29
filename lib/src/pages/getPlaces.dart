// ignore: file_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:readmore/readmore.dart';
import 'package:turismup/src/pages/datos_places.dart';
import 'package:http/http.dart' as http;
import 'package:turismup/src/pages/inputs_page.dart';
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

  Widget buildPresentation(String nombre, String place, List paths,
      String descripcion, String organizacion) {
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
                image: NetworkImage(
                    'https://static.vecteezy.com/system/resources/previews/005/337/799/non_2x/icon-image-not-found-free-vector.jpg'),
                // image: NetworkImage(paths[0]),
                // color: Colors.amber,
                height: 100,
                width: double.infinity,
              ),
            ),
            Container(
              // color: Colors.amber,
              margin: const EdgeInsets.only(left: 15.0, top: 0),
              alignment: Alignment.centerLeft,
              child: Text(nombre,
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
                    child: const Text('Sin etiquet',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10.0,
                            color: Colors.blue)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 65, right: 20),
                    child: const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                  ),
                  Container(
                    child: const Text('4.8  (1.234 Opiniones)'),
                  )
                ],
              ),
            ),
            const Divider(
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
                      backgroundImage: NetworkImage(
                          'https://static.vecteezy.com/system/resources/previews/005/337/799/non_2x/icon-image-not-found-free-vector.jpg'),
                      // backgroundImage: NetworkImage(paths[0]),
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
                          '$organizacion',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                        const Text(
                          'Promocionado por:',
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
                      // ignore: prefer_const_constructors
                      child: Icon(
                    Icons.account_box_rounded,
                    size: 55,
                  ))
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 20.0),
              child: const Text(
                'Descripción',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Container(
              // width: 10,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20.0, top: 10.0),
              child: ReadMoreText('$descripcion',
                  trimLines: 3,
                  trimCollapsedText: 'Leer mas',
                  trimExpandedText: 'Leer menos',
                  style: const TextStyle(fontSize: 13.0)),
            )
          ],
        ),
      ),
    );
  }

  Widget _ButtonIni(String nombre) {
    return Container(
        padding: const EdgeInsets.all(1.0),
        child: TextButton(
            onPressed: () {
              print('$nombre');
            },
            child: Text('$nombre')));
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
                MaterialPageRoute(builder: (context) => const InputsPage()),
              );
            }),
        const SizedBox(
          width: 10.0,
        ),
      ],
    );
  }

  Widget _CrearBotonesCabecera() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _ButtonIni('Todo'),
        _ButtonIni('Iglesias'),
        _ButtonIni('Museos'),
        _ButtonIni('Playas'),
        _ButtonIni('Hoteles'),
        _ButtonIni('Parques'),
        _ButtonIni('Teatros'),
        _ButtonIni('Restaurantes'),
      ],
    );
  }

  List urlimagen = [];

  Widget buildPlaces(List<Datos_Place> places) => GridView.count(
        // Crea una grid con 2 columnas. Si cambias el scrollDirection a
        // horizontal, esto produciría 2 filas.
        crossAxisCount: 2,
        crossAxisSpacing: 4.0,
        childAspectRatio: 0.63,
        mainAxisSpacing: 4.0,
        // Genera 100 Widgets que muestran su índice en la lista
        children: List.generate(places.length, (index) {
          final place = places[index];
          return InkWell(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 160,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        ('https://static.vecteezy.com/system/resources/previews/005/337/799/non_2x/icon-image-not-found-free-vector.jpg'),
                        // child: Image.network(
                        //   (place.imagenesPaths[0]),
                        fit: BoxFit.fill,
                        //height: 150.0,
                        //width: 150.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    (place.nombre).toString(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'centro',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(164, 172, 188, 1),
                        fontSize: 12,
                        fontWeight: FontWeight.w100),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '1KM',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      IconButton(
                          onPressed: () {
                            print('presionado');
                          },
                          icon: const Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.blueAccent,
                          ))
                    ],
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => buildPresentation(
                          (place.nombre).toString(),
                          (place.descripcion).toString(),
                          // place.imagenesPaths,
                          (urlimagen),
                          (place.descripcion).toString(),
                          (place.organizacion!['nombre']).toString())));
            },
          );
        }),
      );
}
  /*
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
*/