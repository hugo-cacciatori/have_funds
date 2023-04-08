import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:have_fund/components/custom_scaffold.dart';
import 'package:have_fund/components/loading.dart';
import 'package:have_fund/screens/Common/RefundDetails/refund_detail.dart';
import 'package:have_fund/screens/Employees/RefundForm/refund_form.dart';
import '../../../models/refund.dart';
import '../../../models/user_model.dart';
import '../../../utils/app_graphics.dart';
import '../../../utils/services/auth_service.dart';
import '../../../utils/services/database_manager.dart';
import 'sections/employee_table_data.dart';

class ProfilePage extends StatefulWidget{
  
  ProfilePage({Key? key, required this.userInfo});
  
  List<Refund> pendingRefunds = [];
  List<Refund> validatedRefunds = [];
  List<Refund> rejectedRefunds = [];
  
  UserModel? userInfo;
  
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
    return pendingRefundsData == null || validatedRefundsData == null || rejectedRefundsData == null ? Loading() : 
    CustomScaffold(pageTitle: 'Employee Profile',
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
          child: Column(
            children: <Widget>[
              Center(
                child: Text(
                widget.userInfo!.getFirstName + ' ' + widget.userInfo!.getLastName,
                style: TextStyle(
                    color: Color(AppGraphics.getGraphMap['highlight']),
                    letterSpacing: 2,
                    fontSize: 28,
                    fontWeight: FontWeight.bold
                ),
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
                  Text('Company',
                  style: TextStyle(
                  color: Color(AppGraphics.getGraphMap['dimmed']),
                  letterSpacing: 2
                ),
              ),
              SizedBox(height: 10),
              Text(
                widget.userInfo!.getCompanyName!,
                style: TextStyle(
                    color: Color(AppGraphics.getGraphMap['highlight']),
                    letterSpacing: 2,
                    fontSize: 28,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Position',
                style: TextStyle(
                    color: Color(AppGraphics.getGraphMap['dimmed']),
                    letterSpacing: 2
                ),
              ),
              SizedBox(height: 10),
              Text(
                widget.userInfo!.getPosition!,
                style: TextStyle(
                    color: Color(AppGraphics.getGraphMap['highlight']),
                    letterSpacing: 2,
                    fontSize: 28,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Email',
                style: TextStyle(
                    color: Color(AppGraphics.getGraphMap['dimmed']),
                    letterSpacing: 2
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.email,
                    color: Color(AppGraphics.getGraphMap['highlight']),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.userInfo!.getEmail!,
                    style: TextStyle(
                      color: Color(AppGraphics.getGraphMap['highlight']),
                      fontSize: 18,
                      letterSpacing: 1
                    ),
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
                          DataColumn(label: Text('Date')),
                          DataColumn(label: Text('Type')),
                          DataColumn(label: Text('Amount')),
                          DataColumn(label: Text('Seller')),
                          DataColumn(label: Text('Address')),
                          DataColumn(label: Text('Motive')),
                          DataColumn(label: Text('')),
                        ],
                        header: const Center(child: Text('Pending Refunds')),
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
                          Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RefundForm(userInfo: widget.userInfo)),
                                (route) => false);
                        },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                              shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                          child: Text('Request a refund'),),
                        SizedBox(width: 30),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                              shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                          child: Text('Contact an accountant'),),
                        ],)
                  ],)
              ]
              ),
              SizedBox(height: 30),
                  Container(
                    width: 1500,
                    child: PaginatedDataTable(
                          source: validatedRefundsData as DataTableSource,
                          columns: [
                            DataColumn(label: Text('Date')),
                            DataColumn(label: Text('Type')),
                            DataColumn(label: Text('Amount')),
                            DataColumn(label: Text('Seller')),
                            DataColumn(label: Text('Address')),
                            DataColumn(label: Text('Motive')),
                            DataColumn(label: Text('')),
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
                        DataColumn(label: Text('Date')),
                        DataColumn(label: Text('Type')),
                        DataColumn(label: Text('Amount')),
                        DataColumn(label: Text('Seller')),
                        DataColumn(label: Text('Address')),
                        DataColumn(label: Text('Motive')),
                        DataColumn(label: Text('rejectionMotive')),
                        DataColumn(label: Text('')),
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

  OpenDetails(Refund refund){
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => RefundDetails(refund: refund, userInfo: widget.userInfo)),
        (route) => false);
  }

  Future tableDataFetch() async {
    await DatabaseManager().firestore.collection('users').doc(AuthService().getCurrentUser!.uid).collection('refunds').get().then((doc) {
        for (var i = 0; i < doc.docs.length; i++) {
          print(doc.docs[i].reference.id);
          if(doc.docs[i]['isValidated'] == true){
            widget.validatedRefunds.add(Refund(
              doc.docs[i].reference.id,
              doc.docs[i]['submitterID'], 
              doc.docs[i]['date'], 
              doc.docs[i]['type'],
              doc.docs[i]['amount'],
              doc.docs[i]['seller'],
              doc.docs[i]['address'],
              doc.docs[i]['motive'],
              null, true, false));
          } else if (doc.docs[i]['isRejected'] == true){
            widget.rejectedRefunds.add(Refund(
              doc.docs[i].reference.id,
              doc.docs[i]['submitterID'], 
              doc.docs[i]['date'], 
              doc.docs[i]['type'],
              doc.docs[i]['amount'],
              doc.docs[i]['seller'],
              doc.docs[i]['address'],
              doc.docs[i]['motive'],
              doc.docs[i]['rejectionMotive'], false, true));
          } else {
            widget.pendingRefunds.add(Refund(
              doc.docs[i].reference.id,
              doc.docs[i]['submitterID'], 
              doc.docs[i]['date'], 
              doc.docs[i]['type'],
              doc.docs[i]['amount'],
              doc.docs[i]['seller'],
              doc.docs[i]['address'],
              doc.docs[i]['motive'],
              null, false, false),);
          }
        }
    });
    setState(() {
      pendingRefundsData = EmployeeTableData(data: widget.pendingRefunds, openDetails: OpenDetails);
      rejectedRefundsData = EmployeeTableData(data: widget.rejectedRefunds, openDetails: OpenDetails);
      validatedRefundsData = EmployeeTableData(data: widget.validatedRefunds, openDetails: OpenDetails);
    });
  }
}



