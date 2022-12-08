import 'package:flutter/material.dart';

class ExplorerPage extends StatelessWidget {
  const ExplorerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recursos'),
      ),
      body: Center(
        child: Column(children: <Widget>[_CrearBotonesCabecera()]),
      ),
    );
  }

  Widget _ButtonIni(String nombre) {
    return Container(
        padding: EdgeInsets.all(5.0),
        child: TextButton(onPressed: () {}, child: Text('$nombre')));
  }

  Widget _CrearBotonesCabecera() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _ButtonIni('Todo'),
        _ButtonIni('Iglesias'),
        _ButtonIni('Museos'),
        _ButtonIni('Playas'),
        // _ButtonIni('Teatros'),
      ],
    );
  }
}
