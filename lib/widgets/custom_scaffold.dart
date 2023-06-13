import 'package:flutter/material.dart';

import 'nav_drawer.dart';

class CustomScaffold extends StatelessWidget {
  String pageTitle = "";
  Widget child;
  bool drawer;
  CustomScaffold(
      {super.key,
      required this.pageTitle,
      required this.child,
      required this.drawer});

  @override
  Widget build(BuildContext context) {
    if (drawer) {
      return Scaffold(
          appBar: AppBar(
            title: Text(
              pageTitle,
            ),
            centerTitle: true,
            elevation: 0,
          ),
          drawer: NavDrawer(),
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/bg.png"),
                    fit: BoxFit.cover)),
            child: Center(child: SingleChildScrollView(child: child)),
          ));
    } else {
      return Scaffold(
          appBar: AppBar(
            title: Text(
              pageTitle,
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/bg.png"),
                    fit: BoxFit.cover)),
            child: Center(child: SingleChildScrollView(child: child)),
          ));
    }
  }
}
