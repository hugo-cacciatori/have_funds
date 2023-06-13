import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:have_fund/constants/app_colors.dart';
import 'package:have_fund/constants/session.dart';
import '../widgets/custom_scaffold.dart';

class RefundForm extends StatefulWidget {
  RefundForm({Key? key});

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
    return CustomScaffold(
        drawer: false,
        pageTitle: 'Send a Refund Request',
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: boxHeight,
                      width: 1500,
                      child: TextFormField(
                        controller: dateController,
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.calendar_today,
                              color: AppColors.white,
                            ),
                            labelText: "When did the payment occur ?",
                            labelStyle: TextStyle(color: AppColors.white),
                            prefixIconColor: AppColors.white),
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
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: boxHeight,
                      width: 1500,
                      child: TextFormField(
                        controller: typeController,
                        keyboardType: TextInputType.text,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                            hintText: "What was the nature of the payment ?",
                            prefixIcon: const Icon(Icons.question_mark),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none)),
                            filled: true,
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            fillColor: Colors.grey[300]),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Payment type is required";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: boxHeight,
                      width: 1500,
                      child: TextFormField(
                        controller: amountController,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'(^\d*\.?\d*)$'))
                        ],
                        keyboardType: TextInputType.number,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                            hintText: "Amount",
                            prefixIcon: const Icon(Icons.attach_money),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none)),
                            filled: true,
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            fillColor: Colors.grey[300]),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Payment amount is required";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: boxHeight,
                      width: 1500,
                      child: TextFormField(
                        controller: sellerController,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                            hintText: "Seller's name",
                            prefixIcon: const Icon(Icons.request_page_outlined),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none)),
                            filled: true,
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            fillColor: Colors.grey[300]),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Seller's name is required";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: boxHeight,
                      width: 1500,
                      child: TextFormField(
                        controller: addressController,
                        keyboardType: TextInputType.text,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                            hintText: "Seller's Address",
                            prefixIcon: const Icon(Icons.mail),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none)),
                            filled: true,
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            fillColor: Colors.grey[300]),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Seller's address is required";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: boxHeight,
                      width: 1500,
                      child: TextFormField(
                        controller: motiveController,
                        keyboardType: TextInputType.text,
                        enableSuggestions: true,
                        autocorrect: true,
                        decoration: InputDecoration(
                            hintText: "What was the motive for this payment ?",
                            prefixIcon: const Icon(Icons.question_mark),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none)),
                            filled: true,
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                          FirebaseFirestore.instance.collection('refunds').add({
                            'submitterID': Session.currentUser.id,
                            'date': dateController.text,
                            'type': typeController.text,
                            'amount': amountController.text,
                            'seller': sellerController.text,
                            'address': addressController.text,
                            'motive': motiveController.text,
                            'validated': false,
                            'rejected': false,
                            'rejectionMotive': 'non spécifié'
                          }).then((value) {
                            ScaffoldMessenger.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(const SnackBar(
                                  duration: Duration(seconds: 1),
                                  backgroundColor: Colors.green,
                                  content: Text(
                                    'Refund successfully submitted',
                                    style: TextStyle(color: Colors.white),
                                  )));
                          }).catchError((error) {
                            print(error);
                            ScaffoldMessenger.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(const SnackBar(
                                  duration: Duration(seconds: 1),
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    'There was an error',
                                    style: TextStyle(color: Colors.white),
                                  )));
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: Text('Submit Refund Request'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
