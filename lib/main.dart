import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/main_screen.dart';
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
        home: MainScreen(),
      ),
    );
  }
}