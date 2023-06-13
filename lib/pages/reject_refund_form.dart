import 'package:flutter/cupertino.dart';
import 'package:have_fund/widgets/custom_scaffold.dart';

import '../models/refund.dart';

class RejectRefundForm extends StatefulWidget {
  RejectRefundForm({super.key, required this.refund});

  Refund? refund;

  @override
  State<StatefulWidget> createState() => _RejectRefundFormState();
}

class _RejectRefundFormState extends State<RejectRefundForm> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        drawer: false, pageTitle: 'Reject a Refund', child: Container());
  }
}
