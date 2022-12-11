class Datos_Place {
  String placeId;
  String? descripcion = '';
  String userId = '';
  String latitud = '';
  String longitud = '';
  String? address = '';
  String? location = '';
  String? link = '';
  String? title = '';
  String? label = '';
  String? fn = '';
  List imagesPaths = [];
  double? distance = 0.0;

  Datos_Place(
      {required this.placeId,
      this.descripcion,
      required this.userId,
      required this.latitud,
      required this.longitud,
      this.address,
      this.location,
      this.link,
      this.title,
      this.label,
      this.fn,
      required this.imagesPaths,
      this.distance});

  static Datos_Place formJson(json) => Datos_Place(
      placeId: json['placeId'],
      descripcion: json['descripcion'],
      userId: json['userId'],
      latitud: json['latitud'],
      longitud: json['longitud'],
      address: json['address'],
      location: json['location'],
      link: json['link'],
      title: json['title'],
      label: json['label'],
      fn: json['fn'],
      imagesPaths: json['imagesPaths'],
      distance: json['distance']);
}
