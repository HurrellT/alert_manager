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
            DataColumn(label: Text("Source")),
            DataColumn(label: Text("Metric")),
            DataColumn(label: Text("Trigger")),
            DataColumn(label: Text("Paused")),
          ],
          rows: [
            DataRow(
              cells: [//todo: do a map with json data
                DataCell(Text("Alarm 1")),
                DataCell(Text("Server 1")),
                DataCell(Text("CPU Usage")),
                DataCell(Text(">80%")),
                DataCell(Text("True")),
              ]
            ),
            DataRow(
                cells: [
                  DataCell(Text("Alarm 2")),
                  DataCell(Text("Server 1")),
                  DataCell(Text("GPU Usage")),
                  DataCell(Text(">90%")),
                  DataCell(Text("False")),
                ]
            ),
          ],
        ));
      },
    );
  }
}
