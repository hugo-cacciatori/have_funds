
import 'package:flutter/material.dart';
import 'package:have_fund/components/custom_scaffold.dart';
import 'package:have_fund/components/rounded_button.dart';
import 'package:have_fund/models/user_model.dart';
import 'package:have_fund/utils/app_graphics.dart';
import 'package:have_fund/utils/services/database_manager.dart';
import 'package:have_fund/utils/services/firebase_response.dart';

import '../../../models/refund.dart';
import '../../../utils/utils.dart';
import '../../Accountants/RejectRefundForm/reject_refund_form.dart';


class RefundDetails extends StatefulWidget{

  RefundDetails({Key? key, required this.refund, required this.userInfo});

  Refund? refund;
  UserModel? userInfo;
  
  @override
  State<StatefulWidget> createState() => _RefundDetailsState();
}


class _RefundDetailsState extends State<RefundDetails>{



  @override
  Widget build(BuildContext context) {
    
    if (widget.refund!.getStatus == 'rejected' && widget.userInfo!.getPosition != 'Accountant'){
      return CustomScaffold(pageTitle: 'Refund Inquiry Details',
          child: Column(children: [
            Card(
            shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
            color: const Color(0xffF5FFFA),
                    elevation: 12,
            child:Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        child:Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text('Date : ${widget.refund!.getDate}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      Text('Type : ${widget.refund!.getType}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      Text('Amount : ${widget.refund!.getAmount}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      Text('Seller : ${widget.refund!.getSeller}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      Text('Address : ${widget.refund!.getAddress}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      Text('Motive : ${widget.refund!.getMotive}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      RichText(text:TextSpan(text:'Status : ', style: TextStyle(color: Color(AppGraphics.getGraphMap['black'])), children: [
                        TextSpan(text: widget.refund!.getStatus, style: TextStyle(color: Color(AppGraphics.getGraphMap[widget.refund!.getStatus])))
                      ])),
                      Text('Rejection Motive : ${widget.refund!.getRejectionMotive}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                  ],
                )
              ],
            )
          ],)),
            
            ),
          ],),
          );
    } else {
      if(widget.userInfo!.getPosition == 'Accountant'){
        return CustomScaffold(pageTitle: 'Refund Inquiry Details',
          child: Column(children: [
            Card(
            shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
            color: const Color(0xffF5FFFA),
                    elevation: 12,
            child:Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        child:Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    SelectableText('Date : ${widget.refund!.getDate}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      SelectableText('Type : ${widget.refund!.getType}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      SelectableText('Amount : ${widget.refund!.getAmount}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      SelectableText('Seller : ${widget.refund!.getSeller}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      SelectableText('Address : ${widget.refund!.getAddress}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      SelectableText('Motive : ${widget.refund!.getMotive}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      SelectableText.rich(TextSpan(text:'Status : ', style: TextStyle(color: Color(AppGraphics.getGraphMap['black'])), children: [
                        TextSpan(text: widget.refund!.getStatus, style: TextStyle(color: Color(AppGraphics.getGraphMap[widget.refund!.getStatus])))
                      ])),
                  ],
                )
              ],
            )
          ],)),
            
            ),
            Row(children: [
              ElevatedButton(
                              onPressed: () {
                                DatabaseManager.validateRefundRequest(uid: widget.refund!.getSubmitterID, refundID: widget.refund!.getId).then((firebaseResponse) {
                                  if(firebaseResponse.queryStatus == QueryStatus.success){
                                    Utils.showMessage(context, 'The request has been validated !', Colors.green);
                                    setState(() {
                                      widget.refund = Refund(
                                        widget.refund!.getId, 
                                        widget.refund!.getSubmitterID, 
                                        widget.refund!.getDate, 
                                        widget.refund!.getType, 
                                        widget.refund!.getAmount,
                                        widget.refund!.getSeller,
                                        widget.refund!.getAddress,
                                        widget.refund!.getMotive,
                                        null,true, false
                                        );
                                    });
                                  } else {
                                    Utils.showErrorMessage(context, firebaseResponse.message);
                                  }
                                });

                            },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(AppGraphics.getGraphMap['validated']),
                                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                  shape:
                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                              child: Text('Validate'),),
                              SizedBox(width: 10),
          ElevatedButton(
                              onPressed: () {

                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RejectRefundForm(refund: widget.refund, userInfo: widget.userInfo)),
                                    (route) => false);



                              DatabaseManager.rejectRefundRequest(uid: widget.refund!.getSubmitterID, refundID: widget.refund!.getId, message: 'message').then((firebaseResponse) {
                                  if(firebaseResponse.queryStatus == QueryStatus.success){
                                    Utils.showMessage(context, 'The request has been rejected !', Colors.green);
                                    setState(() {
                                      widget.refund = Refund(
                                        widget.refund!.getId, 
                                        widget.refund!.getSubmitterID, 
                                        widget.refund!.getDate, 
                                        widget.refund!.getType, 
                                        widget.refund!.getAmount,
                                        widget.refund!.getSeller,
                                        widget.refund!.getAddress,
                                        widget.refund!.getMotive,
                                        null,false, true
                                        );
                                    });
                                  } else {
                                    Utils.showErrorMessage(context, firebaseResponse.message);
                                  }
                                });
                            },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(AppGraphics.getGraphMap['rejected']),
                                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                  shape:
                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                              child: Text('Reject'),),
            ],),
          
          ],),
          );
      } else {
        return CustomScaffold(pageTitle: 'Refund Inquiry Details',
          child: Column(children: [
            Card(
            shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
            color: const Color(0xffF5FFFA),
                    elevation: 12,
            child:Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        child:Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text('Date : ${widget.refund!.getDate}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      Text('Type : ${widget.refund!.getType}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      Text('Amount : ${widget.refund!.getAmount}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      Text('Seller : ${widget.refund!.getSeller}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      Text('Address : ${widget.refund!.getAddress}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      Text('Motive : ${widget.refund!.getMotive}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      RichText(text:TextSpan(text:'Status : ', style: TextStyle(color: Color(AppGraphics.getGraphMap['black'])), children: [
                        TextSpan(text: widget.refund!.getStatus, style: TextStyle(color: Color(AppGraphics.getGraphMap[widget.refund!.getStatus])))
                      ])),
                  ],
                )
              ],
            )
          ],)),
            
            ),
          ],),
          );
      }
    }
  }

}