import 'package:flutter/material.dart';
import 'package:have_fund/components/custom_scaffold.dart';
import 'package:have_fund/components/loading.dart';
import 'package:have_fund/screens/Administrators/AdminDashboard/sections/admin_table_data.dart';
import 'package:have_fund/screens/Administrators/RegisterForm/register_form.dart';
import '../../../models/user_model.dart';
import '../../../utils/app_graphics.dart';
import '../../../utils/services/database_manager.dart';
import '../../Common/EmployeeDetail/employee_detail.dart';

class AdminDashboard extends StatefulWidget{
  
  AdminDashboard({Key? key, required this.userInfo});
  
  List<UserModel> employeeList = [];
  
  UserModel? userInfo;
  
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
    return employeeData == null ? Loading() : 
    CustomScaffold(pageTitle: 'Admin Dashboard',
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
                        source: employeeData as DataTableSource,
                        columns: [
                          DataColumn(label: Text('Last Name')),
                          DataColumn(label: Text('First Name')),
                          DataColumn(label: Text('Email')),
                          DataColumn(label: Text('Position')),
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
                          Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => RegisterForm(userInfo: widget.userInfo)),
                          (route) => false);
                        },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                              shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                          child: Text('Create an employee account.'),),
                        ],)
                  ],)
              ]
              ),    
            ],
          ),
        ),
    );
  }

  OpenDetails(UserModel user){
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => EmployeeDetails(user: user)),
        (route) => false);
  }

  Future tableDataFetch() async {
    await DatabaseManager().firestore.collection('users').get().then((doc) {
        for (var i = 0; i < doc.docs.length; i++) {
         
            widget.employeeList.add(UserModel(
              doc.docs[i].reference.id,
              doc.docs[i]['lastName'], 
              doc.docs[i]['firstName'],
              doc.docs[i]['email'],
              doc.docs[i]['companyID'],
              widget.userInfo!.getCompanyName,
              doc.docs[i]['isAccountant'],
              doc.docs[i]['isAdmin'],)
              );  
        }
    });
    setState(() {
      employeeData = AdminTableData(data: widget.employeeList, openDetails: OpenDetails);
    });
  }
}



