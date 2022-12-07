
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:have_fund/components/custom_scaffold.dart';
import 'package:have_fund/components/rounded_button.dart';
import 'package:have_fund/utils/app_graphics.dart';
import 'package:have_fund/utils/services/database_manager.dart';
import '../../../models/refund.dart';
import '../../../models/user_model.dart';
import '../../../utils/services/firebase_response.dart';
import '../../../utils/utils.dart';



class RefundForm extends StatefulWidget {

  RefundForm({Key? key, required this.userInfo});
  UserModel? userInfo;

  @override
  State<StatefulWidget> createState() => _RefundFormState();
}

class _RefundFormState extends State<RefundForm> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController sellerController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController motiveController = TextEditingController();
  final double boxHeight = 50; 

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null) {
      String formattedDate = formatDate(pickedDate, [dd, '/', mm, '/', yyyy]);
    
      setState(() {
        dateController.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(pageTitle: 'Send a Refund Request',
      child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text('Date', style: TextStyle(color: Color(AppGraphics.getGraphMap['dimmed']))),SizedBox(width: 1465,)],),
                
                SizedBox(
                  height: boxHeight,
                  width: 1500,
                  child: TextFormField(
                  controller: dateController, 
                  decoration: InputDecoration( 
                    iconColor: Color(AppGraphics.getGraphMap['dimmed']),
                    icon: Icon(Icons.calendar_today),
                    labelText: "When did the payment occur ?",
                    labelStyle: TextStyle(color: Color(AppGraphics.getGraphMap['dimmed']))
                    ),
                  readOnly: true,
                  onTap: () async {
                    _selectDate(context);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Payment date is required";
                    }
                    return null;
                  },
                ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text('Payment type', style: TextStyle(color: Color(AppGraphics.getGraphMap['dimmed']))),SizedBox(width: 1410, height: 30)],),
                 SizedBox(
                  height: boxHeight,
                  width: 1500,
                  child:TextFormField(
                  controller: typeController,
                  keyboardType: TextInputType.text,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                      hintText: "What was the nature of the payment ?",
                      hintStyle: TextStyle(color: Color(AppGraphics.getGraphMap['black'])),
                      prefixIcon: const Icon(Icons.question_mark),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none)),
                      filled: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      fillColor: Colors.grey[300]),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Payment type is required";
                    }
                    return null;
                  },
                ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text('Amount', style: TextStyle(color: Color(AppGraphics.getGraphMap['dimmed']))),SizedBox(width: 1450, height: 30)],),
                 SizedBox(
                  height: boxHeight,
                  width: 1500,
                  child:TextFormField(
                  controller: amountController,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)$'))],
                  keyboardType: TextInputType.number,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                     hintStyle: TextStyle(color: Color(AppGraphics.getGraphMap['black'])),
                      hintText: "Amount",
                      prefixIcon: const Icon(Icons.attach_money),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none)),
                      filled: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      fillColor: Colors.grey[300]),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Payment amount is required";
                    }
                    return null;
                  },
                ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text('Seller\'s name', style: TextStyle(color: Color(AppGraphics.getGraphMap['dimmed']))),SizedBox(width: 1410, height: 30)],),
                 SizedBox(
                  height: boxHeight,
                  width: 1500,
                  child:TextFormField(
                  controller: sellerController,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                      hintText: "Seller's name",
                     hintStyle: TextStyle(color: Color(AppGraphics.getGraphMap['black'])),
                      prefixIcon: const Icon(Icons.request_page_outlined),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none)),
                      filled: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      fillColor: Colors.grey[300]),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Seller's name is required";
                    }
                    return null;
                  },
                ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text('Seller\'s Address', style: TextStyle(color: Color(AppGraphics.getGraphMap['dimmed']))),SizedBox(width: 1410, height: 30)],),
                 SizedBox(
                  height: boxHeight,
                  width: 1500,
                  child:TextFormField(
                  controller: addressController,
                  keyboardType: TextInputType.text,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                      hintText: "Seller's Address",
                     hintStyle: TextStyle(color: Color(AppGraphics.getGraphMap['black'])),
                      prefixIcon: const Icon(Icons.mail),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none)),
                      filled: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      fillColor: Colors.grey[300]),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Seller's address is required";
                    }
                    return null;
                  },
                ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text('Payment Motive', style: TextStyle(color: Color(AppGraphics.getGraphMap['dimmed'])),),SizedBox(width: 1410, height: 30)],),
                 SizedBox(
                  height: boxHeight,
                  width: 1500,
                  child:TextFormField(
                  controller: motiveController,
                  keyboardType: TextInputType.text,
                  enableSuggestions: true,
                  autocorrect: true,
                  decoration: InputDecoration(
                      hintText: "What was the motive for this payment ?",
                      hintStyle: TextStyle(color: Color(AppGraphics.getGraphMap['black'])),
                      prefixIcon: const Icon(Icons.question_mark),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none)),
                      filled: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      fillColor: Colors.grey[300]),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Payment motive is required";
                    }
                    return null;
                  },
                ),
                 ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                          onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        DatabaseManager.storeRefundRequest(
                          uid: widget.userInfo!.getUid, 
                          date: dateController.text, 
                          type: typeController.text, 
                          amount: double.parse(amountController.text), 
                          seller: sellerController.text, 
                          address: addressController.text, 
                          motive: motiveController.text).then((firebaseResponse) {
                            if (firebaseResponse.queryStatus == QueryStatus.success) {
                            Utils.showMessage(context, 'The refund request has been submitted !', Colors.cyan);
                          } else {
                            Utils.showErrorMessage(
                                context, firebaseResponse.message);
                          }
                          });        
                      }
                    },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                              shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                          child: Text('Submit Refund Request'),),
              ],
            ),
          ),
        ],
      ),
    )); 
  }
}