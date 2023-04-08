import 'package:flutter/material.dart';
import 'package:have_fund/utils/app_graphics.dart';

import 'sections/login_form.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
                image: AppGraphics.getGraphMap['background'],
                fit: BoxFit.cover)),
        child: Center(
          child: SingleChildScrollView(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
              padding: const EdgeInsets.all(10),
              child: Card(
                color: const Color(0xffF5FFFA),
                elevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 300,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  CircleAvatar(backgroundImage: AssetImage("assets/images/havefunds.png"),
                                radius: 100,)
                                  ],
                              ),
                            ),
                            SizedBox(
                              width: 400,
                              child: LoginForm(),
                            ),
                      ]),
                      ],
                    ),),
              ),
            ),),
            
          ),
        ),
      ),
    );
  }  
}