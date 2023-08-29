



import 'package:flutter/material.dart';
import 'package:moadaly_app/constants.dart';
import 'package:moadaly_app/screens/partial/footer.dart';
import 'package:moadaly_app/screens/partial/years_area.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 249, 249, 249),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(width: 120, child: MOADALY_LOGO),
            const SpecialitiesArea(),
            const Footer(),
          ],
        ),
      ),
    );
  }
}