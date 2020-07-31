import 'package:alert_manager/widgets/base_widget.dart';
import 'package:flutter/material.dart';

class DashboardBox extends StatelessWidget {
  const DashboardBox({
    Key key,
    @required this.widgetText,
  }) : super(key: key);

  final String widgetText;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      builder: (context, sizingInformation) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            child: Center(
                child: Text(
                  widgetText,
                  style: TextStyle(fontSize: 24),
                )),
          ),
        );
      },
    );
  }
}
