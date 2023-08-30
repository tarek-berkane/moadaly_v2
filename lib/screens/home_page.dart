import 'package:flutter/material.dart';
import 'package:moadaly_2_1/constants.dart';
import 'package:moadaly_2_1/screens/partial/footer.dart';
import 'package:moadaly_2_1/screens/partial/years_area.dart';

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
