import 'package:flutter/material.dart';

enum DeviceScreenType { Mobile, Tablet, Desktop }

DeviceScreenType getDeviceType(MediaQueryData mediaQuery) {
  var orientation = mediaQuery.orientation;
  double devicesWidth = 0;

  if (orientation == Orientation.landscape) {
    devicesWidth = mediaQuery.size.height;
  } else {
    devicesWidth = mediaQuery.size.width;
  }

  if (devicesWidth > 950) {
    return DeviceScreenType.Desktop;
  }

  if (devicesWidth > 600) {
    return DeviceScreenType.Tablet;
  }

  return DeviceScreenType.Mobile;
}
