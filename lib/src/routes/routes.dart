import 'package:flutter/material.dart';
import 'package:turismup/src/pages/explorer_page.dart';

import '../pages/map_page.dart';
import '../pages/profile_page.dart';
import '../pages/routes_page.dart';

class Routes extends StatelessWidget {
  final int index;
  const Routes({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [ExplorerPage(), MapPage(), RoutePage(), ProfilePage()];
    return list[index];
  }
}
