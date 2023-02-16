import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapsforge_flutter/core.dart';
import 'package:mapsforge_flutter/maps.dart';
import 'package:mapsforge_flutter/marker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:turismup/src/pages/datos_places.dart';

class MapsOfflineP extends StatefulWidget {
  const MapsOfflineP({super.key});

  @override
  State<MapsOfflineP> createState() => _MapsOfflinePState();
}

class _MapsOfflinePState extends State<MapsOfflineP> {
  late MapModel mapModel;
  late ViewModel viewModel;
  final MarkerDataStore markerDataStore = MarkerDataStore();
  PoiMarker? marker;
  static var datosjson = [];
  static List<Datos_Place> registros2 = <Datos_Place>[];
  static List<Datos_Place> vacio = <Datos_Place>[];
  var aux;

  @override
  void initState() {
    // () async {
    //   // final file = await _localFile;
    //   // bool exist = await file.exists();
    //   // if (exist != false) {
    //   registros2 = await readCounter();
    //   print(registros2);
    //   // }
    // }();
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    mapModel.dispose();

    super.dispose();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/datosJson.json');
  }

  ///funcion para leer datos ///////
  Future<List<Datos_Place>> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();
      // print('//////////////////datos del archivo////////////////////');
      //print(contents);
      aux = json.decode(contents);
      return jsonDecode(contents);
    } catch (e) {
      // If encountering an error, return 0
      return vacio;
    }
  }

  Future<Position> _determinarPosicion() async {
    bool serviceEnable;
    LocationPermission permission;
    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      return Future.error('Location service are disable');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permision denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permision are permanently denied");
    }
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  Future<void> _initialize() async {
    Position posact = await _determinarPosicion();
    final Directory docDir = await getApplicationDocumentsDirectory();
    final String localPath = docDir.path;
    // Load the mapfile which holds the openstreetmap® data
    final mapFile = await MapFile.from("$localPath/ecuador.map", null, null);

    // Create the cache for assets
    final symbolCache = FileSymbolCache();

    // Create the displayModel which defines and holds the view/display settings
    // like maximum zoomLevel.
    final displayModel = DisplayModel();

    // Create the render theme which specifies how to render the informations
    // from the mapfile.
    final renderTheme = await RenderThemeBuilder.create(
      displayModel,
      'assets/render_themes/custom.xml',
    );

    final jobRenderer =
        MapDataStoreRenderer(mapFile, renderTheme, symbolCache, true);

    // Glue everything together into two models.
    mapModel = MapModel(
      displayModel: displayModel,
      renderer: jobRenderer,
    );
    mapModel.markerDataStores.add(markerDataStore);

    viewModel = ViewModel(displayModel: displayModel);
    viewModel.setMapViewPosition(-2.897468, -79.004729);
    viewModel.setZoomLevel(15);

    var aux1 = await readCounter();
    for (var elemento in aux) {
      PoiMarker? marker1;
      double lat = elemento['coordenadas']['latitud'];
      double long = elemento['coordenadas']['longitud'];
      LatLong ubi = LatLong(lat, long);
      marker1 = PoiMarker(
        displayModel: DisplayModel(),
        src: 'assets/icons/marker.svg',
        // height: 64,
        // width: 48,
        latLong: ubi,
      );
      print(marker1);
      print(marker1.latLong);
      // await marker1.initResources(symbolCache);
      // await marker!.initResources(symbolCache);
      markerDataStore.addMarker(marker1);
      markerDataStore.setRepaint();

      print('entro');
    }
    mapModel.markerDataStores.add(markerDataStore);
    ////
    /// Modificacion de LongTap
    ///
    // Listen to longTap and add marker
    viewModel.observeLongTap.listen((event) async {
      marker = PoiMarker(
        displayModel: DisplayModel(),
        src: 'assets/icons/stairs.svg',
        height: 64,
        width: 48,
        latLong: LatLong(posact.latitude, posact.longitude),
      );
      print(posact);
      await marker!.initResources(symbolCache);

      markerDataStore.addMarker(marker!);

      // markerDataStore.setRepaint();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return FlutterMapView(mapModel: mapModel, viewModel: viewModel);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
