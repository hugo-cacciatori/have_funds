import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:have_fund/constants/debug.dart';
import 'package:have_fund/pages/accountant_dashboard.dart';
import 'package:have_fund/pages/admin_dashboard.dart';
import 'package:have_fund/pages/profile_page.dart';
import '../constants/session.dart';
import '../models/user.dart';
import 'dart:math';
import '../widgets/rounded_button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (debug) {
      emailController.text = 'employé@employé.fr';
      passwordController.text = 'employé';
    }
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg.png'), fit: BoxFit.cover)),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/images/havefunds.png"),
                                        radius: 100,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 400,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "Log In",
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Form(
                                            key: formKey,
                                            child: Column(children: [
                                              TextFormField(
                                                controller: emailController,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                autofocus: false,
                                                enableSuggestions: false,
                                                autocorrect: false,
                                                decoration: InputDecoration(
                                                    hintText: "Email",
                                                    prefixIcon:
                                                        const Icon(Icons.email),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40),
                                                        borderSide:
                                                            const BorderSide(
                                                                width: 0,
                                                                style:
                                                                    BorderStyle
                                                                        .none)),
                                                    filled: true,
                                                    isDense: true,
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .fromLTRB(
                                                            10, 10, 10, 10),
                                                    fillColor:
                                                        Colors.grey[300]),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "Please enter email";
                                                  }
                                                  return null;
                                                },
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              TextFormField(
                                                controller: passwordController,
                                                obscureText: true,
                                                decoration: InputDecoration(
                                                    hintText: "Password",
                                                    prefixIcon:
                                                        const Icon(Icons.lock),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40),
                                                        borderSide:
                                                            const BorderSide(
                                                                width: 0,
                                                                style:
                                                                    BorderStyle
                                                                        .none)),
                                                    filled: true,
                                                    isDense: true,
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .fromLTRB(
                                                            10, 10, 10, 10),
                                                    fillColor:
                                                        Colors.grey[300]),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
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
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      var pwBytes = utf8.encode(
                                                          passwordController
                                                              .text);
                                                      var pwHash = sha256
                                                          .convert(pwBytes);

                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection('users')
                                                          .where('email',
                                                              isEqualTo:
                                                                  emailController
                                                                      .text)
                                                          .where('password',
                                                              isEqualTo:
                                                                  '$pwHash')
                                                          .get()
                                                          .then((value) {
                                                        if (value
                                                            .docs.isEmpty) {
                                                          ScaffoldMessenger.of(
                                                              context)
                                                            ..removeCurrentSnackBar()
                                                            ..showSnackBar(
                                                                const SnackBar(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
                                                                    content:
                                                                        Text(
                                                                      'User not found',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    )));
                                                        } else {
                                                          Session.currentUser =
                                                              User(
                                                            id: value
                                                                .docs[0].id,
                                                            companyName: value
                                                                    .docs[0]
                                                                ['companyName'],
                                                            lastName: value
                                                                    .docs[0]
                                                                ['lastName'],
                                                            firstName: value
                                                                    .docs[0]
                                                                ['firstName'],
                                                            email: value.docs[0]
                                                                ['email'],
                                                            isAccountant: value
                                                                    .docs[0][
                                                                'isAccountant'],
                                                            isAdmin:
                                                                value.docs[0]
                                                                    ['isAdmin'],
                                                          );

                                                          if (Session
                                                                  .currentUser
                                                                  .isAdmin ==
                                                              true) {
                                                            Navigator.pushAndRemoveUntil(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            AdminDashboard()),
                                                                (route) =>
                                                                    false);
                                                          } else if (Session
                                                                  .currentUser
                                                                  .isAccountant ==
                                                              true) {
                                                            Navigator.pushAndRemoveUntil(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            AccountantDashboard()),
                                                                (route) =>
                                                                    false);
                                                          } else {
                                                            Navigator.pushAndRemoveUntil(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            ProfilePage()),
                                                                (route) =>
                                                                    false);
                                                          }
                                                        }
                                                      }).catchError((error,
                                                              stackTrace) {
                                                        print(error);
                                                      });
                                                    }
                                                  })
                                            ])),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                        ],
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      var pwBytesAdmin = utf8.encode('admin');
                      var pwHashAdmin = sha256.convert(pwBytesAdmin);

                      var pwBytesEmploye = utf8.encode('employé');
                      var pwHashEmploye = sha256.convert(pwBytesEmploye);

                      var pwBytesComptable = utf8.encode('comptable');
                      var pwHashComptable = sha256.convert(pwBytesComptable);

                      List<Map<String, dynamic>> userData = [
                        {
                          'firstName': 'Hugo',
                          'lastName': 'Cacciatori',
                          'isAdmin': true,
                          'companyName': 'HaveFunds!',
                          'email': 'admin@admin.fr',
                          'isAccountant': false,
                          'password': '${pwHashAdmin}'
                        },
                        {
                          'firstName': 'Joseph',
                          'lastName': 'Laugier',
                          'isAdmin': false,
                          'isAccountant': true,
                          'companyName': 'Google',
                          'email': 'comptable@comptable.fr',
                          'password': '${pwHashComptable}'
                        },
                        {
                          'firstName': 'Thomas',
                          'lastName': 'Belaidi',
                          'isAdmin': false,
                          'companyName': 'Google',
                          'email': 'employé@employé.fr',
                          'isAccountant': false,
                          'password': '${pwHashEmploye}',
                        },
                        {
                          'firstName': 'Tristan',
                          'lastName': 'Dessis-Geay',
                          'isAdmin': false,
                          'companyName': 'Google',
                          'email': 'tristan@tristan.fr',
                          'isAccountant': false,
                          'password': '123456'
                        },
                        {
                          'firstName': 'Loane',
                          'lastName': 'Aviles',
                          'isAdmin': false,
                          'companyName': 'Google',
                          'email': 'loane@loane.fr',
                          'isAccountant': false,
                          'password': '123456'
                        },
                      ];

                      await FirebaseFirestore.instance
                          .collection('users')
                          .get()
                          .then((snapshot) {
                        for (var ds in snapshot.docs) {
                          ds.reference.delete();
                        }
                      });

                      await FirebaseFirestore.instance
                          .collection('refunds')
                          .get()
                          .then((snapshot) {
                        for (var ds in snapshot.docs) {
                          ds.reference.delete();
                        }
                      });

                      for (var element in userData) {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .add(element);
                      }

                      await FirebaseFirestore.instance
                          .collection('users')
                          .where('isAdmin', isEqualTo: false)
                          .where('isAccountant', isEqualTo: false)
                          .get()
                          .then((snapshot) async {
                        var random = Random();

                        List<Map<String, dynamic>> refundData = [
                          {
                            'userID': snapshot
                                .docs[random.nextInt(snapshot.docs.length)].id,
                            'date': '06/11/2020',
                            'type': 'Nuit d\'hôtel',
                            'amount': 55,
                            'motive': 'Voyage pro',
                            'seller': 'Ibis',
                            'address': 'non renseigné',
                            'validated': true,
                            'rejected': false,
                            'rejectionMotive': 'non spécifié'
                          },
                          {
                            'userID': snapshot
                                .docs[random.nextInt(snapshot.docs.length)].id,
                            'date': '30/05/2019',
                            'type': 'Carburant',
                            'amount': 34,
                            'motive': 'Voyage pro',
                            'seller': 'Total',
                            'address': 'non renseigné',
                            'validated': true,
                            'rejected': false,
                            'rejectionMotive': 'non spécifié'
                          },
                          {
                            'userID': snapshot
                                .docs[random.nextInt(snapshot.docs.length)].id,
                            'date': '28/03/2022',
                            'type': 'Vêtements',
                            'amount': 70,
                            'motive': 'Réunion pro',
                            'seller': 'non renseigné',
                            'address': 'non renseigné',
                            'validated': false,
                            'rejected': true,
                            'rejectionMotive': 'non spécifié'
                          },
                          {
                            'userID': snapshot
                                .docs[random.nextInt(snapshot.docs.length)].id,
                            'date': '15/01/2023',
                            'type': 'Ticket avion',
                            'amount': 500,
                            'motive': 'Voyage pro',
                            'seller': 'Air France',
                            'address': 'non renseigné',
                            'validated': false,
                            'rejected': true,
                            'rejectionMotive': 'non spécifié'
                          },
                          {
                            'userID': snapshot
                                .docs[random.nextInt(snapshot.docs.length)].id,
                            'date': '11/09/2018',
                            'type': 'Réparation auto',
                            'amount': 300,
                            'motive': 'Voyage pro',
                            'seller': 'non renseigné',
                            'address': 'non renseigné',
                            'validated': false,
                            'rejected': false,
                            'rejectionMotive': 'non spécifié'
                          },
                          {
                            'userID': snapshot
                                .docs[random.nextInt(snapshot.docs.length)].id,
                            'date': '02/02/2022',
                            'type': 'Restaurant',
                            'amount': 90,
                            'motive': 'Reunion',
                            'seller': 'non renseigné',
                            'address': 'non renseigné',
                            'validated': false,
                            'rejected': false,
                            'rejectionMotive': 'non spécifié'
                          },
                          {
                            'userID': snapshot
                                .docs[random.nextInt(snapshot.docs.length)].id,
                            'date': '01/06/2023',
                            'type': 'Carburant',
                            'amount': 60,
                            'motive': 'Voyage pro',
                            'seller': 'Total',
                            'address': 'non renseigné',
                            'validated': false,
                            'rejected': false,
                            'rejectionMotive': 'non spécifié'
                          },
                          {
                            'userID': snapshot
                                .docs[random.nextInt(snapshot.docs.length)].id,
                            'date': '29/04/2016',
                            'type': 'Carburant',
                            'amount': 67,
                            'motive': 'Voyage pro',
                            'seller': 'Total',
                            'address': 'non renseigné',
                            'validated': false,
                            'rejected': false,
                            'rejectionMotive': 'non spécifié'
                          },
                          {
                            'userID': snapshot
                                .docs[random.nextInt(snapshot.docs.length)].id,
                            'date': '01/04/2020',
                            'type': 'Carburant',
                            'amount': 57,
                            'motive': 'Voyage pro',
                            'seller': 'Total',
                            'address': 'non renseigné',
                            'validated': false,
                            'rejected': false,
                            'rejectionMotive': 'non spécifié'
                          },
                        ];

                        for (var element in refundData) {
                          await FirebaseFirestore.instance
                              .collection('refunds')
                              .add(element);
                        }
                      }).then((value) {
                        print('all data added');
                      }).onError((error, stackTrace) {
                        print(error);
                      });
                    },
                    child: Text('Populate'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
