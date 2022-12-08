import 'package:flutter/material.dart';
import 'package:turismup/src/pages/inputs_page.dart';
import 'package:turismup/src/providers/menu_providers.dart';

import 'crear_recurso_page.dart';

class RoutePage extends StatefulWidget {
  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  //const RoutePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recursos'),
      ),
      body: _lista(),
      floatingActionButton: _CrearBoton(),
    );
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
                MaterialPageRoute(builder: (context) => InputsPage()),
              );
            }),
        const SizedBox(
          width: 10.0,
        ),
      ],
    );
  }

  Widget _lista() {
    return FutureBuilder(
      future: menuProvider.cargarPlace(),
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        print(snapshot.data);
        return ListView(
          children: _listaItems(snapshot.data ?? [], context),
        );
      },
    );
  }

  List<Widget> _listaItems(List<dynamic> data, BuildContext context) {
    final List<Widget> opciones = [];
    data.forEach((opt) {
      final widgetTemp = ListTile(
        title: Text(opt['location']),
        subtitle: Text(opt['userId']),
        leading: Container(
          width: 30,
          height: 30,
          // ignore: prefer_const_constructors
          child: FadeInImage(
              placeholder: const AssetImage('assets/jar-loading.gif'),
              image: const NetworkImage(
                  'https://photo620x400.mnstatic.com/1cfc308e08847a13626f5e2fbe1d9c1d/catedral-de-la-inmaculada-concepcion.jpg')),
        ),
        // ignore: prefer_const_constructors
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.deepPurpleAccent,
        ),
        onTap: () {},
      );
      opciones
        ..add(widgetTemp)
        ..add(Divider());
    });
    return opciones;
  }

  // void _abrirVentana() {
  //   setState(() => );
  // }
}
