


import 'package:flutter/material.dart';

import '../../../../models/refund.dart';


class AccountantTableData extends DataTableSource{

  List<Refund> data = [];
  final Function(Refund refund) openDetails;

  AccountantTableData({Key? key, required this.data, required this.openDetails});

  @override
  DataRow? getRow(int index) {
      return DataRow(
        cells: [
          DataCell(Text(data[index].getDate!)),
          DataCell(Text(data[index].getType!)),
          DataCell(Text(data[index].getAmount!.toString() + '€')),
          DataCell(Text(data[index].getSeller!)),
          DataCell(Text(data[index].getAddress!)),
          DataCell(Text(data[index].getMotive!)),
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