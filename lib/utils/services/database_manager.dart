

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:have_fund/utils/services/firebase_response.dart';

import '../../models/refund.dart';

class DatabaseManager {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirebaseFirestore get getFirestore => firestore;

  Future getField(String id, String table, String field) async {
    var userFiles = await firestore.collection(table).doc(id).get();
    if(userFiles.exists){
      return userFiles[field];
    }
    return 'Failed to fetch $field from $table';
  }

  Future getData(String id, String table, String? table2) async {
    var data; 
    String endTable = '';
    if(table2 != null){
      data = await firestore.collection(table).doc(id).collection(table2).get();
      endTable = table2;
    } else {
      data = await firestore.collection(table).doc(id).get();
      endTable = table;
    }
    if(data.exists){
      return data;
    }
    return 'Attempted to fetch data from $endTable and failed.';
  }

  static Future<FirebaseResponse> storeRefundRequest (
    {required String uid, 
    required String date, 
    required String type,
    required double amount,
    required String seller, 
    required String address,
    required String motive}) async {
      try {
        Refund.addRefund(uid, date, type, amount, seller, address, motive);
        return FirebaseResponse(QueryStatus.success, '');
      } on FirebaseException catch (e) {
        return FirebaseResponse(QueryStatus.error, 'An error occurred !');
      }
  }

  static Future<FirebaseResponse> validateRefundRequest (
    {String? uid, 
    String? refundID}) async {
      try {
        Refund.validate(refundID!, uid!);
        return FirebaseResponse(QueryStatus.success, '');
      } on FirebaseException catch (e) {
        return FirebaseResponse(QueryStatus.error, 'An error occurred !');
      }
  }
    
  


}