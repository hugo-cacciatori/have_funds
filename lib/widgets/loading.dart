import 'package:flutter/material.dart';

import 'custom_scaffold.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        drawer: false,
        pageTitle: 'Loading...',
        child: CircularProgressIndicator());
  }
}
