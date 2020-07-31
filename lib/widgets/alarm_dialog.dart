import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/alarm_provider.dart';
import '../model/metric_type.dart';
import '../model/alarm.dart';
import 'alarm_text_form_field.dart';

class AlarmDialog extends StatefulWidget {
  @override
  _AlarmDialogState createState() => _AlarmDialogState();
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

    super.initState();
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
              AlarmTextFormField(
                controller: _alarmNameFieldController,
                hintText: "Enter a name",
                validatorText: "Please enter a name",
              ),
              AlarmTextFormField(
                controller: _alarmSourceFieldController,
                hintText: "Enter a source",
                validatorText: "Please enter a source",
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                      hintText: "Choose a metric"),
                  items: [
                    ...MetricType.values.map((e) {
                      return DropdownMenuItem(
                        child: Text(e.toString()),
                        //todo make a better print
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
              ),
              AlarmTextFormField(
                controller:
                _triggerSourceFieldController,
                hintText: "Enter a trigger point",
                validatorText:
                "Please enter a trigger point",
                keyboardType: TextInputType.number,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                      hintText:
                      "Choose if grater or lower"),
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
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                      hintText:
                      "Choose temp or percentage"),
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
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                      hintText: "Choose an option"),
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
              ),
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState
                      .validate() &&
                      _isActiveDropdownValue != null) {
                    alarmsData.addAlarm(Alarm(
                        name: _alarmNameFieldController
                            .text,
                        source:
                        _alarmSourceFieldController
                            .text,
                        metric:
                        _metricTypeDropdownValue,
                        greater:
                        _isGreaterDropdownValue,
                        isActive:
                        _isActiveDropdownValue,
                        isTemp: _isTempDropdownValue,
                        trigger: double.parse(
                            _triggerSourceFieldController
                                .text)));
                    Navigator.of(context).pop();
                  }
                  ;
                },
                child: Text('Add'),
              )
            ]))
      ],
    );
  }
}
