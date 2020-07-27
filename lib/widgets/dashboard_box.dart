import 'package:alert_manager/widgets/base_widget.dart';
import 'package:flutter/material.dart';

class DashboardBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      builder: (context, sizingInformation) {
        return Center(child: Text('dash box'));
      },
    );
  }
}
