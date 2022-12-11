import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InputsPage extends StatefulWidget {
  const InputsPage({super.key});

  @override
  State<InputsPage> createState() => _InputsPage();
}

class _InputsPage extends State<InputsPage> {
  String _title = '';
  String _longitud = '';
  String _latitud = '';
  String _address = '';
  String _location = '';
  String _link = '';
  String _label = '';
  String _fn = '';
  String _imgPath = '';
  List _imagesPaths = [];
  String _descricion = '';
  double distancia = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de lugares'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        children: <Widget>[
          _crearInput(),
          // _divider(),
          _descripcionInput(),
          _divider(),
          _cargarImagenInput(),
          _divider(),
          _latitudInput(),
          _divider(),
          _longitudInput(),
          _divider(),
          _direccionInput(),
          _divider(),
          _locacionInput(),
          _divider(),
          _linkInput(),
          _divider(),
          _labelInput(),
          _divider(),
          _fnInput(),
          _divider(),
          _btnsAceptarCancelar(),
        ],
      ),
    );
  }

  Widget _btnsAceptarCancelar() {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            MaterialButton(
              minWidth: 10.0,
              height: 40.0,
              color: Colors.blue[200],
              onPressed: () {},
              child: Text('Crear recurso'),
            ),
            MaterialButton(
              minWidth: 10.0,
              height: 40.0,
              color: Colors.blue[200],
              onPressed: () {},
              child: Text('Cancelar'),
            )
          ]),
    );
  }

  Widget _divider() {
    return (const Divider(
      indent: 40.0,
      height: 40,
      endIndent: 40.0,
      color: Colors.blue,
    ));
  }

  Widget _crearInput() {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          hintText: 'Nombre del recurso', //Title
          labelText: 'Nombre del recurso',
          // helperText: 'Defina un nombre del nuevo recurso',
          icon: Icon(Icons.card_travel)),
      onChanged: (valor) {
        _title = valor;
      },
    );
  }

  Widget _longitudInput() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          hintText: 'Longitud del recurso', //Title
          labelText: 'Longitud del recurso',
          //helperText: 'Defina la longitud del nuevo recurso',
          icon: Icon(Icons.place)),
      onChanged: (valor) {
        _longitud = valor;
      },
    );
  }

  Widget _latitudInput() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          hintText: 'Latitud del recurso', //Title
          labelText: 'Latitud del recurso',
          //helperText: 'Defina la latitud del nuevo recurso',
          icon: Icon(Icons.place)),
      onChanged: (valor) {
        _longitud = valor;
      },
    );
  }

  Widget _direccionInput() {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          hintText: 'Dirección del recurso', //Title
          labelText: 'Dirección del recurso',
          // helperText: 'Defina un nombre del nuevo recurso',
          icon: Icon(Icons.streetview)),
      onChanged: (valor) {
        _address = valor;
      },
    );
  }

  Widget _locacionInput() {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          hintText: 'Locación del recurso', //Title
          labelText: 'Locación del recurso',
          // helperText: 'Defina un nombre del nuevo recurso',
          icon: Icon(Icons.location_city)),
      onChanged: (valor) {
        _location = valor;
      },
    );
  }

  Widget _labelInput() {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          hintText: 'Etiquetas del recurso', //Title
          labelText: 'Etiquetas del recurso',
          // helperText: 'Defina un nombre del nuevo recurso',
          icon: Icon(Icons.label)),
      onChanged: (valor) {
        _label = valor;
      },
    );
  }

  Widget _fnInput() {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          hintText: 'Fn del recurso', //Title
          labelText: 'Fn del recurso',
          // helperText: 'Defina un nombre del nuevo recurso',
          icon: Icon(Icons.fullscreen_exit_outlined)),
      onChanged: (valor) {
        _fn = valor;
      },
    );
  }

  Widget _cargarImagenInput() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      // height: 200,
      width: 200,
      child: Column(
        children: <Widget>[
          // ignore: prefer_const_constructors
          Text(
            'Imagenes del recurso',
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.blue, fontSize: 12),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    // Text('Buscar Imagen'),
                    MaterialButton(
                      child: Text('Abrir Galeria'),
                      onPressed: () async {
                        ImagePicker _img = ImagePicker();
                        PickedFile? _pickerFile =
                            await _img.getImage(source: ImageSource.gallery);
                        if (_pickerFile == null) {
                          _imgPath = '';
                        } else {
                          _imgPath = _pickerFile.path;
                        }

                        setState(() {});
                        // print('----------------------------------------------');
                        // print(_imgPath);
                      },
                      color: Colors.blue[100],
                    )
                  ],
                ),
              ),
              Container(
                // color: Colors.blue,
                child: IconButton(
                  onPressed: () async {
                    ImagePicker _img = ImagePicker();
                    PickedFile? _pickerFile =
                        await _img.getImage(source: ImageSource.camera);
                    if (_pickerFile == null) {
                      _imgPath = '';
                    } else {
                      _imgPath = _pickerFile.path;
                    }
                    setState(() {});
                    // print('----------------------------------------------');
                    // print(_imgPath);
                  },
                  icon: Icon(Icons.camera_alt_outlined),
                  color: Colors.blue[150],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _descripcionInput() {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          hintText: 'Descripcion del recurso', //Title
          labelText: 'Descripcion del recurso',
          // helperText: 'Defina un nombre del nuevo recurso',
          icon: Icon(Icons.label)),
      onChanged: (valor) {
        _descricion = valor;
      },
    );
  }

  Widget _linkInput() {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          hintText: 'Link del recurso', //Title
          labelText: 'Link del recurso',
          // helperText: 'Defina un nombre del nuevo recurso',
          icon: Icon(Icons.label)),
      onChanged: (valor) {
        _link = valor;
      },
    );
  }
}
