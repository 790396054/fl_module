import 'dart:ui';

import 'package:fl_module/navigator/tab_navigator.dart';
import 'package:fl_module/pages/demo/chart_page.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

void main() {
  runApp(MyApp(window.defaultRouteName));
}

class MyApp extends StatelessWidget {
  String? initParams = "";

  MyApp(this.initParams, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: '协程 APP',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: <String, WidgetBuilder> {
          'demo/chartPage': (context) => ChartPage(),
        },
        home: const TabNavigator(),
      ),
    );
  }
}