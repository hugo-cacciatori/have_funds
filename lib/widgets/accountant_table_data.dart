import 'package:flutter/material.dart';

import '../models/refund.dart';

class AccountantTableData extends DataTableSource {
  List<Map<String, dynamic>> data;
  final Function(Refund refund) openDetails;

  AccountantTableData(
      {Key? key, required this.data, required this.openDetails});

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(
        Icon(Icons.search),
        onTap: () {
          openDetails(data[index]['refund']);
        },
      ),
      // DataCell(Text(data[index]['refund'].submitterID)),
      DataCell(Text(data[index]['userName'])),
      DataCell(Text(data[index]['refund'].date)),
      DataCell(Text(data[index]['refund'].type)),
      DataCell(Text('${data[index]['refund'].amount} €')),
      DataCell(Text(data[index]['refund'].seller)),
      DataCell(Text(data[index]['refund'].address)),
      DataCell(Text(data[index]['refund'].motive)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
