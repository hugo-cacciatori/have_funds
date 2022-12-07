
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:have_fund/utils/services/database_manager.dart';

class UserModel {

  late String uid;
  late String lastName;
  late String firstName;
  late String email;
  late String companyID;
  late String companyName;
  late bool isAccountant;
  late bool isAdmin;
  late String? position;

UserModel(this.uid, this.lastName, this.firstName, this.email, this.companyID, this.companyName, this.isAccountant, this.isAdmin){
    if(isAdmin == true) {
      position = 'Administrator';
    } else if (isAccountant == true) {
      position = 'Accountant';
    } else {
      position = 'Employee';
    }
  }

  String get getUid => uid;
  String get getLastName => lastName;
  String get getFirstName => firstName;
  String get getEmail => email;
  String get getCompanyID => companyID;
  String get getCompanyName => companyName;
  bool get getIsAccountant => isAccountant;
  bool get getIsAdmin => isAdmin;
  String? get getPosition => position;


  static Future addUser(String password, String lastName, String firstName, String email, String companyID, bool accountant, bool admin) {
		return DatabaseManager().firestore
				.collection('users_registrations')
				.doc()
				.set({
						'lastName': lastName,
						'firstName': firstName,
            'email' : email,
            'companyID': companyID,
            'isAccountant' : accountant,
            'isAdmin' : admin,
            'password' : password
				})
				.then((value) => print("User registered"))
				.catchError(
				(error) => print("Erreur: $error"),
		);
  }

  
}