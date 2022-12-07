
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:have_fund/components/loading.dart';
import 'package:have_fund/screens/Accountants/AccontantDashboard/accountant_dashboard.dart';
import '../../models/refund.dart';
import '../../models/user_model.dart';
import '../../utils/services/auth_service.dart';
import '../../utils/services/database_manager.dart';
import '../Employees/ProfilePage/profile_page.dart';
import '../administrators/AdminDashboard/admin_dashboard.dart';


class LandingPage extends StatelessWidget{

  UserModel? userInfo;
  bool isAdmin = false;
  bool isAccountant = false;
  List<Refund> pendingRefunds = [];
  List<Refund> validatedRefunds = [];
  List<Refund> rejectedRefunds = [];

  Future updateUserInfo() async {
    await DatabaseManager().firestore.collection('users').doc(AuthService().getCurrentUser!.uid).get().then((userDoc) async {
      await DatabaseManager().firestore.collection('companies').doc(userDoc['companyID']).get().then((companyDocs) async {
        userInfo = UserModel(
          AuthService().getCurrentUser!.uid, 
          userDoc['lastName'], userDoc['firstName'], 
          userDoc['email'],userDoc['companyID'], 
          companyDocs['name'], userDoc['isAccountant'], 
          userDoc['isAdmin']
        );

      });
    });
        if(userInfo!.getIsAdmin == true){
          isAdmin = true;
        } else if (userInfo!.getIsAccountant == true){
          isAccountant = true;
        }
        
  }

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(
      future: updateUserInfo(),
      builder: (context, snapshot) {
        if(snapshot.connectionState != ConnectionState.done){
          return Loading();
        } else {
          if(isAdmin == true){
              return AdminDashboard(userInfo: userInfo);
            } else if (isAccountant == true){
              return AccountantDashboard(userInfo: userInfo);
            }
            return ProfilePage(userInfo: userInfo);  
        }
      }
    );
  }
}