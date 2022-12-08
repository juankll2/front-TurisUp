class Datos_Place {
  String placeId = '';
  String descripcion = '';
  String userId = '';
  String latitud = '';
  String longitud = '';
  String address = '';
  String location = '';
  String link = '';
  String title = '';
  String label = '';
  String fn = '';
  List imagesPaths = [];
  String distance = '';

  Datos_Place(
      this.placeId,
      this.descripcion,
      this.userId,
      this.latitud,
      this.longitud,
      this.address,
      this.location,
      this.link,
      this.title,
      this.label,
      this.fn,
      this.imagesPaths,
      this.distance);

  Datos_Place.datos_formJson(Map<String, dynamic> json) {
    placeId = json['placeId'];
    descripcion = json['descripcion'];
    userId = json['userId'];
    latitud = json['latitud'];
    longitud = json['longitud'];
    address = json['address'];
    location = json['location'];
    link = json['link'];
    title = json['title'];
    label = json['label'];
    fn = json['fn'];
    imagesPaths = json['imagesPaths'];
    distance = json['distance'];
  }
}
