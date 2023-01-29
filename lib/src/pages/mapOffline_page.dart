import 'package:mapsforge_flutter/core.dart';
import 'package:mapsforge_flutter/datastore.dart';
import 'package:mapsforge_flutter/maps.dart';
import 'package:mapsforge_flutter/marker.dart';
import 'package:mapsforge_flutter/special.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class MapsOffline extends StatefulWidget {
  const MapsOffline({super.key});

  @override
  State<MapsOffline> createState() => _MapsOfflineState();
}

class _MapsOfflineState extends State<MapsOffline> {
  var v1;
  var v2;
  var cargado = false;

  void initState() {
    () async {
      final Directory docDir = await getApplicationDocumentsDirectory();
      final String localPath = docDir.path;
      print(localPath);
      MapFile mapFile =
          await MapFile.from("$localPath/ecuador.map", null, null);
      SymbolCache symbolCache = FileSymbolCache();
      DisplayModel displayModel = DisplayModel();
      RenderTheme renderTheme =
          await RenderThemeBuilder.create(displayModel, "assets/render.xsd");
      JobRenderer jobRenderer =
          MapDataStoreRenderer(mapFile, renderTheme, symbolCache, true);
      v1 = MapModel(
        displayModel: displayModel,
        renderer: jobRenderer,
        symbolCache: symbolCache,
      );
      v2 = ViewModel(displayModel: displayModel);
      v2.setMapViewPosition(-2.9002731, -79.0069204);
      setState(() {
        cargado = true;
        print("a");
      });
    }();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      //height: 121,
      //width: 251,
      child:
          (cargado) ? FlutterMapView(mapModel: v1, viewModel: v2) : Container(),
    ));
  }
}
