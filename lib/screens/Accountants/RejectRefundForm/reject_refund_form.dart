

import 'package:flutter/cupertino.dart';
import 'package:have_fund/components/custom_scaffold.dart';

import '../../../models/refund.dart';
import '../../../models/user_model.dart';

class RejectRefundForm extends StatefulWidget{

  RejectRefundForm({Key? key, required this.userInfo, required this.refund});

  UserModel? userInfo;
  Refund? refund;

  @override
  State<StatefulWidget> createState() => _RejectRefundFormState();
}


class _RejectRefundFormState extends State<RejectRefundForm> {

  @override
  Widget build(BuildContext context) {

    return CustomScaffold(pageTitle: 'Reject a Refund', 
    child: Container()
    
    
    
    );
  }
}