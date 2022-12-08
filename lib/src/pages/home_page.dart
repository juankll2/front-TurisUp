import 'package:flutter/material.dart';
import 'package:turismup/src/routes/routes.dart';

import '../btnNavigation/bottom_navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  BtnNavigation? myBnb;
  @override
  void initState() {
    myBnb = BtnNavigation(currentIndex: (i) {
      setState(() {
        index = i;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(bottomNavigationBar: myBnb, body: Routes(index: index));
  }
}
