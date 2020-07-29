import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import '../model/alarm.dart';

class AlarmService {
  static const ROOT = 'assets/fake_data.json'; //this should be the real URL

  static Future<List<Alarm>> getAlarms() async {
    try {
      final response = await http.get(ROOT);
      if (response.statusCode == 200)
        return parseResponse(response.body);
      else
        throw Exception('Failed to load alarms');
    } catch (e) {
      print(e.toString());
    }
  }

  static List<Alarm> parseResponse(String body) {
    final parsedJson = json.decode(body).cast<Map<String, dynamic>>();
    parsedJson.map<Alarm>((json) => Alarm.fromJson(json)).toList();
    return parsedJson;
  }

  //just for this fake json
  static Future<List<Alarm>> getLocalAlarms() async {
    return parseListResponse(await rootBundle.loadString('assets/fake_data.json'));
  }

  static List<Alarm> parseListResponse(String body) {
    final parsedJson = json.decode(body);
    return AlarmList.fromJson(parsedJson).alarms;
  }


  //here you would have API calls to add, remove and update alarms
  //and the app would use this methods when adding/removing/updating an alarm.
}
