import 'metric_type.dart';

class Alarm {
  String name, source;
  MetricType metric;
  double trigger;
  bool greater, isActive;

  Alarm(
      {this.name,
      this.source,
      this.metric,
      this.trigger,
      this.greater,
      this.isActive});

  factory Alarm.fromJson(Map<String, dynamic> json) {
    return Alarm(
        name: json['name'],
        source: json['source'],
        metric: json['metric'],
        greater: json['greater'],
        trigger: json['trigger'],
        isActive: json['active']);
  }
}
