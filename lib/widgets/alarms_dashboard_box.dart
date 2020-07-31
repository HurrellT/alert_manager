import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/alarm_provider.dart';
import 'dashboard_box.dart';

class AlarmsDashboardBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final alarmsData = Provider.of<AlarmProvider>(context);
    return DashboardBox(
        widgetText:
            "${alarmsData.activeAlarms} / ${alarmsData.alarms.length} Alarms turned on");
  }
}
