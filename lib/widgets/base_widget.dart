import 'package:alert_manager/utils/device_screen_type.dart';
import 'package:alert_manager/utils/sizing_information.dart';
import 'package:flutter/material.dart';

class BaseWidget extends StatelessWidget {
  final Widget Function(
      BuildContext context, SizingInformation sizingInformation) builder;

  BaseWidget({this.builder});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return LayoutBuilder(builder: (context, boxConstraints) {
      var sizingInformation = SizingInformation(
          orientation: mediaQuery.orientation,
          deviceScreenType: getDeviceType(mediaQuery),
          screenSize: mediaQuery.size,
          localWidgetSize:
          Size(boxConstraints.maxWidth, boxConstraints.maxHeight));
      return builder(context, sizingInformation);
    });
  }
}