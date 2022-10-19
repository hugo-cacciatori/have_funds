import 'package:flutter/material.dart';
import 'package:have_fund/components/mobile_layout.dart';
import 'package:have_fund/components/responsive_layout.dart';
import 'package:have_fund/components/web_layout.dart';
import 'package:have_fund/screens/welcome/login_register_buttons.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        webChild: WebLayout(
          imageWidget: Image.asset(
            "assets/images/welcome.jpg",
            width: 250,
            height: 250,
          ),
          dataWidget:
              const LoginRegisterButtons(), //Lets define separate widget for login & signup buttons
        ),
        mobileChild: MobileLayout(
          imageWidget: Image.asset(
            "assets/images/welcome.jpg", // lets configure assets in pubspec.yaml file
            height: 150,
          ),
          dataWidget: const LoginRegisterButtons(),
        ));
  }
}
