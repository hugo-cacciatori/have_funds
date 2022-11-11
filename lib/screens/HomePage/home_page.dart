import 'package:flutter/material.dart';

import 'sections/login_form.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
                image: AssetImage("images/bg.png"),
                fit: BoxFit.cover)),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Card(
                color: Color(0xffF5FFFA),
                elevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                //Using LayoutBuilder for responsive UI
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
                                children: const [Image(image: AssetImage("assets/images/have_fund_logo.png"), width: 150)],
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
            ),
          ),
        ),
      ),
    );
  }  
}