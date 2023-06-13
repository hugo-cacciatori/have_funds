class Refund {
  String id;
  String submitterID;
  String date;
  String type;
  double amount;
  String seller;
  String address;
  String motive;
  String rejectionMotive;
  String status;
  bool validated;
  bool rejected;

  Refund(
      {required this.id,
      required this.submitterID,
      required this.date,
      required this.type,
      required this.amount,
      required this.seller,
      required this.address,
      required this.motive,
      required this.rejectionMotive,
      required this.validated,
      required this.rejected,
      required this.status}) {
    if (validated == true) {
      status = 'validated';
    } else if (rejected == true) {
      status = 'rejected';
    } else {
      status = 'pending';
    }
  }
}
