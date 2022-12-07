
import 'package:flutter/material.dart';
import 'package:have_fund/components/custom_scaffold.dart';
import 'package:have_fund/components/rounded_button.dart';
import 'package:have_fund/models/user_model.dart';
import 'package:have_fund/utils/app_graphics.dart';
import 'package:have_fund/utils/services/database_manager.dart';
import 'package:have_fund/utils/services/firebase_response.dart';

import '../../../models/refund.dart';
import '../../../utils/utils.dart';

class RefundDetails extends StatelessWidget{

  RefundDetails({Key? key, required this.refund, required this.userInfo});

  Refund? refund;
  UserModel? userInfo;

  @override
  Widget build(BuildContext context) {
    
    if (refund!.getStatus == 'rejected' && userInfo!.getPosition != 'Accountant'){
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
                    Text('Date : ${refund!.getDate}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      Text('Type : ${refund!.getType}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      Text('Amount : ${refund!.getAmount}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      Text('Seller : ${refund!.getSeller}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      Text('Address : ${refund!.getAddress}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      Text('Motive : ${refund!.getMotive}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      RichText(text:TextSpan(text:'Status : ', style: TextStyle(color: Color(AppGraphics.getGraphMap['black'])), children: [
                        TextSpan(text: refund!.getStatus, style: TextStyle(color: Color(AppGraphics.getGraphMap[refund!.getStatus])))
                      ])),
                      Text('Rejection Motive : ${refund!.getRejectionMotive}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                  ],
                )
              ],
            )
          ],)),
            
            ),
          ],),
          );
    } else {
      if(userInfo!.getPosition == 'Accountant'){
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
                    SelectableText('Date : ${refund!.getDate}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      SelectableText('Type : ${refund!.getType}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      SelectableText('Amount : ${refund!.getAmount}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      SelectableText('Seller : ${refund!.getSeller}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      SelectableText('Address : ${refund!.getAddress}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      SelectableText('Motive : ${refund!.getMotive}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      SelectableText.rich(TextSpan(text:'Status : ', style: TextStyle(color: Color(AppGraphics.getGraphMap['black'])), children: [
                        TextSpan(text: refund!.getStatus, style: TextStyle(color: Color(AppGraphics.getGraphMap[refund!.getStatus])))
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
                                // DatabaseManager.validateRefundRequest(uid: refund!.getSubmitterID, refundID: refund!.getId).then((firebaseResponse) {
                                //   if(firebaseResponse == QueryStatus.success){
                                //     Utils.showMessage(context, 'The request has been validated !', Colors.green);
                                //   } else {
                                //     Utils.showErrorMessage(context, firebaseResponse.message);
                                //   }
                                // });

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
                              //implement reject function
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
                    Text('Date : ${refund!.getDate}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      Text('Type : ${refund!.getType}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      Text('Amount : ${refund!.getAmount}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      Text('Seller : ${refund!.getSeller}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      Text('Address : ${refund!.getAddress}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      Text('Motive : ${refund!.getMotive}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                      RichText(text:TextSpan(text:'Status : ', style: TextStyle(color: Color(AppGraphics.getGraphMap['black'])), children: [
                        TextSpan(text: refund!.getStatus, style: TextStyle(color: Color(AppGraphics.getGraphMap[refund!.getStatus])))
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