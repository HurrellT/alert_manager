import 'metric_type.dart';

class Alarm {
  String name, source;
  MetricType metric;
  double trigger;
  bool greater, isActive, isTemp;

  Alarm(
      {this.name,
      this.source,
      this.metric,
      this.trigger,
      this.greater,
      this.isActive,
      this.isTemp});

  factory Alarm.fromJson(Map<String, dynamic> json) {
    return Alarm(
        name: json['name'],
        source: json['source'],
        metric: MetricType.values.firstWhere((metricType) =>
            metricType.toString() == 'MetricType.${json['metric']}'),
        greater: json['greater'],
        trigger: json['trigger'],
        isActive: json['active'],
        isTemp: json['isTemp']);
  }
}

class AlarmList {
  List<Alarm> alarms;

  AlarmList({this.alarms});

  factory AlarmList.fromJson(List<dynamic> json) {
    List<Alarm> alarms = List<Alarm>();
    alarms = json.map((alarm) => Alarm.fromJson(alarm)).toList();
    return AlarmList(alarms: alarms);
  }
}
