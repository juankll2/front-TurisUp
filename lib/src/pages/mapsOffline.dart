// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:mapsforge_flutter/src/graphics/display.dart';
// import 'package:mapsforge_flutter/core.dart';
// import 'package:mapsforge_flutter/maps.dart';
// import 'package:mapsforge_flutter/marker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:turismup/src/pages/datos_places.dart';

// import 'package:flutter/services.dart';

// class MapsOfflineP extends StatefulWidget {
//   const MapsOfflineP({super.key});

//   @override
//   State<MapsOfflineP> createState() => _MapsOfflinePState();
// }

// class _MapsOfflinePState extends State<MapsOfflineP> {
//   // Create the displayModel which defines and holds the view/display settings
//   // like maximum zoomLevel.
//   final displayModel = DisplayModel(deviceScaleFactor: 2);

//   // Create the cache for assets
//   final symbolCache = FileSymbolCache();

//   final MarkerDataStore markerDataStore = MarkerDataStore();

//   Future<MapModel> _createMapModel() async {
//     final Directory docDir = await getApplicationDocumentsDirectory();
//     final String localPath = docDir.path;
//     // Load the mapfile which holds the open
//     // Load the mapfile which holds the openstreetmap® data. Use either MapFile.from() or load it into memory first (small files only) and use MapFile.using()
//     final mapFile = await MapFile.from("$localPath/ecuador.map", null, null);

//     // Create the render theme which specifies how to render the informations
//     // from the mapfile.
//     final renderTheme = await RenderThemeBuilder.create(
//       displayModel,
//       'assets/render_themes/custom.xml',
//     );
//     // Create the Renderer
//     final jobRenderer =
//         MapDataStoreRenderer(mapFile, renderTheme, symbolCache, true);

//     // Glue everything together into two models.
//     MapModel mapModel = MapModel(
//       displayModel: displayModel,
//       renderer: jobRenderer,
//     );

//     // Add MarkerDataStore to hold added markers
//     mapModel.markerDataStores.add(markerDataStore);
//     return mapModel;
//   }

//   Future<ViewModel> _createViewModel() async {
//     ViewModel viewModel = ViewModel(displayModel: displayModel);
//     // set the initial position
//     viewModel.setMapViewPosition(-2.897468, -79.004729);
//     // set the initial zoomlevel
//     viewModel.setZoomLevel(15);
//     // bonus feature: listen for long taps and add/remove a marker at the tap-positon
//     viewModel.addOverlay(_MarkerOverlay(
//         viewModel: viewModel,
//         markerDataStore: markerDataStore,
//         symbolCache: symbolCache));
//     return viewModel;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: MapviewWidget(
//         displayModel: displayModel,
//         createMapModel: _createMapModel,
//         createViewModel: _createViewModel,
//       ),
//     );
//   }
// }

// /// An overlay is just a normal widget which will be drawn on top of the map. In this case we do not
// /// draw anything but just receive long tap events and add/remove a marker to the datastore. Take note
// /// that the marker needs to be initialized (async) and afterwards added to the datastore and the
// /// setRepaint() method is called to inform the datastore about changes so that it gets repainted
// class _MarkerOverlay extends StatefulWidget {
//   final MarkerDataStore markerDataStore;

//   final ViewModel viewModel;

//   final SymbolCache symbolCache;

//   const _MarkerOverlay(
//       {required this.viewModel,
//       required this.markerDataStore,
//       required this.symbolCache});

//   @override
//   State<StatefulWidget> createState() {
//     return _MarkerOverlayState();
//   }
// }

// class _MarkerOverlayState extends State {
//   @override
//   _MarkerOverlay get widget => super.widget as _MarkerOverlay;

//   PoiMarker? _marker;
//   PoiMarker? _marker1;
//   // read data of json
//   static List<Datos_Place> registros2 = <Datos_Place>[];
//   static List<Datos_Place> vacio = <Datos_Place>[];
//   var aux;

//   // @override
//   // Widget build(BuildContext context) {
//   //   return StreamBuilder<TapEvent>(
//   //       stream: widget.viewModel.observeLongTap,
//   //       builder: (BuildContext context, AsyncSnapshot<TapEvent> snapshot) {
//   //         if (snapshot.data == null) return const SizedBox();
//   //         // if (_marker != null) {
//   //         //   widget.markerDataStore.removeMarker(_marker!);
//   //         // }

//   //         _marker = PoiMarker(
//   //             displayModel: DisplayModel(),
//   //             src: 'assets/icons/marker.svg',
//   //             height: 64,
//   //             width: 48,
//   //             latLong: snapshot.data!);

//   //         //latLong:-2.8289342737705367);

//   //         _marker!.initResources(widget.symbolCache).then((value) {
//   //           widget.markerDataStore.addMarker(_marker!);
//   //           // widget.markerDataStore.addMarker(_marker1);
//   //           widget.markerDataStore.setRepaint();
//   //         });

//   //         return const SizedBox();
//   //       });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<TapEvent>(
//         stream: widget.viewModel.observeLongTap,
//         builder: (BuildContext context, AsyncSnapshot<TapEvent> snapshot) {
//           if (snapshot.data == null) return const SizedBox();
//           cargarDatos();
//           widget.markerDataStore.setRepaint();
//           return const SizedBox();
//         });
//   }

//   Future<String> get _localPath async {
//     final directory = await getApplicationDocumentsDirectory();
//     return directory.path;
//   }

//   void cargarDatos() async {
//     Position posact = await _determinarPosicion();
//     var aux1 = await readCounter();
//     print('entro');
//   }

//   Future<File> get _localFile async {
//     final path = await _localPath;
//     return File('$path/datosJson.json');
//   }

//   ///funcion para leer datos ///////
//   Future<List<Datos_Place>> readCounter() async {
//     try {
//       final file = await _localFile;
//       // Read the file
//       final contents = await file.readAsString();
//       print('//////////////////datos del archivo////////////////////');
//       print(contents);
//       aux = json.decode(contents);
//       for (var elemento in aux) {
//         double lat = elemento['coordenadas']['latitud'];
//         double long = elemento['coordenadas']['longitud'];
//         LatLong ubi = LatLong(lat, long);
//         _marker = PoiMarker(
//             displayModel: DisplayModel(),
//             src: 'assets/icons/marker.svg',
//             height: 64,
//             width: 48,
//             latLong: ubi);
//         _marker!.initResources(widget.symbolCache).then((value) {
//           widget.markerDataStore.addMarker(_marker!);
//           widget.markerDataStore.setRepaint();
//         });
//       }
//       widget.markerDataStore.setRepaint();

//       setState(() {});
//       return jsonDecode(contents);
//     } catch (e) {
//       // If encountering an error, return 0
//       return vacio;
//     }
//   }

//   Future<Position> _determinarPosicion() async {
//     bool serviceEnable;
//     LocationPermission permission;
//     serviceEnable = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnable) {
//       return Future.error('Location service are disable');
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();

//       if (permission == LocationPermission.denied) {
//         return Future.error("Location permision denied");
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error("Location permision are permanently denied");
//     }
//     Position position = await Geolocator.getCurrentPosition();
//     return position;
//   }
// }
