import 'package:alert_manager/utils/device_screen_type.dart';
import 'package:flutter/material.dart';

import '../widgets/alarms_dashboard_box.dart';
import '../widgets/base_widget.dart';
import '../widgets/dashboard_box.dart';

class DashboardScreen extends StatelessWidget {
  final List<Widget> dashboardBoxes = [
    AlarmsDashboardBox(),
    DashboardBox(
      widgetText: "Not yet implemented",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      builder: (context, sizingInformation) {
        return Center(
            child: GridView.count(
          crossAxisCount:
              sizingInformation.deviceScreenType == DeviceScreenType.Mobile
                  ? 2
                  : 3,
          children: dashboardBoxes,
        ));
      },
    );
  }
}
