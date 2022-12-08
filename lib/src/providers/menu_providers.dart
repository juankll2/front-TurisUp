import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:turismup/src/pages/datos_places.dart';
import 'package:dio/dio.dart';

class MenuProvider {
  static Dio _dio = Dio();

  List<dynamic> opciones = [];

  List<Datos_Place> datos = <Datos_Place>[];

  Future<List<Datos_Place>> cargarPlace() async {
    var url = 'http://192.168.1.5:8000/api/place/all';
    print('entro antes de var response');
    var response =
        await http.post(Uri.parse(url)).timeout(const Duration(seconds: 10));
    var datos = jsonDecode(response.body);
    var registros = <Datos_Place>[];
    print('entro al for');
    for (datos in datos) {
      registros.add(Datos_Place.datos_formJson(datos));
    }
    print('-------------------------------------------');
    print(registros);
    print('-------------------------------------------');
    return registros;
  }

  _MenuProvider() {
    cargarData();
    cargarPlace();
  }

  Future<List<dynamic>> cargarData() async {
    final resp = await rootBundle.loadString('data/menu_opts.json');
    Map dataMap = json.decode(resp);
    // print(dataMap['rutas']);
    opciones = dataMap['places'];
    return opciones;
  }
}

final menuProvider = MenuProvider();
