
import 'package:flutter/material.dart';
import 'package:have_fund/components/custom_scaffold.dart';
import 'package:have_fund/components/loading.dart';

import 'package:have_fund/screens/Employees/RefundDetails/refund_detail.dart';
import '../../../models/refund.dart';
import '../../../models/user_model.dart';
import '../../../utils/app_graphics.dart';
import '../../../utils/services/database_manager.dart';
import 'sections/accountant_table_data.dart';

class AccountantDashboard extends StatefulWidget{
  
  AccountantDashboard({Key? key, required this.userInfo});
  
  List<Refund> refundList = [];
  
  UserModel? userInfo;
  
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
    return refundData == null ? Loading() : 
    CustomScaffold(pageTitle: 'Accountant Dashboard',
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
                        source: refundData as DataTableSource,
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
                  ],)
              ]
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
    await DatabaseManager().firestore
    .collection('users')
    .get()
    .then((doc) async {
        for (var i = 0; i < doc.docs.length; i++) {
            await DatabaseManager().firestore
              .collection('users')
              .doc(doc.docs[i].reference.id)
              .collection("refunds")
              .get()
              .then((refundsDoc) {
              for (var i = 0; i < refundsDoc.docs.length; i++) {
                if(refundsDoc.docs[i]['isValidated'] == false && refundsDoc.docs[i]['isRejected'] == false){
                    widget.refundList.add(Refund(
                      refundsDoc.docs[i].reference.id,
                      refundsDoc.docs[i]['submitterID'],
                      refundsDoc.docs[i]['date'], 
                      refundsDoc.docs[i]['type'],
                      refundsDoc.docs[i]['amount'],
                      refundsDoc.docs[i]['seller'],
                      refundsDoc.docs[i]['address'],
                      refundsDoc.docs[i]['motive'],
                      null, false, false)
                    );
                }
                
           }
            setState(() {
              refundData = AccountantTableData(data: widget.refundList, openDetails: OpenDetails);
            });
               }
               );
        }
    });




        
  
  }
}



