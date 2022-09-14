import "package:flutter/material.dart";
import 'package:get/route_manager.dart';
import 'package:moadaly_v2/constants.dart';
import 'package:moadaly_v2/screens/about.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  Future _launchURL(_url) async => await canLaunchUrl(_url)
      ? await launchUrl(_url)
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
                Get.to(const AboutScreen());
              },
              icon: const ImageIcon(AssetImage(DEV_ICON)),
            ),
            IconButton(
              onPressed: () async {
                await _launchURL(Uri(
                  scheme: "https",
                  host: "github.com",
                  path: "tarek-berkane/moadaly_v2",
                ));
              },
              icon: const ImageIcon(AssetImage(GITHUB_ICON)),
            ),
            IconButton(
              onPressed: () async {
                await _launchURL(
                    Uri(scheme: "http", host: 'dpinfo.univ-bouira.dz'));
              },
              icon: const ImageIcon(AssetImage(SITE_ICON)),
            ),
            IconButton(
              onPressed: () async {
                await _launchURL(
                    Uri(scheme: "https", host: "www.univ-bouira.dz"));
              },
              icon: const ImageIcon(AssetImage(UNIV_ICON)),
            ),
          ],
        ),
      ),
    );
  }
}
