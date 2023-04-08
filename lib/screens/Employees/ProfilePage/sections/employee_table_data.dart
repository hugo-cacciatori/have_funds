
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:have_fund/screens/Common/RefundDetails/refund_detail.dart';

import '../../../../models/refund.dart';


class EmployeeTableData extends DataTableSource{

  List<Refund> data = [];
  final Function(Refund refund) openDetails;

  EmployeeTableData({Key? key, required this.data, required this.openDetails});

  @override
  DataRow? getRow(int index) {
    if(data[index].getRejectionMotive != null){
      return DataRow(
        cells: [
          DataCell(SelectableText(data[index].getDate!)),
          DataCell(SelectableText(data[index].getType!)),
          DataCell(SelectableText(data[index].getAmount!.toString()  + '€')),
          DataCell(SelectableText(data[index].getSeller!)),
          DataCell(SelectableText(data[index].getAddress!)),
          DataCell(SelectableText(data[index].getMotive!)),
          DataCell(SelectableText(data[index].getRejectionMotive!)),
          DataCell(Icon(
            Icons.search
          ), onTap: () {
            openDetails(data[index]);
          },),
        ]
      );
    } else {
      return DataRow(
        cells: [
          DataCell(SelectableText(data[index].getDate!)),
          DataCell(SelectableText(data[index].getType!)),
          DataCell(SelectableText(data[index].getAmount!.toString() + '€')),
          DataCell(SelectableText(data[index].getSeller!)),
          DataCell(SelectableText(data[index].getAddress!)),
          DataCell(SelectableText(data[index].getMotive!)),
          DataCell(Icon(
            Icons.search
          ), onTap: () {
            openDetails(data[index]);
          },),
        ]
      );
    }
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;

}