
import 'package:flutter/material.dart';

class AppGraphics {

  static final Map<String, dynamic> graphMap = {
    'appbar' : 0xFF686f9e,
    'background' : AssetImage("assets/images/bg.png"),
    'navbarImage': AssetImage('assets/images/havefunds.png'),
    'highlight' : 0xFFf0e662,
    'pending': 0xFF484a43,
    'validated': 0xFF32a852,
    'rejected': 0xFFb31e1e,
    'black' : 0xFF484a43,
    'dimmed' : 0xFFd6d6d6,
    'title' : 0xFFebeae1
  };

  static Map<String, dynamic> get getGraphMap => graphMap;

}