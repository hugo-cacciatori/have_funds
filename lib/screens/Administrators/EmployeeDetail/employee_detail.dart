
import 'package:flutter/material.dart';
import 'package:have_fund/components/custom_scaffold.dart';
import 'package:have_fund/models/user_model.dart';
import 'package:have_fund/utils/app_graphics.dart';

class EmployeeDetails extends StatelessWidget{

  EmployeeDetails({Key? key, required this.user});

  UserModel? user;

  @override
  Widget build(BuildContext context) {
    
      return CustomScaffold(pageTitle: 'User Details',
      child: Column(children: [
        Card(
        shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
        color: const Color(0xffF5FFFA),
                elevation: 12,
        child:Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child:Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                SelectableText('First Name : ${user!.getFirstName}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black'])),),
                SelectableText('Last Name : ${user!.getLastName}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                SelectableText('Email : ${user!.getEmail}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
                SelectableText('Position : ${user!.getPosition}', style: TextStyle(color: Color(AppGraphics.getGraphMap['black']))),
              ],
            )
          ],
        )
      ],)),
        
         ),
      ElevatedButton(
                          onPressed: () {
                          //implement delete function
                        },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                              shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                          child: Text('Delete the employee ' + user!.getLastName + ' ' +  user!.getFirstName),),
      ],),
      
      
      
      );
  }

}