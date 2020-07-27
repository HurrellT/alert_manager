import 'package:alert_manager/widgets/base_widget.dart';
import 'package:alert_manager/widgets/dashboard_box.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final List<DashboardBox> dashboardBoxes = [
    DashboardBox(),
    DashboardBox(),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      builder: (context, sizingInformation) {
        return Center(
            child: GridView.count(
//              crossAxisCount: sizingInformation.deviceScreenType == DeviceScreenType.Mobile ? 2 : 4, this could be done for responsive layout
            crossAxisCount: 2,
              children: dashboardBoxes,
            ));
      },
    );
  }
}
