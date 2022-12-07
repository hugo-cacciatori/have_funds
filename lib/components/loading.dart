


import 'package:flutter/material.dart';
import 'package:have_fund/components/custom_scaffold.dart';
import 'package:have_fund/utils/app_graphics.dart';

class Loading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(pageTitle: 'Loading...',
    child: CircularProgressIndicator(color: Color(AppGraphics.getGraphMap['highlight'])));
  }
}