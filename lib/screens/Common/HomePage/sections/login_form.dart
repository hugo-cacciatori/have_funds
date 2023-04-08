

import 'package:flutter/material.dart';
import 'package:have_fund/components/rounded_button.dart';
import 'package:have_fund/screens/Common/LandingPage/landing_page.dart';
import 'package:have_fund/utils/services/firebase_response.dart';
import 'package:have_fund/utils/services/auth_service.dart';
import '../../../../utils/utils.dart';

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController pwdEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    emailEditingController.text = 'ilestcomptable@oui.com';
    pwdEditingController.text = '123456';
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            "Log In",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          Form(
              key: _formKey,
              child: Column(children: [
                TextFormField(
                  controller: emailEditingController,
                  keyboardType: TextInputType.emailAddress,
                  autofocus: false,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none)),
                      filled: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      fillColor: Colors.grey[300]),
                  //Lets apply validation
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter email";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: pwdEditingController,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none)),
                      filled: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      fillColor: Colors.grey[300]),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                RoundedButton(
                    label: "LOGIN",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await AuthService().logIn(email: emailEditingController.text, password: pwdEditingController.text).then((firebaseResponse) async {
                          if (firebaseResponse.queryStatus == QueryStatus.success) {
                                Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LandingPage()),
                                (route) => false);
                          } else {
                            Utils.showErrorMessage(
                                context, firebaseResponse.message);
                          }
                        });


                      }
                    }
                )
              ])),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
