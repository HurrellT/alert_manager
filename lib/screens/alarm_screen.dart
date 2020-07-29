import 'package:alert_manager/providers/alarm_provider.dart';
import 'package:alert_manager/widgets/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/alarm.dart';

class AlarmScreen extends StatefulWidget {
  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  TextEditingController _nameFilterController;
  String _statusFilter;
  Alarm _selectedAlarm;

  @override
  void initState() {
    super.initState();

    _nameFilterController = TextEditingController();
    _statusFilter = 'All';
  }

  @override
  void dispose() {
    _nameFilterController.dispose();
    super.dispose();
  }

  _createTable() {}

  _createFilters(AlarmProvider alarmsData) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 20.0, bottom: 20.0, left: 50.0, right: 50.0),
            child: TextField(
              controller: _nameFilterController,
              decoration: InputDecoration.collapsed(hintText: 'Alarm name'),
              onChanged: (value) {
                setState(() {
                  alarmsData.setFilteredAlarms(nameFilterControllerValue: value);
                });
              },
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 20.0, bottom: 20.0, left: 50.0, right: 50.0),
            child: DropdownButtonFormField(
              value: 'All',
              items: [
                DropdownMenuItem(
                  child: Text("All"),
                  value: 'All',
                ),
                DropdownMenuItem(
                  child: Text("Active"),
                  value: 'true',
                ),
                DropdownMenuItem(
                  child: Text("Paused"),
                  value: 'false',
                ),
              ],
              onChanged: (String value) {
                alarmsData.setFilteredAlarms(statusFilter: value);
              },
            ),
          ),
        )
      ],
    );
  }

  _addAlarm() {}

  _updateAlarms() {}

  _removeAlarm() {}

  @override
  Widget build(BuildContext context) {
    final alarmsData = Provider.of<AlarmProvider>(context);
    alarmsData.setFilteredAlarms(statusFilter: _statusFilter,
        nameFilterControllerValue: _nameFilterController.value.text);
    final _alarms = alarmsData.filteredAlarms;
    const _fontSize = TextStyle(fontSize: 20);

    return BaseWidget(
      builder: (context, sizingInformation) {
        return Column(
          children: [
            _createFilters(alarmsData),
            Center(
              child: alarmsData.isFetching
                  ? CircularProgressIndicator()
                  : DataTable(
                      sortColumnIndex: 0,
                      sortAscending: true,
                      columns: [
                        DataColumn(label: Text("Name")),
                        DataColumn(label: Text("Source")),
                        DataColumn(label: Text("Metric")),
                        DataColumn(label: Text("Trigger")),
                        DataColumn(label: Text("Paused")),
                      ],
                      rows: [
                        ..._alarms
                            .map((alarm) => DataRow(cells: [
                                  //todo: do a map with json data
                                  DataCell(Text(
                                    alarm.name,
                                    style: _fontSize,
                                  )),
                                  DataCell(Text(
                                    alarm.source,
                                    style: _fontSize,
                                  )),
                                  DataCell(Text(
                                      alarm.metric
                                          .toString()
                                          .split('.')
                                          .elementAt(1),
                                      style: _fontSize)),
                                  DataCell(Text(
                                      "${alarm.greater ? '>' : '<'} ${!alarm.isTemp ? '%' : ''} ${(alarm.trigger * 100).toInt()} ${alarm.isTemp ? '°C' : ''}",
                                      style: _fontSize)),
                                  DataCell(Text(alarm.isActive.toString(),
                                      style: _fontSize)),
                                ]))
                            .toList()
                      ],
                    ),
            ),
          ],
        );
      },
    );
  }
}
