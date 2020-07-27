import 'package:alert_manager/widgets/base_widget.dart';
import 'package:flutter/material.dart';

class AlarmScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      builder: (context, sizingInformation) {
        return Center(child: DataTable(
          columns: [
            DataColumn(label: Text("Name")),
            DataColumn(label: Text("asd"))
          ],
          rows: [
            DataRow(
              cells: [
                DataCell(Text("alarma 1")),
                DataCell(Text("asd")),
              ]
            ),
            DataRow(
                cells: [
                  DataCell(Text("alarma 2")),
                  DataCell(Text("asd 2")),
                ]
            ),
          ],
        ));
      },
    );
  }
}
