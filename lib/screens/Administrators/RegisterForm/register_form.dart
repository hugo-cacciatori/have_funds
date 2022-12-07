
import 'package:flutter/material.dart';
import 'package:have_fund/components/custom_scaffold.dart';
import 'package:have_fund/utils/services/firebase_response.dart';
import 'package:have_fund/utils/services/auth_service.dart';
import 'package:have_fund/utils/services/database_manager.dart';
import 'package:have_fund/utils/utils.dart';

import '../../../models/user_model.dart';
import '../../../utils/app_graphics.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key? key, required this.userInfo}) : super(key: key);
  UserModel? userInfo;

  @override
  State<StatefulWidget> createState() => _RegisterFormState();

}

class _RegisterFormState extends State<RegisterForm> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController pwdTextController = TextEditingController();
  final TextEditingController confirmPwdTextController = TextEditingController();
  bool isAccountant = false;
  final double boxHeight = 50; 


  @override
  Widget build(BuildContext context) {
    return CustomScaffold(pageTitle: 'Register an employee for ' + widget.userInfo!.getCompanyName,
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
                  children: [Text('Last Name', style: TextStyle(color: Color(AppGraphics.getGraphMap['dimmed']))),SizedBox(width: 1410, height: 30)],),
                 SizedBox(
                  height: boxHeight,
                  width: 1500,
                  child:TextFormField(
                  controller: lastNameController,
                  keyboardType: TextInputType.text,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                      hintText: "Enter your last name",
                      hintStyle: TextStyle(color: Color(AppGraphics.getGraphMap['black'])),
                      prefixIcon: const Icon(Icons.person),
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
                      return "Last name is required";
                    }
                    return null;
                  },
                ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text('First Name', style: TextStyle(color: Color(AppGraphics.getGraphMap['dimmed']))),SizedBox(width: 1410, height: 30)],),
                 SizedBox(
                  height: boxHeight,
                  width: 1500,
                  child:TextFormField(
                  controller: firstNameController,
                  keyboardType: TextInputType.text,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                      hintText: "Enter your first name",
                      hintStyle: TextStyle(color: Color(AppGraphics.getGraphMap['black'])),
                      prefixIcon: const Icon(Icons.person),
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
                      return "First name is required";
                    }
                    return null;
                  },
                ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text('Email', style: TextStyle(color: Color(AppGraphics.getGraphMap['dimmed']))),SizedBox(width: 1410, height: 30)],),
                 SizedBox(
                  height: boxHeight,
                  width: 1500,
                  child:TextFormField(
                  controller: emailTextController,
                  keyboardType: TextInputType.text,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                      hintText: "Enter your email address",
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
                      return "Your email is required";
                    }
                    return null;
                  },
                ),
                ),Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text('Password', style: TextStyle(color: Color(AppGraphics.getGraphMap['dimmed']))),SizedBox(width: 1410, height: 30)],),
                 SizedBox(
                  height: boxHeight,
                  width: 1500,
                  child:TextFormField(
                  obscureText: true,
                  controller: pwdTextController,
                  keyboardType: TextInputType.text,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                      hintText: "Enter your password",
                      hintStyle: TextStyle(color: Color(AppGraphics.getGraphMap['black'])),
                      prefixIcon: const Icon(Icons.key),
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
                      return "Password is required";
                    }
                    return null;
                  },
                ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text('Confirm password', style: TextStyle(color: Color(AppGraphics.getGraphMap['dimmed']))),SizedBox(width: 1410, height: 30)],),
                  SizedBox(
                  height: boxHeight,
                  width: 1500,
                  child:
                TextFormField(
                  controller: confirmPwdTextController,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Confirm Password",
                      prefixIcon: const Icon(Icons.key),
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
                      return "Confirm Password is required";
                    } else if (value != pwdTextController.text) {
                      return "Password & Confirm Password should match";
                    }
                    return null;
                  },
                ),),
                SizedBox(
                  height: boxHeight,
                  width: 1500,
                  child:CheckboxListTile(
                  value: isAccountant,
                  title: Text("Register as Accountant"),
                  onChanged: (newValue) {
                    setState(() {
                      if(isAccountant == true){
                        isAccountant = false;
                      } else {
                        isAccountant = true;
                      }
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                ),
                ),
                
                ElevatedButton(
                          onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        AuthService()
                            .registerUser(
                                lastName: lastNameController.text,
                                firstName: firstNameController.text,
                                companyID: widget.userInfo!.companyID,
                                accountant: isAccountant,
                                email: emailTextController.text,
                                password: pwdTextController.text)
                            .then((firebaseResponse) {
                          if (firebaseResponse.queryStatus == QueryStatus.success) {
                            Utils.showMessage(context, 'The user ${lastNameController.text} ${firstNameController.text} has been successfuly registered !', Colors.cyan);
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
                          child: Text('Register User'),),
              ],
            ),
          ),
        ],
      ),
    ));
    
    
    
  }
}