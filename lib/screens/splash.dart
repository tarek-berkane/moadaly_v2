import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';
import 'package:getwidget/getwidget.dart';
import 'package:moadaly_2_1/constants.dart';
import 'package:moadaly_2_1/main.dart';
import 'package:moadaly_2_1/screens/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => loadData());
  }

  Future<void> loadData() async {
    await Future.delayed(const Duration(seconds: 1, milliseconds: 400));
    Get.off(const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.white, Colors.grey[300]!],
        )),
        child: Center(
          child: SizedBox(width: 250, child: MOADALY_LOGO),
        ),
      ),
    );
  }

  void d() {}
}
