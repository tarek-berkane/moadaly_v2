import "package:flutter/material.dart";
import 'package:get/route_manager.dart';
import 'package:moadaly_2_1/constants.dart';
import 'package:moadaly_2_1/screens/about.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  Future _launchURL(_url) async =>
      await launchUrl(_url, mode: LaunchMode.externalApplication);
  // : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    // await _launchURL(_url)
                    Get.to(AboutScreen());
                  },
                  icon: const ImageIcon(AssetImage(DEV_ICON)),
                ),
                const Text(
                  "About",
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () async {
                    await _launchURL(
                        Uri(scheme: "http", host: 'dpinfo.univ-bouira.dz'));
                  },
                  icon: const ImageIcon(AssetImage(SITE_ICON)),
                ),
                const Text(
                  "Département Info",
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () async {
                    await _launchURL(
                        Uri(scheme: "https", host: "www.univ-bouira.dz"));
                  },
                  icon: const ImageIcon(AssetImage(UNIV_ICON)),
                ),
                const Text(
                  "Université de Bouira",
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
