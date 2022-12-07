import 'package:flutter/material.dart';
import 'package:have_fund/screens/HomePage/home_page.dart';
import 'package:have_fund/screens/LandingPage/landing_page.dart';

import '../utils/app_graphics.dart';

class NavDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AppGraphics.getGraphMap['navbarImage'])),
          ),
          ListTile(
            leading: Icon(Icons.verified_user, color: Color(AppGraphics.getGraphMap['dimmed'])),
            title: Text('Profile', style: TextStyle(color: Color(AppGraphics.getGraphMap['dimmed']))),
            onTap: () => {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LandingPage()),
                  (route) => false)},
              
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Color(AppGraphics.getGraphMap['dimmed'])),
            title: Text('Logout', style: TextStyle(color: Color(AppGraphics.getGraphMap['dimmed']))),
            onTap: () => {Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                                (route) => false)},
          ),
        ],
      ),
    );
  }
}

