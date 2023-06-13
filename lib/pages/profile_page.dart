import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:have_fund/constants/session.dart';
import 'package:have_fund/pages/refund_detail.dart';
import 'package:have_fund/pages/refund_form.dart';
import 'package:have_fund/widgets/custom_scaffold.dart';
import '../models/refund.dart';
import '../widgets/loading.dart';
import '../widgets/employee_table_data.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({
    Key? key,
  });

  List<Refund> pendingRefunds = [];
  List<Refund> validatedRefunds = [];
  List<Refund> rejectedRefunds = [];

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DataTableSource? pendingRefundsData;
  DataTableSource? validatedRefundsData;
  DataTableSource? rejectedRefundsData;

  @override
  void initState() {
    tableDataFetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return pendingRefundsData == null ||
            validatedRefundsData == null ||
            rejectedRefundsData == null
        ? Loading()
        : CustomScaffold(
            drawer: true,
            pageTitle: 'Employee Profile',
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
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Company',
                                style: TextStyle(letterSpacing: 2),
                              ),
                              SizedBox(height: 10),
                              Text(
                                Session.currentUser.companyName,
                                style: TextStyle(
                                    letterSpacing: 2,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 30),
                              Text(
                                'Position',
                                style: TextStyle(letterSpacing: 2),
                              ),
                              SizedBox(height: 10),
                              Text(
                                Session.currentUser.position as String,
                                style: TextStyle(
                                    letterSpacing: 2,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 30),
                              Text(
                                'Email',
                                style: TextStyle(letterSpacing: 2),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.email,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    Session.currentUser.email,
                                    style: TextStyle(
                                        fontSize: 18, letterSpacing: 1),
                                  ),
                                ],
                              ),
                            ]),
                        SizedBox(width: 100),
                        Column(
                          children: [
                            Container(
                              width: 1500,
                              child: PaginatedDataTable(
                                source: pendingRefundsData as DataTableSource,
                                columns: [
                                  DataColumn(label: Text('')),
                                  DataColumn(label: Text('Date')),
                                  DataColumn(label: Text('Type')),
                                  DataColumn(label: Text('Amount')),
                                  DataColumn(label: Text('Seller')),
                                  DataColumn(label: Text('Address')),
                                  DataColumn(label: Text('Motive')),
                                ],
                                header: const Center(
                                    child: Text('Pending Refunds')),
                                columnSpacing: 100,
                                horizontalMargin: 60,
                                rowsPerPage: 4,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RefundForm()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 40),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  child: Text('Request a refund'),
                                ),
                                SizedBox(width: 30),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 40),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  child: Text('Contact an accountant'),
                                ),
                              ],
                            )
                          ],
                        )
                      ]),
                  SizedBox(height: 30),
                  Container(
                    width: 1500,
                    child: PaginatedDataTable(
                      source: validatedRefundsData as DataTableSource,
                      columns: [
                        DataColumn(label: Text('')),
                        DataColumn(label: Text('Date')),
                        DataColumn(label: Text('Type')),
                        DataColumn(label: Text('Amount')),
                        DataColumn(label: Text('Seller')),
                        DataColumn(label: Text('Address')),
                        DataColumn(label: Text('Motive')),
                      ],
                      header: const Center(child: Text('Validated Refunds')),
                      columnSpacing: 100,
                      horizontalMargin: 60,
                      rowsPerPage: 4,
                    ),
                  ),
                  Container(
                    width: 1500,
                    child: PaginatedDataTable(
                      source: rejectedRefundsData as DataTableSource,
                      columns: [
                        DataColumn(label: Text('')),
                        DataColumn(label: Text('Date')),
                        DataColumn(label: Text('Type')),
                        DataColumn(label: Text('Amount')),
                        DataColumn(label: Text('Seller')),
                        DataColumn(label: Text('Address')),
                        DataColumn(label: Text('Motive')),
                        DataColumn(label: Text('rejectionMotive')),
                      ],
                      header: const Center(child: Text('Rejected Refunds')),
                      columnSpacing: 100,
                      horizontalMargin: 60,
                      rowsPerPage: 4,
                    ),
                  ),
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
        .where('userID', isEqualTo: Session.currentUser.id)
        .get()
        .then((doc) {
      for (var i = 0; i < doc.docs.length; i++) {
        Refund userRefund = Refund(
            id: doc.docs[i].reference.id,
            submitterID: doc.docs[i]['userID'],
            date: doc.docs[i]['date'],
            type: doc.docs[i]['type'],
            amount: doc.docs[i]['amount'],
            seller: doc.docs[i]['seller'],
            address: doc.docs[i]['address'],
            motive: doc.docs[i]['motive'],
            rejected: doc.docs[i]['rejected'],
            validated: doc.docs[i]['validated'],
            rejectionMotive: doc.docs[i]['rejectionMotive'],
            status: '');

        if (userRefund.validated == true) {
          widget.validatedRefunds.add(userRefund);
        } else if (userRefund.rejected == true) {
          widget.rejectedRefunds.add(userRefund);
        } else {
          widget.pendingRefunds.add(userRefund);
        }
      }
    });
    setState(() {
      pendingRefundsData = EmployeeTableData(
          data: widget.pendingRefunds, openDetails: OpenDetails);
      rejectedRefundsData = EmployeeTableData(
          data: widget.rejectedRefunds, openDetails: OpenDetails);
      validatedRefundsData = EmployeeTableData(
          data: widget.validatedRefunds, openDetails: OpenDetails);
    });
  }
}
