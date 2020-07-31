import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/alarm_provider.dart';
import '../model/metric_type.dart';
import '../model/alarm.dart';
import 'alarm_text_form_field.dart';

class AlarmDialog extends StatefulWidget {
  final bool editingMode;
  final Alarm alarm;

  @override
  _AlarmDialogState createState() => _AlarmDialogState();

  AlarmDialog({this.editingMode = false, this.alarm});
}

class _AlarmDialogState extends State<AlarmDialog> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _alarmNameFieldController;
  TextEditingController _alarmSourceFieldController;
  TextEditingController _triggerSourceFieldController;
  bool _isTempDropdownValue;
  bool _isActiveDropdownValue;
  bool _isGreaterDropdownValue;
  MetricType _metricTypeDropdownValue;

  @override
  void initState() {
    _alarmNameFieldController = TextEditingController();
    _alarmSourceFieldController = TextEditingController();
    _triggerSourceFieldController = TextEditingController();
    if (widget.editingMode) {
      var alarm = widget.alarm;
      _alarmNameFieldController.text = alarm.name;
      _alarmSourceFieldController.text = alarm.source;
      _triggerSourceFieldController.text = alarm.trigger.toString();
      _isTempDropdownValue = alarm.isTemp;
      _isActiveDropdownValue = alarm.isActive;
      _isGreaterDropdownValue = alarm.greater;
      _metricTypeDropdownValue = alarm.metric;
    }

    super.initState();
  }

  @override
  void dispose() {
    _alarmNameFieldController.dispose();
    _alarmSourceFieldController.dispose();
    _triggerSourceFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final alarmsData = Provider.of<AlarmProvider>(context);

    return SimpleDialog(
      title: const Text("Add alarm"),
      children: [
        Form(
            key: _formKey,
            child: Column(children: <Widget>[
              buildAlarmNameTextFormField(),
              buildAlarmSourceTextFormField(),
              buildMetricDropdownFormField(),
              buildAlarmTriggerTextFormField(),
              buildGreaterConditionDropdownFormField(),
              buildTempOrPercentageDropdownFormField(),
              buildAlarmStateDropdownFormField(),
              buildSubmitButton(alarmsData, context)
            ]))
      ],
    );
  }

  RaisedButton buildSubmitButton(
      AlarmProvider alarmsData, BuildContext context) {
    return RaisedButton(
      onPressed: () {
        widget.editingMode
            ? validateAndEditAlarm(alarmsData, context)
            : validateAndAddAlarm(alarmsData, context);
      },
      child: Text(widget.editingMode ? "Edit" : 'Add'),
    );
  }

  Padding buildAlarmStateDropdownFormField() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: DropdownButtonFormField(
        value: _isActiveDropdownValue,
        decoration: InputDecoration(hintText: "Choose an alarm state"),
        items: [
          DropdownMenuItem(
            child: Text("Active"),
            value: true,
          ),
          DropdownMenuItem(
            child: Text("Paused"),
            value: false,
          ),
        ],
        onChanged: (bool value) {
          setState(() {
            _isActiveDropdownValue = value;
          });
        },
      ),
    );
  }

  Padding buildTempOrPercentageDropdownFormField() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: DropdownButtonFormField(
        value: _isTempDropdownValue,
        decoration: InputDecoration(hintText: "Choose temp or percentage"),
        items: [
          DropdownMenuItem(
            child: Text("°C"),
            value: true,
          ),
          DropdownMenuItem(
            child: Text("%"),
            value: false,
          ),
        ],
        onChanged: (bool value) {
          setState(() {
            _isTempDropdownValue = value;
          });
        },
      ),
    );
  }

  Padding buildGreaterConditionDropdownFormField() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: DropdownButtonFormField(
        value: _isGreaterDropdownValue,
        decoration: InputDecoration(hintText: "Choose if grater or lower"),
        items: [
          DropdownMenuItem(
            child: Text(">"),
            value: true,
          ),
          DropdownMenuItem(
            child: Text("<"),
            value: false,
          ),
        ],
        onChanged: (bool value) {
          setState(() {
            _isGreaterDropdownValue = value;
          });
        },
      ),
    );
  }

  AlarmTextFormField buildAlarmTriggerTextFormField() {
    return AlarmTextFormField(
      controller: _triggerSourceFieldController,
      hintText: "Enter a trigger point as float",
      validatorText: "Please enter a trigger point as float",
      keyboardType: TextInputType.number,
    );
  }

  Padding buildMetricDropdownFormField() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: DropdownButtonFormField(
        value: _metricTypeDropdownValue,
        decoration: InputDecoration(hintText: "Choose a metric"),
        items: [
          ...MetricType.values.map((e) {
            return DropdownMenuItem(
              child: Text(MetricTypeNames[e]),
              value: e,
            );
          }).toList()
        ],
        onChanged: (MetricType value) {
          setState(() {
            _metricTypeDropdownValue = value;
          });
        },
      ),
    );
  }

  AlarmTextFormField buildAlarmSourceTextFormField() {
    return AlarmTextFormField(
      controller: _alarmSourceFieldController,
      hintText: "Enter a source",
      validatorText: "Please enter a source",
    );
  }

  AlarmTextFormField buildAlarmNameTextFormField() {
    return AlarmTextFormField(
      controller: _alarmNameFieldController,
      hintText: "Enter a name",
      validatorText: "Please enter a name",
    );
  }

  void validateAndAddAlarm(AlarmProvider alarmsData, BuildContext context) {
    if (_formKey.currentState.validate() && _isActiveDropdownValue != null) {
      alarmsData.addAlarm(Alarm(
          name: _alarmNameFieldController.text,
          source: _alarmSourceFieldController.text,
          metric: _metricTypeDropdownValue,
          greater: _isGreaterDropdownValue,
          isActive: _isActiveDropdownValue,
          isTemp: _isTempDropdownValue,
          trigger: double.parse(_triggerSourceFieldController.text)));
      Navigator.of(context).pop();
    }
  }

  void validateAndEditAlarm(AlarmProvider alarmsData, BuildContext context) {
    if (_formKey.currentState.validate() && _isActiveDropdownValue != null) {
      alarmsData.editAlarm(
          widget.alarm,
          Alarm(
              name: _alarmNameFieldController.text,
              source: _alarmSourceFieldController.text,
              metric: _metricTypeDropdownValue,
              greater: _isGreaterDropdownValue,
              isActive: _isActiveDropdownValue,
              isTemp: _isTempDropdownValue,
              trigger: double.parse(_triggerSourceFieldController.text)));
      Navigator.of(context).pop();
    }
  }
}
