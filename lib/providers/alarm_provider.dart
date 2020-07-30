import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import '../model/alarm.dart';

class AlarmProvider with ChangeNotifier {
  List<Alarm> _alarms = [];
  List<Alarm> _filteredAlarms = [];
  bool _isFetching = false;

  AlarmProvider() {
    fetchAlarms();
  }

  List<Alarm> get alarms {
    return [..._alarms];
  }

  List<Alarm> get filteredAlarms {
    return [..._filteredAlarms];
  }

  bool get isFetching => _isFetching;

  int get activeAlarms {
    return alarms.where((element) => element.isActive).length;
  }

  void fetchAlarms() async {
    _isFetching = true;
    notifyListeners();

    //just for this fake json
    _alarms = _filteredAlarms = AlarmList.fromJson(
            json.decode(await rootBundle.loadString('assets/fake_data.json')))
        .alarms;

    _isFetching = false;
    notifyListeners();
  }

  /*
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
  //this replaces a service when using no state management

  //here you would have API calls to add, remove and update alarms
  //and the app would use this methods when adding/removing/updating an alarm.
   */

  void addAlarm(Alarm alarm) {
    _alarms.add(alarm);
    notifyListeners();
  }

  void removeAlarm(Alarm alarm) {
    _alarms.removeWhere((element) => element == alarm);
    notifyListeners();
  }

  void setFilteredAlarms(
      {String statusFilter, String nameFilterControllerValue}) {
    if (nameFilterControllerValue == '') {
      _filteredAlarms = alarms
          .where((element) =>
              element.isActive.toString() == statusFilter ||
              statusFilter == 'All')
          .toList();
      notifyListeners();
    } else {
      _filteredAlarms = alarms
          .where((element) =>
              (element.isActive.toString() == statusFilter ||
                  statusFilter == 'All') &&
              element.name
                  .toLowerCase()
                  .contains(nameFilterControllerValue.toLowerCase()))
          .toList();
      notifyListeners();
    }
  }
}
