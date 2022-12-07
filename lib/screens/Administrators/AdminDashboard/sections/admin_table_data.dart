

import 'package:flutter/material.dart';
import '../../../../models/user_model.dart';


class AdminTableData extends DataTableSource{

  List<UserModel> data = [];
  final Function(UserModel user) openDetails;

  AdminTableData({Key? key, required this.data, required this.openDetails});

  @override
  DataRow? getRow(int index) {
    
      return DataRow(
        cells: [
          DataCell(SelectableText(data[index].getLastName)),
          DataCell(SelectableText(data[index].getFirstName)),
          DataCell(SelectableText(data[index].getEmail)),
          DataCell(SelectableText(data[index].getPosition!)),
          DataCell(Icon(
            Icons.search
          ), onTap: () {
            openDetails(data[index]);
          },),
        ]
      );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;

}