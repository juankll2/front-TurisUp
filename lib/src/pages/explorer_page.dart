import 'package:flutter/material.dart';
import 'package:turismup/src/pages/getPlaces.dart';
import 'package:turismup/src/pages/inputs_page.dart';

class ExplorerPage extends StatefulWidget {
  const ExplorerPage({super.key});

  @override
  State<ExplorerPage> createState() => _ExplorerPageState();
}

class _ExplorerPageState extends State<ExplorerPage> {
  @override
  void initState() {
    // TODO: implement initState
    const CargarJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recursos'),
      ),
      body: const CargarJson(),
      floatingActionButton: _CrearBoton(),
    );
  }
////
  /// Anterior pantalla donde se encuentran los botones de la parte superior para los filtros
  ///
//  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Recursos'),
//       ),
//       body: Column(children: <Widget>[
//         SingleChildScrollView(
//             scrollDirection: Axis.horizontal, child: _CrearBotonesCabecera()),
//         Container()
//       ]),
//       floatingActionButton: _CrearBoton(),
//     );
//   }

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
}
