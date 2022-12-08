import 'package:flutter/material.dart';

class BtnNavigation extends StatefulWidget {
  final Function currentIndex;
  const BtnNavigation({super.key, required this.currentIndex});

  @override
  State<BtnNavigation> createState() => _BtnNavigationState();
}

class _BtnNavigationState extends State<BtnNavigation> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: (int i) {
        setState(() {});
        index = i;
        widget.currentIndex(i);
      },
      type: BottomNavigationBarType.fixed,
      iconSize: 25.0,
      selectedFontSize: 14.0,
      selectedItemColor: Colors.amber[700],
      unselectedFontSize: 10.0,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Explorar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map_outlined),
          label: 'Mapas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.route_sharp),
          label: 'Rutas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
    );
  }
}
