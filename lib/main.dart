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
  var widgetList = [
    {'widget': DashboardScreen(), 'title': 'Dashboard'},
    {'widget': AlarmScreen(), 'title': 'Alarms'},
  ];
  final _formKey = GlobalKey<FormState>();
  TextEditingController _alarmNameFieldController;
  TextEditingController _alarmSourceFieldController;
  TextEditingController _triggerSourceFieldController;
  bool _isTempDropdownValue;
  bool _isActiveDropdownValue;
  bool _isGreaterDropdownValue;
  MetricType _metricTypeDropdownValue;

  @override
  void initState() {
    _alarmNameFieldController = TextEditingController();
    _alarmSourceFieldController = TextEditingController();
    _triggerSourceFieldController = TextEditingController();

    super.initState();
  }

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
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SimpleDialog(
                              title: const Text("Add alarm"),
                              children: [
                                Form(
                                    key: _formKey,
                                    child: Column(children: <Widget>[
                                      AlarmTextFormField(
                                        controller: _alarmNameFieldController,
                                        hintText: "Enter a name",
                                        validatorText: "Please enter a name",
                                      ),
                                      AlarmTextFormField(
                                        controller: _alarmSourceFieldController,
                                        hintText: "Enter a source",
                                        validatorText: "Please enter a source",
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: DropdownButtonFormField(
                                          decoration: InputDecoration(
                                              hintText: "Choose a metric"),
                                          items: [
                                            ...MetricType.values.map((e) {
                                              return DropdownMenuItem(
                                                child: Text(e.toString()),
                                                //todo make a better print
                                                value: e,
                                              );
                                            }).toList()
                                          ],
                                          onChanged: (MetricType value) {
                                            setState(() {
                                              _metricTypeDropdownValue = value;
                                            });
                                          },
                                        ),
                                      ),
                                      AlarmTextFormField(
                                        controller:
                                            _triggerSourceFieldController,
                                        hintText: "Enter a trigger point",
                                        validatorText:
                                            "Please enter a trigger point",
                                        keyboardType: TextInputType.number,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: DropdownButtonFormField(
                                          decoration: InputDecoration(
                                              hintText:
                                                  "Choose if grater or lower"),
                                          items: [
                                            DropdownMenuItem(
                                              child: Text(">"),
                                              value: true,
                                            ),
                                            DropdownMenuItem(
                                              child: Text("<"),
                                              value: false,
                                            ),
                                          ],
                                          onChanged: (bool value) {
                                            setState(() {
                                              _isGreaterDropdownValue = value;
                                            });
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: DropdownButtonFormField(
                                          decoration: InputDecoration(
                                              hintText:
                                                  "Choose temp or percentage"),
                                          items: [
                                            DropdownMenuItem(
                                              child: Text("°C"),
                                              value: true,
                                            ),
                                            DropdownMenuItem(
                                              child: Text("%"),
                                              value: false,
                                            ),
                                          ],
                                          onChanged: (bool value) {
                                            setState(() {
                                              _isTempDropdownValue = value;
                                            });
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: DropdownButtonFormField(
                                          decoration: InputDecoration(
                                              hintText: "Choose an option"),
                                          items: [
                                            DropdownMenuItem(
                                              child: Text("Active"),
                                              value: true,
                                            ),
                                            DropdownMenuItem(
                                              child: Text("Paused"),
                                              value: false,
                                            ),
                                          ],
                                          onChanged: (bool value) {
                                            setState(() {
                                              _isActiveDropdownValue = value;
                                            });
                                          },
                                        ),
                                      ),
                                      RaisedButton(
                                        onPressed: () {
                                          if (_formKey.currentState
                                                  .validate() &&
                                              _isActiveDropdownValue != null) {
                                            alarmsData.addAlarm(Alarm(
                                                name: _alarmNameFieldController
                                                    .text,
                                                source:
                                                    _alarmSourceFieldController
                                                        .text,
                                                metric:
                                                    _metricTypeDropdownValue,
                                                greater:
                                                    _isGreaterDropdownValue,
                                                isActive:
                                                    _isActiveDropdownValue,
                                                isTemp: _isTempDropdownValue,
                                                trigger: double.parse(
                                                    _triggerSourceFieldController
                                                        .text)));
                                            Navigator.of(context).pop();
                                          }
                                          ;
                                        },
                                        child: Text('Add'),
                                      )
                                    ]))
                              ],
                            );
                          });
                    },
                  )
                : null,
            appBar: AppBar(
              title: Text(widgetList[_selectedIndex]['title']),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Badge(
                    badgeContent: Text(alarmsData.activeAlarms.toString()),
                    //todo change to use prov
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
}

class AlarmTextFormField extends StatelessWidget {
  final String hintText, validatorText;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const AlarmTextFormField({
    this.keyboardType = TextInputType
        .text, //This is currently NOT working for Flutter web and desktop
    this.controller,
    this.hintText,
    this.validatorText,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        keyboardType: keyboardType,
        validator: (value) {
          if (value.isEmpty) {
            return validatorText;
          }
          return null;
        },
        decoration: InputDecoration(hintText: hintText),
        controller: controller,
      ),
    );
  }
}
