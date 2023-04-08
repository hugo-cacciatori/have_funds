
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/services/database_manager.dart';

class Refund {
  String? id;
  String? submitterID;
  String? date;
  String? type;
  double? amount;
  String? seller;
  String? address;
  String? motive;
  String? rejectionMotive;
  String? status;
  bool? validated;
  bool? rejected;

  Refund(this.id, this.submitterID, this.date, this.type, this.amount, this.seller, this.address, this.motive, this.rejectionMotive, this.validated, this.rejected){
    if(validated == true){
      status = 'validated';
    } else if (rejected == true){
      status = 'rejected';
    } else {
      status = 'pending';
    }
  }

  String? get getId => id;
  String? get getSubmitterID => submitterID;
  String? get getDate => date;
  String? get getType => type;
  double? get getAmount => amount;
  String? get getSeller => seller;
  String? get getAddress => address;
  String? get getMotive => motive;
  String? get getRejectionMotive => rejectionMotive;
  String? get getStatus => status;

  

  Map<String, dynamic> toJson() => {'id' : id, 'date': date, 'type': type, 'amount': amount, 'seller': seller, 'address': address, 'motive': motive, 'rejectionMotive': rejectionMotive};

  static Future addRefund(String userID, String date, String type, double amount, String seller, String address, String motive) {
		return DatabaseManager().firestore
				.collection('users')
				.doc(userID)
        .collection('refunds')
        .doc()
				.set({
            'submitterID': userID,
						'date': date,
            'type': type,
            'amount': amount,
            'seller': seller,
            'address': address,
            'motive': motive,
            'isValidated': false,
            'isRejected': false,
				})
				.then((value) => print("Refund request registered"))
				.catchError(
				(error) => print("Erreur: $error"),
		);
  }

  static Future validate (String id, String uid){
    return DatabaseManager().firestore
				.collection('users')
				.doc(uid)
        .collection('refunds')
        .doc(id)
				.set({
            'isValidated': true,
            'isRejected': false,
				},
        SetOptions(merge : true))
				.then((value) => print("Refund request validated"))
				.catchError(
				(error) => print("Erreur: $error"),
		);
  }

  static Future reject (String id, String uid, String message){
    return DatabaseManager().firestore
				.collection('users')
				.doc(uid)
        .collection('refunds')
        .doc(id)
				.set({
            'isValidated': false,
            'isRejected': true,
            'rejectionMotive': message
				},
        SetOptions(merge : true))
				.then((value) => print("Refund request validated"))
				.catchError(
				(error) => print("Erreur: $error"),
		);
  }

}