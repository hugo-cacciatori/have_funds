import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:have_fund/models/user.dart';
import 'package:have_fund/widgets/custom_scaffold.dart';

class EmployeeDetails extends StatelessWidget {
  EmployeeDetails({Key? key, required this.user});

  User user;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return CustomScaffold(
      drawer: false,
      pageTitle: 'User Details',
      child: SizedBox(
        width: screenSize.width / 2,
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              color: const Color(0xffF5FFFA),
              elevation: 12,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              SelectableText(
                                'First Name : ${user.firstName}',
                              ),
                              SelectableText(
                                'Last Name : ${user.lastName}',
                              ),
                              SelectableText(
                                'Email : ${user.email}',
                              ),
                              SelectableText(
                                'Position : ${user.position}',
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  )),
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(user.id)
                    .delete()
                    .then((value) {
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                        duration: Duration(seconds: 1),
                        backgroundColor: Colors.green,
                        content: Text(
                          'User ${user.lastName} ${user.firstName} was successfully deleted',
                          style: TextStyle(color: Colors.white),
                        )));
                });
              },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: Text('Delete the employee ' +
                  user.lastName +
                  ' ' +
                  user.firstName),
            ),
          ],
        ),
      ),
    );
  }
}
