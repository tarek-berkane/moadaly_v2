import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/route_manager.dart';

import 'package:moadaly_app/constants.dart';
import 'package:moadaly_app/screens/partial/footer.dart';
import 'package:moadaly_app/screens/partial/years_area.dart';
import 'package:moadaly_app/screens/splash.dart';

// enum Menu { itemOne, itemTwo, itemThree, itemFour }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      home: const SplashScreen(),
    );
  }
}
