import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/alarm.dart';

class AlarmService {
  static const ROOT = '../utils/fake_data.json'; //this should be the real URL

  static Future<List<Alarm>> getAlarms() async {
    try {
      final response = await http.get(ROOT);
      response.statusCode == 200
          ? parseResponse(response.body)
          : throw Exception('Failed to load alarms');
    } catch (e) {
      print(e.toString());
    }
  }

  static List<Alarm> parseResponse(String body) {
    final paredJson = json.decode(body).cast<Map<String, dynamic>>();
    paredJson.map<Alarm>((json) => Alarm.fromJson(json)).toList();
  }

  //here you would have API calls to add, remove and update alarms
  //and the app would use this methods when adding/removing/updating an alarm.
}
