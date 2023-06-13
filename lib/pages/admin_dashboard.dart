import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:have_fund/constants/app_colors.dart';
import 'package:have_fund/widgets/admin_table_data.dart';
import 'package:have_fund/pages/register_form.dart';
import '../constants/session.dart';
import '../models/user.dart';
import '../widgets/custom_scaffold.dart';
import '../widgets/loading.dart';
import 'employee_detail.dart';

class AdminDashboard extends StatefulWidget {
  AdminDashboard({super.key});

  List<User> employeeList = [];

  @override
  State<StatefulWidget> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  DataTableSource? employeeData;

  @override
  void initState() {
    tableDataFetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return employeeData == null
        ? Loading()
        : CustomScaffold(
            drawer: true,
            pageTitle: 'Admin Dashboard',
            child: Column(
              children: [
                Center(
                  child: Text(
                    Session.currentUser.firstName +
                        ' ' +
                        Session.currentUser.lastName,
                    style: TextStyle(
                        letterSpacing: 2,
                        color: AppColors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(
                  height: 60,
                  color: Colors.grey[800],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Column(children: [
                    Text(
                      'Company',
                      style:
                          TextStyle(letterSpacing: 2, color: AppColors.black),
                    ),
                    SizedBox(height: 10),
                    Text(
                      Session.currentUser.companyName,
                      style: TextStyle(
                          letterSpacing: 2,
                          fontSize: 28,
                          color: AppColors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Position',
                      style:
                          TextStyle(letterSpacing: 2, color: AppColors.black),
                    ),
                    SizedBox(height: 10),
                    Text(
                      Session.currentUser.position as String,
                      style: TextStyle(
                          color: AppColors.white,
                          letterSpacing: 2,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Email',
                      style:
                          TextStyle(letterSpacing: 2, color: AppColors.black),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.email,
                          color: AppColors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          Session.currentUser.email,
                          style: TextStyle(
                              fontSize: 18,
                              letterSpacing: 1,
                              color: AppColors.white),
                        ),
                      ],
                    ),
                  ]),
                  SizedBox(width: screenSize.width / 8),
                  Column(
                    children: [
                      SizedBox(
                        width: screenSize.width / 4,
                        child: PaginatedDataTable(
                          source: employeeData as DataTableSource,
                          columns: [
                            DataColumn(label: Text('')),
                            DataColumn(label: Text('Last Name')),
                            DataColumn(label: Text('First Name')),
                            DataColumn(label: Text('Email')),
                            DataColumn(label: Text('Position')),
                          ],
                          header: const Center(child: Text('Account List')),
                          // columnSpacing: 50,
                          // horizontalMargin: 60,
                          rowsPerPage: 4,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: screenSize.width / 4,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterForm()));
                              },
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 40),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              child: Text('Create an employee account.'),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ]),
              ],
            ),
          );
  }

  OpenDetails(User user) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => EmployeeDetails(user: user)));
  }

  Future tableDataFetch() async {
    await FirebaseFirestore.instance.collection('users').get().then((doc) {
      for (var i = 0; i < doc.docs.length; i++) {
        if (doc.docs[i]['isAdmin'] == false) {
          widget.employeeList.add(User(
            id: doc.docs[i].id,
            lastName: doc.docs[i]['lastName'],
            firstName: doc.docs[i]['firstName'],
            email: doc.docs[i]['email'],
            companyName: doc.docs[i]['companyName'],
            isAccountant: doc.docs[i]['isAccountant'],
            isAdmin: doc.docs[i]['isAdmin'],
          ));
        }
      }
    });

    setState(() {
      employeeData =
          AdminTableData(data: widget.employeeList, openDetails: OpenDetails);
    });
  }
}
