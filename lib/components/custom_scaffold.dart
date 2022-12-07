
import 'package:flutter/material.dart';

import '../utils/app_graphics.dart';
import 'nav_drawer.dart';

class CustomScaffold extends StatelessWidget{
  String pageTitle = "";
  Widget child;
  CustomScaffold({super.key, required this.pageTitle, required this.child} );


  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle, style: TextStyle(color: Color(AppGraphics.getGraphMap['title']))),
        centerTitle: true,
        backgroundColor: Color(AppGraphics.getGraphMap['appbar']),
        elevation: 0,
      ),
        drawer: NavDrawer(),
        body: Container(decoration: BoxDecoration(image: DecorationImage(
                image: AppGraphics.getGraphMap['background'],
                fit: BoxFit.cover)),
        child: Center(
          child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(child: child))
        ),

        )
  );
  }
}