import 'package:flutter/material.dart';
import '../models/refund.dart';

class EmployeeTableData extends DataTableSource {
  List<Refund> data = [];
  final Function(Refund refund) openDetails;

  EmployeeTableData({Key? key, required this.data, required this.openDetails});

  @override
  DataRow? getRow(int index) {
    if (data[index].rejected == true) {
      return DataRow(cells: [
        DataCell(
          Icon(Icons.search),
          onTap: () {
            openDetails(data[index]);
          },
        ),
        DataCell(SelectableText(data[index].date)),
        DataCell(SelectableText(data[index].type)),
        DataCell(SelectableText('${data[index].amount} €')),
        DataCell(SelectableText(data[index].seller)),
        DataCell(SelectableText(data[index].address)),
        DataCell(SelectableText(data[index].motive)),
        DataCell(SelectableText(data[index].rejectionMotive)),
      ]);
    } else {
      return DataRow(cells: [
        DataCell(
          Icon(Icons.search),
          onTap: () {
            openDetails(data[index]);
          },
        ),
        DataCell(SelectableText(data[index].date)),
        DataCell(SelectableText(data[index].type)),
        DataCell(SelectableText('${data[index].amount} €')),
        DataCell(SelectableText(data[index].seller)),
        DataCell(SelectableText(data[index].address)),
        DataCell(SelectableText(data[index].motive)),
      ]);
    }
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
