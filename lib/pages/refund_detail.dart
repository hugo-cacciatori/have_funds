import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:have_fund/widgets/custom_scaffold.dart';
import '../constants/session.dart';
import '../models/refund.dart';

class RefundDetails extends StatefulWidget {
  RefundDetails({Key? key, required this.refund});

  Refund refund;
  @override
  State<StatefulWidget> createState() => _RefundDetailsState();
}

class _RefundDetailsState extends State<RefundDetails> {
  @override
  Widget build(BuildContext context) {
    if (widget.refund.status == 'rejected' &&
        Session.currentUser.position != 'Accountant') {
      return CustomScaffold(
        drawer: false,
        pageTitle: 'Refund Inquiry Details',
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              color: const Color(0xffF5FFFA),
              elevation: 12,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Date : ${widget.refund.date}',
                              ),
                              Text(
                                'Type : ${widget.refund.type}',
                              ),
                              Text(
                                'Amount : ${widget.refund.amount} €',
                              ),
                              Text(
                                'Seller : ${widget.refund.seller}',
                              ),
                              Text(
                                'Address : ${widget.refund.address}',
                              ),
                              Text(
                                'Motive : ${widget.refund.motive}',
                              ),
                              RichText(
                                  text: TextSpan(text: 'Status : ', children: [
                                TextSpan(
                                  text: widget.refund.status,
                                )
                              ])),
                              Text(
                                'Rejection Motive : ${widget.refund.rejectionMotive}',
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  )),
            ),
          ],
        ),
      );
    } else {
      if (Session.currentUser.position == 'Accountant') {
        return CustomScaffold(
          drawer: false,
          pageTitle: 'Refund Inquiry Details',
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                color: const Color(0xffF5FFFA),
                elevation: 12,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 40),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                SelectableText(
                                  'Date : ${widget.refund.date}',
                                ),
                                SelectableText(
                                  'Type : ${widget.refund.type}',
                                ),
                                SelectableText(
                                  'Amount : ${widget.refund.amount} €',
                                ),
                                SelectableText(
                                  'Seller : ${widget.refund.seller}',
                                ),
                                SelectableText(
                                  'Address : ${widget.refund.address}',
                                ),
                                SelectableText(
                                  'Motive : ${widget.refund.motive}',
                                ),
                                SelectableText.rich(
                                    TextSpan(text: 'Status : ', children: [
                                  TextSpan(
                                    text: widget.refund.status,
                                  )
                                ])),
                              ],
                            )
                          ],
                        )
                      ],
                    )),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('refunds')
                          .doc(widget.refund.id)
                          .set({
                        'validated': true,
                        'rejected': false,
                      }, SetOptions(merge: true)).then((value) {
                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(const SnackBar(
                              duration: Duration(seconds: 1),
                              backgroundColor: Colors.green,
                              content: Text(
                                'Refund validated',
                                style: TextStyle(color: Colors.white),
                              )));
                        setState(() {
                          widget.refund.validated = true;
                          widget.refund.rejected = false;
                        });
                      }).catchError(
                        (error) {
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(const SnackBar(
                                duration: Duration(seconds: 1),
                                backgroundColor: Colors.red,
                                content: Text(
                                  'Refund validation failure',
                                  style: TextStyle(color: Colors.white),
                                )));
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: Text('Validate'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('refunds')
                          .doc(widget.refund.id)
                          .set({
                        'validated': false,
                        'rejected': true,
                      }, SetOptions(merge: true)).then((value) {
                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(const SnackBar(
                              duration: Duration(seconds: 1),
                              backgroundColor: Colors.green,
                              content: Text(
                                'Refund rejected',
                                style: TextStyle(color: Colors.white),
                              )));
                        setState(() {
                          widget.refund.validated = false;
                          widget.refund.rejected = true;
                        });
                      }).catchError(
                        (error) {
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(const SnackBar(
                                duration: Duration(seconds: 1),
                                backgroundColor: Colors.red,
                                content: Text(
                                  'Refund rejection failure',
                                  style: TextStyle(color: Colors.white),
                                )));
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: Text('Reject'),
                  ),
                ],
              ),
            ],
          ),
        );
      } else {
        return CustomScaffold(
          drawer: false,
          pageTitle: 'Refund Inquiry Details',
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                color: const Color(0xffF5FFFA),
                elevation: 12,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 40),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Date : ${widget.refund.date}',
                                ),
                                Text(
                                  'Type : ${widget.refund.type}',
                                ),
                                Text(
                                  'Amount : ${widget.refund.amount}',
                                ),
                                Text(
                                  'Seller : ${widget.refund.seller}',
                                ),
                                Text(
                                  'Address : ${widget.refund.address}',
                                ),
                                Text(
                                  'Motive : ${widget.refund.motive}',
                                ),
                                RichText(
                                    text:
                                        TextSpan(text: 'Status : ', children: [
                                  TextSpan(
                                    text: widget.refund.status,
                                  )
                                ])),
                              ],
                            )
                          ],
                        )
                      ],
                    )),
              ),
            ],
          ),
        );
      }
    }
  }
}
