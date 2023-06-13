import 'package:flutter/material.dart';
import 'package:have_fund/constants/app_colors.dart';
import 'package:have_fund/pages/accountant_dashboard.dart';
import 'package:have_fund/pages/admin_dashboard.dart';
import 'package:have_fund/pages/login_page.dart';
import 'package:have_fund/pages/profile_page.dart';

import '../constants/session.dart';

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
                    image: AssetImage('assets/images/havefunds.png'))),
          ),
          ListTile(
            leading: Icon(
              Icons.verified_user,
              color: AppColors.dimmed,
            ),
            title: Text(
              'Dashboard',
              style: TextStyle(color: AppColors.dimmed),
            ),
            onTap: () => {
              if (Session.currentUser.isAdmin == true)
                {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => AdminDashboard()),
                      (route) => false)
                }
              else if (Session.currentUser.isAccountant == true)
                {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AccountantDashboard()),
                      (route) => false)
                }
              else
                {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                      (route) => false)
                }
            },
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: AppColors.dimmed,
            ),
            title: Text(
              'Logout',
              style: TextStyle(color: AppColors.dimmed),
            ),
            onTap: () => {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false)
            },
          ),
        ],
      ),
    );
  }
}
