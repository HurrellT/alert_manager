import 'package:alert_manager/widgets/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';

import '../screens/alarm_screen.dart';
import '../screens/dashboard_screen.dart';
import '../providers/alarm_provider.dart';
import '../widgets/alarm_dialog.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  var widgetList = [
    {'widget': DashboardScreen(), 'title': 'Dashboard'},
    {'widget': AlarmScreen(), 'title': 'Alarms'},
  ];

  @override
  Widget build(BuildContext context) {
    final alarmsData = Provider.of<AlarmProvider>(context);

    return BaseWidget(
      builder: (context, sizingInformation) {
        return Scaffold(
            floatingActionButton: buildConditionalFloatingActionButton(context),
            appBar: AppBar(
              title: Text(widgetList[_selectedIndex]['title']),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Badge(
                    badgeContent: Text(alarmsData.activeAlarms.toString()),
                    child: Icon(MaterialCommunityIcons.alarm_light_outline),
                    animationType: BadgeAnimationType.fade,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            body: Row(
              children: [
                NavigationRail(
                  elevation: 10,
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  labelType: NavigationRailLabelType.selected,
                  selectedIconTheme: const IconThemeData(color: Colors.white),
                  selectedLabelTextStyle: const TextStyle(color: Colors.white),
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(MaterialCommunityIcons.view_dashboard_outline),
                      selectedIcon: Icon(MaterialCommunityIcons.view_dashboard),
                      label: Text('Dashboard'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(MaterialCommunityIcons.alarm_light_outline),
                      selectedIcon: Icon(MaterialCommunityIcons.alarm_light),
                      label: Text('Alarms'),
                    ),
                  ],
                ),
                VerticalDivider(thickness: 1, width: 1),
                //Main Content
                Expanded(
                  child: widgetList[_selectedIndex]['widget'],
                ),
//                ),
              ],
            ));
      },
    );
  }

  FloatingActionButton buildConditionalFloatingActionButton(
      BuildContext context) {
    return _selectedIndex == 1
        ? FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlarmDialog();
                  });
            },
          )
        : null;
  }
}
