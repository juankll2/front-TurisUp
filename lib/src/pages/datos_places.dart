class Datos_Place {
  String id;
  String? nombre = '';
  String? status = '';
  var coordenadas = {};
  String descripcion = '';
  List imagenesPaths = [];
  Map? organizacion = {};
  Map? region = {};
  Map? user = {};

  double? distance = 0.0;

  Datos_Place(
      {required this.id,
      required this.nombre,
      this.status,
      required this.coordenadas,
      required this.descripcion,
      required this.imagenesPaths,
      this.organizacion,
      this.region,
      this.user});

  static Datos_Place formJson(json) => Datos_Place(
      id: json['id'],
      nombre: json['nombre'],
      status: json['status'],
      coordenadas: json['coordenadas'],
      descripcion: json['descripcion'],
      imagenesPaths: json['imagenesPaths'],
      organizacion: json['organizacion'],
      region: json['region'],
      user: json['user']);
}
