import 'dart:convert';

import 'package:alert_manager/model/alarm.dart';
import 'package:alert_manager/model/metric_type.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test/flutter_test.dart';


void main() {
  test('Creating a new Alarm', () {
    Alarm alarm = Alarm(
      name: 'Alarm',
      source: 'Test',
      trigger: 0.2,
      isTemp: false,
      isActive: true,
      greater: true,
      metric: MetricType.GPU_USAGE
    );

    expect(alarm.name, 'Alarm');
    expect(alarm.source, 'Test');
    expect(alarm.trigger, 0.2);
    expect(alarm.isTemp, false);
    expect(alarm.isActive, true);
    expect(alarm.greater, true);
    expect(alarm.metric, MetricType.GPU_USAGE);
  });

  test('Alarm from JSON', () {
    Map<String, dynamic> alarmJson = {
      "name": "Alarm CPU Usage",
      "source": "Server 1",
      "metric": "CPU_USAGE",
      "greater": true,
      "trigger": 0.8,
      "isTemp": false,
      "active" : false
    };

    Alarm alarm = Alarm.fromJson(alarmJson);

    expect(alarm.name, 'Alarm CPU Usage');
    expect(alarm.source, 'Server 1');
    expect(alarm.trigger, 0.8);
    expect(alarm.isTemp, false);
    expect(alarm.isActive, false);
    expect(alarm.greater, true);
    expect(alarm.metric, MetricType.CPU_USAGE);
  });

  test('Alarm list from JSON', () {
    List<Map<String, dynamic>> alarmsJson = [
      {
        "name": "Alarm CPU Usage",
        "source": "Server 1",
        "metric": "CPU_USAGE",
        "greater": true,
        "trigger": 0.8,
        "isTemp": false,
        "active" : false
      },
      {
        "name": "Alarm GPU Usage",
        "source": "Server 1",
        "metric": "GPU_USAGE",
        "greater": true,
        "trigger": 0.9,
        "isTemp": false,
        "active" : true
      },
      {
        "name": "Alarm GPU Temp",
        "source": "Server 1",
        "metric": "GPU_TEMP",
        "greater": true,
        "trigger": 0.85,
        "isTemp": true,
        "active" : true
      }
    ];

    AlarmList alarmList = AlarmList.fromJson(alarmsJson);

    expect(alarmList.alarms.length, 3);

    var alarm = alarmList.alarms.first;
    expect(alarm.name, 'Alarm CPU Usage');
    expect(alarm.source, 'Server 1');
    expect(alarm.trigger, 0.8);
    expect(alarm.isTemp, false);
    expect(alarm.isActive, false);
    expect(alarm.greater, true);
    expect(alarm.metric, MetricType.CPU_USAGE);
  });
}