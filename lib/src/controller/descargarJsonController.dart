import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:turismup/src/pages/datos_places.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DescargarJsonController extends StatefulWidget {
  const DescargarJsonController({super.key});

  @override
  State<DescargarJsonController> createState() =>
      _DescargarJsonControllerState();
}

class _DescargarJsonControllerState extends State<DescargarJsonController> {
  Future<List<Datos_Place>> placesFuture = getDatos();
  static List<Datos_Place> registros = <Datos_Place>[];
  static var datosjson = [];
  static List<Datos_Place> registros2 = <Datos_Place>[];
  static List<Datos_Place> vacio = <Datos_Place>[];

  static Future<List<Datos_Place>> getDatos() async {
    const url = 'http://34.136.87.84:8083/api/recurso/todos';
    final response = await http.get(Uri.parse(url));
    var datos = json.decode(utf8.decode(response.bodyBytes));
    datosjson = datos;
    registros2 = datos.map<Datos_Place>(Datos_Place.formJson).toList();
    return registros2;
  }

  @override
  void initState() {
    // () async {
    //   await getPlaces();
    // };
    super.initState();
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
                  return buildPage(places);
                } else {
                  return const Text('Cargando datos');
                }
              })),
    );
  }

  Widget buildPage(List<Datos_Place> places) {
    return Scaffold(
      // ignore: prefer_const_constructors
      body: Center(
        child: const Text('descargardatos'),
      ),
      floatingActionButton: descargarJson(places),
    );
  }

  Widget descargarJson(List<Datos_Place> places) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        const SizedBox(
          width: 30.0,
        ),
        FloatingActionButton(
            child: const Icon(Icons.save_alt),
            onPressed: () {
              print(
                  '****************************************presionado***********************************');
              // print(datosjson);
              // imprimir();
              writeCounter();
              readCounter();
              // print(registros);
            }),
      ],
    );
  }

  // void imprimir() {
  //   for (var i = 0; i < datosjson.length; i++) {
  //     print('//////');
  //     print(datosjson[i]);
  //   }
  //   var cadena = json.encode(datosjson);
  //   print('////////////////////////////////');
  //   print(cadena);
  //   var cadena2 = json.decode(cadena);
  //   print('++++++++++++++++++++++++++++++');
  //   print(cadena2.toString());
  // }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/datosJson.json');
  }

  ///funcion para leer datos ///////
  Future<List<Datos_Place>> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();
      // print('//////////////////datos del archivo////////////////////');
      //print(contents);
      var aux = json.decode(contents);
      print(aux[0]['nombre']);
      return jsonDecode(contents);
    } catch (e) {
      // If encountering an error, return 0
      return vacio;
    }
  }

  Future<File> writeCounter() async {
    final file = await _localFile;
    return await file.writeAsString(jsonEncode(datosjson));
  }
}
