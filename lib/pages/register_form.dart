import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:have_fund/constants/app_colors.dart';
import 'package:have_fund/constants/debug.dart';
import 'package:have_fund/constants/session.dart';
import '../widgets/custom_scaffold.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPwdController = TextEditingController();
  bool isAccountant = debug ? true : false;
  final double boxHeight = 50;
  final double boxWidth = 300;

  @override
  Widget build(BuildContext context) {
    if (debug) {
      lastNameController.text = 'toto';
      firstNameController.text = 'tata';
      emailController.text = 'accountant@accountant.fr';
      passwordController.text = 'accountant';
      confirmPwdController.text = 'accountant';
    }
    return CustomScaffold(
      drawer: false,
      pageTitle: 'Register an employee for ' + Session.currentUser.companyName,
      child: Column(
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Text(
                          'Last Name',
                          style:
                              TextStyle(color: AppColors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      height: boxHeight,
                      width: boxWidth,
                      child: TextFormField(
                        controller: lastNameController,
                        keyboardType: TextInputType.text,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                            hintText: "The employee's last name",
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none)),
                            filled: true,
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            fillColor: Colors.grey[300]),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Last name is required";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Text(
                          'First Name',
                          style:
                              TextStyle(color: AppColors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    SizedBox(
                      height: boxHeight,
                      width: boxWidth,
                      child: TextFormField(
                        controller: firstNameController,
                        keyboardType: TextInputType.text,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                            hintText: "The employee's first name",
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none)),
                            filled: true,
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            fillColor: Colors.grey[300]),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "First name is required";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Text(
                          'Email',
                          style:
                              TextStyle(color: AppColors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    SizedBox(
                      height: boxHeight,
                      width: boxWidth,
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.text,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                            hintText: "The employee's email",
                            prefixIcon: const Icon(Icons.mail),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none)),
                            filled: true,
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            fillColor: Colors.grey[300]),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Your email is required";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Text(
                          'Password',
                          style:
                              TextStyle(color: AppColors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    SizedBox(
                      height: boxHeight,
                      width: boxWidth,
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                            hintText: "Enter your password",
                            prefixIcon: const Icon(Icons.key),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none)),
                            filled: true,
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            fillColor: Colors.grey[300]),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Text(
                          'Confirm Password',
                          style:
                              TextStyle(color: AppColors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    SizedBox(
                      height: boxHeight,
                      width: boxWidth,
                      child: TextFormField(
                        controller: confirmPwdController,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Confirm Password",
                            prefixIcon: const Icon(Icons.key),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none)),
                            filled: true,
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            fillColor: Colors.grey[300]),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Confirm Password is required";
                          } else if (value != passwordController.text) {
                            return "Password & Confirm Password should match";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: boxHeight,
                  width: boxWidth,
                  child: CheckboxListTile(
                    checkColor: AppColors.black,
                    activeColor: AppColors.white,
                    value: isAccountant,
                    title: Text(
                      "Register as Accountant",
                      style: TextStyle(color: AppColors.white),
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        if (isAccountant == true) {
                          isAccountant = false;
                        } else {
                          isAccountant = true;
                        }
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      var pwBytes = utf8.encode(passwordController.text);
                      var pwHash = sha256.convert(pwBytes);

                      await FirebaseFirestore.instance.collection('users').add({
                        'lastName': lastNameController.text,
                        'firstName': firstNameController.text,
                        'companyName': Session.currentUser.companyName,
                        'email': emailController.text,
                        'password': '$pwHash',
                        'isAccountant': isAccountant,
                        'isAdmin': false,
                      }).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'The user ${lastNameController.text} ${firstNameController.text} has been successfuly registered !',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.green,
                        ));
                      }).catchError((error, stackTrace) {
                        print(error);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Firebase Error',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ));
                      });
                    } else {
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(const SnackBar(
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.red,
                            content: Text(
                              'Invalid fields',
                              style: TextStyle(color: Colors.white),
                            )));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Text('Register User'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
