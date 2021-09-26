import "package:flutter/material.dart";
import 'package:get/route_manager.dart';
import 'package:moadaly_v2/constants.dart';
import 'package:moadaly_v2/screens/about.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  Future _launchURL(_url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                // await _launchURL(_url)
                Get.to(AboutScreen());
              },
              icon: const ImageIcon(AssetImage(DEV_ICON)),
            ),
            IconButton(
              onPressed: () async {
                await _launchURL(
                    "https://github.com/tarek-berkane/moadaly-App");
              },
              icon: const ImageIcon(AssetImage(GITHUB_ICON)),
            ),
            IconButton(
              onPressed: () async {
                await _launchURL("http://dpinfo.univ-bouira.dz/");
              },
              icon: const ImageIcon(AssetImage(SITE_ICON)),
            ),
            IconButton(
              onPressed: () async {
                await _launchURL("https://www.univ-bouira.dz/fr/");
              },
              icon: const ImageIcon(AssetImage(UNIV_ICON)),
            ),
          ],
        ),
      ),
    );
  }
}
