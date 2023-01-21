import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class InputsPage extends StatefulWidget {
  const InputsPage({super.key});

  @override
  State<InputsPage> createState() => _InputsPage();
}

class _InputsPage extends State<InputsPage> {
  final titleCtr = TextEditingController();
  final longitudCtr = TextEditingController();
  final latitudCtr = TextEditingController();
  final addressCtrCtr = TextEditingController();
  final locationCtr = TextEditingController();
  final linkCtr = TextEditingController();
  final labelCtr = TextEditingController();
  final fnCtr = TextEditingController();
  final descricionCtr = TextEditingController();

  String url = 'http://192.168.1.3:8083/api/recurso/todos';
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
  // double distancia = 0.0;
  final myController = TextEditingController();
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
          // _divider(),
          _latitudInput(),
          // _divider(),
          _longitudInput(),
          // _divider(),
          _direccionInput(),
          // _divider(),
          _locacionInput(),
          // _divider(),
          _linkInput(),
          // _divider(),
          _labelInput(),
          // _divider(),
          _fnInput(),
          _divider(),
          _cargarImagenInput(),
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
              onPressed: () {
                _title = titleCtr.text;
                _longitud = longitudCtr.text;
                _latitud = latitudCtr.text;
                _address = addressCtrCtr.text;
                _location = locationCtr.text;
                _link = linkCtr.text;
                _label = labelCtr.text;
                _fn = fnCtr.text;
                _descricion = descricionCtr.text;
                pathImage(url, _imgPath);
                titleCtr.text = '';
                longitudCtr.text = '';
                latitudCtr.text = '';
                addressCtrCtr.text = '';
                locationCtr.text = '';
                linkCtr.text = '';
                labelCtr.text = '';
                fnCtr.text = '';
                descricionCtr.text = '';
              },
              child: Text('Crear recurso'),
            ),
            // MaterialButton(
            //   minWidth: 10.0,
            //   height: 40.0,
            //   color: Colors.blue[200],
            //   onPressed: () {},
            //   child: Text('Cancelar'),
            // )
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
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: TextField(
        controller: titleCtr,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            hintText: 'Nombre del recurso', //Title
            labelText: 'Nombre del recurso',
            // helperText: 'Defina un nombre del nuevo recurso',
            icon: Icon(Icons.card_travel)),
        // onChanged: (valor) {
        //   _title = valor;
        // },
      ),
    );
  }

  Widget _longitudInput() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: TextField(
        controller: longitudCtr,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            hintText: 'Longitud del recurso', //Title
            labelText: 'Longitud del recurso',
            //helperText: 'Defina la longitud del nuevo recurso',
            icon: Icon(Icons.place)),
        // onChanged: (valor) {
        //   _longitud = valor;
        // },
      ),
    );
  }

  Widget _latitudInput() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: TextField(
        controller: latitudCtr,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            hintText: 'Latitud del recurso', //Title
            labelText: 'Latitud del recurso',
            //helperText: 'Defina la latitud del nuevo recurso',
            icon: Icon(Icons.place)),
        // onChanged: (valor) {
        //   _latitud = valor;
        // },
      ),
    );
  }

  Widget _direccionInput() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: TextField(
        controller: addressCtrCtr,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            hintText: 'Dirección del recurso', //Title
            labelText: 'Dirección del recurso',
            // helperText: 'Defina un nombre del nuevo recurso',
            icon: Icon(Icons.streetview)),
        // onChanged: (valor) {
        //   _address = valor;
        // },
      ),
    );
  }

  Widget _locacionInput() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: TextField(
        controller: locationCtr,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            hintText: 'Locación del recurso', //Title
            labelText: 'Locación del recurso',
            // helperText: 'Defina un nombre del nuevo recurso',
            icon: Icon(Icons.location_city)),
        // onChanged: (valor) {
        //   _location = valor;
        // },
      ),
    );
  }

  Widget _labelInput() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: TextField(
        controller: labelCtr,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            hintText: 'Etiquetas del recurso', //Title
            labelText: 'Etiquetas del recurso',
            // helperText: 'Defina un nombre del nuevo recurso',
            icon: Icon(Icons.label)),
        // onChanged: (valor) {
        //   _label = valor;
        // },
      ),
    );
  }

  Widget _fnInput() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: TextField(
        controller: fnCtr,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            hintText: 'Fn del recurso', //Title
            labelText: 'Fn del recurso',
            // helperText: 'Defina un nombre del nuevo recurso',
            icon: Icon(Icons.fullscreen_exit_outlined)),
        // onChanged: (valor) {
        //   _fn = valor;
        // },
      ),
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
                        print(_imgPath);
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
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: TextField(
        controller: descricionCtr,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            hintText: 'Descripcion del recurso', //Title
            labelText: 'Descripcion del recurso',
            // helperText: 'Defina un nombre del nuevo recurso',
            icon: Icon(Icons.label)),
        // onChanged: (valor) {
        //   _descricion = valor;
        // },
      ),
    );
  }

  Widget _linkInput() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: TextField(
        controller: linkCtr,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            hintText: 'Link del recurso', //Title
            labelText: 'Link del recurso',
            // helperText: 'Defina un nombre del nuevo recurso',
            icon: Icon(Icons.label)),
        // onChanged: (valor) {
        //   _link = valor;
        // },
      ),
    );
  }

  Future<http.StreamedResponse> pathImage(String url, String filePath) async {
    Map<String, String> modelo = <String, String>{
      'descripcion': '$_descricion',
      'userId': '22222222344a010c5dcab4b',
      'latitud': '$_latitud',
      'longitud': '$_longitud',
      'address': '$_address',
      'location': '$_location',
      'link': '$_link',
      'title': '$_title',
      'label': '$_label',
      'fn': '$_fn',
      'status': 'aprobado',
    };
    String model = json.encode(modelo);
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll({"Content-Type": "multipart/form-data"});
    request.fields['model'] = model;
    request.files.add(await http.MultipartFile.fromPath('files', filePath));
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    if (response.statusCode == 200) print('Uploaded!');
    return jsonDecode(respStr);
  }
}
