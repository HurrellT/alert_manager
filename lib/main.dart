import 'package:alert_manager/model/metric_type.dart';
import 'package:alert_manager/widgets/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';

import 'model/alarm.dart';
import 'screens/alarm_screen.dart';
import 'screens/dashboard_screen.dart';
import 'providers/alarm_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => AlarmProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Clonefana',
        theme: ThemeData.dark(),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  int _activeAlarms = 0;
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
            floatingActionButton: _selectedIndex == 1
                ? FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      //todo open modal
                      alarmsData.addAlarm(Alarm(name: "Test",
                      source: "Test server",
                      metric: MetricType.CPU_USAGE,
                      greater: true,
                      isActive: true,
                      isTemp: false,
                      trigger: 0.5));
                    },
                  )
                : null,
            appBar: AppBar(
              title: Text(widgetList[_selectedIndex]['title']),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Badge(
                    badgeContent: Text(alarmsData.activeAlarms.toString()), //todo change to use prov
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
//                  child: AnimatedSwitcher(
//                    transitionBuilder: (Widget child, Animation<double> animation) {
//                      return FadeTransition(opacity: animation, child: child,);
//                    },
//                    duration: const Duration(milliseconds: 200),
//                    key: ValueKey<int>(_selectedIndex),
                  child: widgetList[_selectedIndex]['widget'],
                ),
//                ),
              ],
            ));
      },
    );
  }
}
