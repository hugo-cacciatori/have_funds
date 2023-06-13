import 'package:flutter/material.dart';
import '../models/user.dart';

class AdminTableData extends DataTableSource {
  List<User> data = [];
  final Function(User user) openDetails;

  AdminTableData({Key? key, required this.data, required this.openDetails});

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(
        Icon(Icons.search),
        onTap: () {
          openDetails(data[index]);
        },
      ),
      DataCell(SelectableText(data[index].lastName)),
      DataCell(SelectableText(data[index].firstName)),
      DataCell(SelectableText(data[index].email)),
      DataCell(SelectableText(data[index].position!)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
