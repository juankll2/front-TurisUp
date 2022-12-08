import 'package:flutter/material.dart';

class CrearRecursoPage extends StatefulWidget {
  @override
  createState() => _CrearRecursoPageState();
}

// Holds data related to the form.
class _CrearRecursoPageState extends State<CrearRecursoPage> {
  GlobalKey<FormState> keyForm = new GlobalKey();
  TextEditingController nameCtrl = new TextEditingController();
  TextEditingController emailCtrl = new TextEditingController();
  TextEditingController mobileCtrl = new TextEditingController();
  TextEditingController passwordCtrl = new TextEditingController();
  TextEditingController repeatPassCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar un nuevo recurso'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Form(
            key: keyForm,
            child: formUI(),
          ),
        ),
      ),
    );
  }

  formItemsDesign(icon, item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Card(child: ListTile(leading: Icon(icon), title: item)),
    );
  }

  Widget formUI() {
    return Column(
      children: <Widget>[
        formItemsDesign(
            Icons.person,
            TextFormField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'UserId',
              ),
            )),
        formItemsDesign(
            Icons.person,
            TextFormField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Latitud',
              ),
            )),
        formItemsDesign(
            Icons.person,
            TextFormField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Longitud',
              ),
            )),
        formItemsDesign(
            Icons.person,
            TextFormField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Location',
              ),
            )),
        formItemsDesign(
            Icons.person,
            TextFormField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Link',
              ),
            )),
        formItemsDesign(
            Icons.person,
            TextFormField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'asfafds',
              ),
            )),
        formItemsDesign(
            Icons.person,
            TextFormField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'sdafas',
              ),
            )),
        formItemsDesign(
            Icons.person,
            TextFormField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'title',
              ),
            )),
        formItemsDesign(
            Icons.person,
            TextFormField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'label',
              ),
            )),
        formItemsDesign(
            Icons.person,
            TextFormField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'fn',
              ),
            )),
      ],
    );
  }
}

void _cuadro() {}
