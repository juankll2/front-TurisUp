import 'package:flutter/material.dart';

class CardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        children: <Widget>[
          _cardTipo1(),
          SizedBox(
            height: 10.0,
          ),
          _cardTipo2(),
        ],
      ),
    );
  }

  Widget _cardTipo1() {
    return Card(
      child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          const ListTile(
            leading: Icon(
              Icons.photo,
              color: Colors.blue,
            ),
            title: Text('Soy el titulo de esta tarjeta'),
            subtitle: Text(
                'Aqui se podria poner una descripcion muy larga para la tarjeta'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(onPressed: () {}, child: Text('Boton'))
            ],
          )
        ],
      ),
    );
  }

  Widget _cardTipo2() {
    return Card(
      child: Column(
        children: <Widget>[
          FadeInImage(
              placeholder: AssetImage('assets/jar-loading.gif'),
              image: NetworkImage(
                  'https://photo620x400.mnstatic.com/1cfc308e08847a13626f5e2fbe1d9c1d/catedral-de-la-inmaculada-concepcion.jpg')),
          // Image(
          //     image: NetworkImage(
          //         'https://photo620x400.mnstatic.com/1cfc308e08847a13626f5e2fbe1d9c1d/catedral-de-la-inmaculada-concepcion.jpg')),
          Container(padding: EdgeInsets.all(10.0), child: Text('data')),
        ],
      ),
    );
  }
}
