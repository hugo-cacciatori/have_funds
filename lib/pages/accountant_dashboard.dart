import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:have_fund/constants/app_colors.dart';

import 'package:have_fund/pages/refund_detail.dart';
import 'package:have_fund/widgets/custom_scaffold.dart';
import '../constants/session.dart';
import '../models/refund.dart';

import '../widgets/loading.dart';
import '../widgets/accountant_table_data.dart';

class AccountantDashboard extends StatefulWidget {
  AccountantDashboard({Key? key});

  List<Map<String, dynamic>> refundList = [];

  @override
  State<StatefulWidget> createState() => _AccountantDashboardState();
}

class _AccountantDashboardState extends State<AccountantDashboard> {
  DataTableSource? refundData;

  @override
  void initState() {
    tableDataFetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return refundData == null
        ? Loading()
        : CustomScaffold(
            drawer: true,
            pageTitle: 'Accountant Dashboard',
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      Session.currentUser.firstName +
                          ' ' +
                          Session.currentUser.lastName,
                      style: TextStyle(
                          letterSpacing: 2,
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
                    SizedBox(width: 100),
                    Column(
                      children: [
                        SizedBox(
                          width: screenSize.width / 4,
                          child: PaginatedDataTable(
                            source: refundData as DataTableSource,
                            columns: [
                              DataColumn(label: Text('')),
                              // DataColumn(label: Text('Submitter ID')),
                              DataColumn(label: Text('Submitter Name')),
                              DataColumn(label: Text('Date')),
                              DataColumn(label: Text('Type')),
                              DataColumn(label: Text('Amount')),
                              DataColumn(label: Text('Seller')),
                              DataColumn(label: Text('Address')),
                              DataColumn(label: Text('Motive')),
                            ],
                            header:
                                const Center(child: Text('Pending Refunds')),
                            columnSpacing: 100,
                            horizontalMargin: 60,
                            rowsPerPage: 4,
                          ),
                        ),
                      ],
                    )
                  ]),
                ],
              ),
            ),
          );
  }

  OpenDetails(Refund refund) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => RefundDetails(refund: refund)));
  }

  Future tableDataFetch() async {
    await FirebaseFirestore.instance
        .collection('refunds')
        .get()
        .then((refundsDoc) async {
      for (int i = 0; i < refundsDoc.docs.length; i++) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(refundsDoc.docs[i]['userID'])
            .get()
            .then((userDoc) {
          if (refundsDoc.docs[i]['validated'] == false &&
              refundsDoc.docs[i]['rejected'] == false) {
            widget.refundList.add({
              'refund': Refund(
                  id: refundsDoc.docs[i].reference.id,
                  submitterID: refundsDoc.docs[i]['userID'],
                  date: refundsDoc.docs[i]['date'],
                  type: refundsDoc.docs[i]['type'],
                  amount: refundsDoc.docs[i]['amount'],
                  seller: refundsDoc.docs[i]['seller'],
                  address: refundsDoc.docs[i]['address'],
                  motive: refundsDoc.docs[i]['motive'],
                  validated: refundsDoc.docs[i]['validated'],
                  rejected: refundsDoc.docs[i]['rejected'],
                  rejectionMotive: '',
                  status: ''),
              'userName': '${userDoc['firstName']} ${userDoc['lastName']}'
            });
          }

          setState(() {
            refundData = AccountantTableData(
                data: widget.refundList, openDetails: OpenDetails);
          });
        }).catchError((error, stackTrace) {
          print(error);
        });
      }
    });
  }
}
