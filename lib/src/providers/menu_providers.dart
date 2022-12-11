import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:turismup/src/pages/datos_places.dart';

class MenuProvider {
  List<dynamic> opciones = [];

  List<Datos_Place> datos = <Datos_Place>[];

  // Future<List<Datos_Place>> cargarPlace() async {
  //   var url = 'http://192.168.1.5:8000/api/place/all';
  //   print('entro antes de var response');
  //   var response =
  //       await http.post(Uri.parse(url)).timeout(const Duration(seconds: 10));
  //   var datos = jsonDecode(response.body);
  //   var registros = <Datos_Place>[];
  //   print('entro al for');
  //   for (datos in datos) {
  //     registros.add(Datos_Place.formJson(datos));
  //   }
  //   print('-------------------------------------------');
  //   print(registros[0]);
  //   print('-------------------------------------------');
  //   return registros;
  // }

  _MenuProvider() {
    cargarData();
    cargarDatos();
    // cargarPlace();
  }

  Future<List<dynamic>> cargarData() async {
    final resp = await rootBundle.loadString('data/menu_opts.json');
    Map dataMap = json.decode(resp);
    print(dataMap['rutas']);
    opciones = dataMap['places'];
    cargarDatos();
    return opciones;
  }

  void cargarDatos() async {
    var url = 'http://192.168.1.5:8000/api/place/all';
    Response response =
        await get(Uri.parse(url)).timeout(const Duration(seconds: 10));
    Map data = jsonDecode(response.body);
    print('imprimir datos');
    print(data);
  }
}

final menuProvider = MenuProvider();
