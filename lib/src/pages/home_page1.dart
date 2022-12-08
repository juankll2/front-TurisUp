import 'package:flutter/material.dart';

import '../providers/menu_providers.dart';

class HomePage1 extends StatefulWidget {
  @override
  State<HomePage1> createState() => _HomePage1();
}

class _HomePage1 extends State<HomePage1> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recursos'),
      ),
      body: Center(
        child: Column(children: <Widget>[_CrearBotonesCabecera()]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explorar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Mapas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.route_sharp),
            label: 'Rutas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[700],
        onTap: _onItemTapped,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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

  Widget _ButtonIni(String nombre) {
    return Container(
        padding: EdgeInsets.all(5.0),
        child: TextButton(onPressed: () {}, child: Text('$nombre')));
  }

  Widget _lista() {
    return FutureBuilder(
      future: menuProvider.cargarData(),
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        print(snapshot.data);
        return ListView(
          children: _listaItems(snapshot.data ?? []),
        );
      },
    );
  }

  List<Widget> _listaItems(List<dynamic> data) {
    final List<Widget> opciones = [];
    data.forEach((opt) {
      final widgetTemp = ListTile(
        title: Text(opt['userId']),
        // ignore: prefer_const_constructors
        leading: Icon(
          Icons.account_circle_outlined,
          color: Colors.green,
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
}
