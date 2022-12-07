
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:have_fund/utils/services/firebase_response.dart';
import 'package:have_fund/utils/services/database_manager.dart';
import '../../models/user_model.dart';

class AuthService {

  static const String emptyMsg = "";
  
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get getCurrentUser => _firebaseAuth.currentUser;

  Future<FirebaseResponse> registerUser(
      {required String lastName,
      required String firstName,
      required String companyID,
      required bool accountant,
      required String email,
      required String password}) async {
    try {
      UserModel.addUser(password, lastName, firstName, email, companyID, accountant, false);
      return FirebaseResponse(QueryStatus.success, emptyMsg);
    } on FirebaseAuthException catch (e) {
      return FirebaseResponse(QueryStatus.error, generateErrorMessage(e.code));
    }
  }

  Future<FirebaseResponse> logIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return FirebaseResponse(QueryStatus.success, emptyMsg);
    } on FirebaseAuthException catch (e) {
      return FirebaseResponse(QueryStatus.error, generateErrorMessage(e.code));
    }
  }

  Future<FirebaseResponse> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return FirebaseResponse(QueryStatus.success, emptyMsg);
    } on FirebaseAuthException catch (e) {
      return FirebaseResponse(QueryStatus.error, generateErrorMessage(e.code));
    }
  }

  // Future logOut() async {
  //   await _firebaseAuth.signOut();
  // }



  static String generateErrorMessage(errorCode) {
    String errorMessage;
    switch (errorCode) {
      case "invalid-email":
        errorMessage = "Your email address appears to be malformed";
        break;
      case "weak-password":
        errorMessage = "Your password should be at least 6 characters";
        break;
      case "email-already-in-use":
        errorMessage = "This email address is already taken !";
        break;
      case "user-not-found":
        errorMessage = "User with this credentials does not exists";
        break;
      default:
        errorMessage = "An unexpected error occurred, please try again";
    }
    return errorMessage;
  }
}
