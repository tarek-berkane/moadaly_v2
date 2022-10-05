import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutTextProvider {
  static const enText = {
    'title':
        'Moadaly is an application that allow you to calculate your pass marks. The app is for computer science student " LMD "',
    'DevTitle': 'Developers',
  };

  static const dev1 = {
    "fullName": 'Taha Zerrouki',
    "github": "linuxscout",
    "website": "infobouirauniv.wordpress.com",
    'bio':
        'Computer Science Professor Interest : Arabic Natural Language processing Open source software developer'
  };
  static const dev4 = {
    'fullName': "Aouf Ali",
    'bio':
        "Master degree in artificial intelligence, currently passing doctorate in artificial intelligence"
  };

  static const dev3 = {
    'fullName': "Abd El Madjid Smail ",
    "github": "Abdelmadjidsmail",
    'bio':
        'Master degree in computer systems engineering, passionate about javascript technology and blockchain',
  };

  static const dev2 = {
    'fullName': "Berkane tarek",
    "github": "tarek-berkane",
    "website": "codingdz.com",
    'bio':
        'Full stack developer & and mobile developer, passionate about software engineering and artificial intelligence',
  };

  static const dev5 = {
    'fullName': "Sofiane Mekroud",
    'bio': 'Designer\n A student of information technology ',
  };
}

Future _launchURL(_url) async => await canLaunchUrl(_url)
    ? await launchUrl(_url)
    : throw 'Could not launch $_url';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  String getTextOrNull(String? text) {
    if (text != null) {
      return text;
    }
    return "null";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 60,
              alignment: Alignment.center,
              child: const Text(
                "Moadaly V3",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  // color: Colors.white,
                ),
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: <Widget>[
                    Container(
                      height: 60,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      alignment: Alignment.center,
                      child: Text(
                        getTextOrNull(AboutTextProvider.enText["title"]),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          // color: Color(0xff27326D),
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const Divider(
                      // color: Color(0xff123DD2),
                      thickness: 2.5,
                      height: 40,
                    ),
                    Text(
                      getTextOrNull(AboutTextProvider.enText['DevTitle']),
                      style: const TextStyle(
                          // color: Color(0xff20C9B5),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    bioCard(
                      bio: getTextOrNull(AboutTextProvider.dev1['bio']),
                      fullName:
                          getTextOrNull(AboutTextProvider.dev1['fullName']),
                      srcImg: 'assets/images/f1.jpg',
                      githubLink: AboutTextProvider.dev1['github'],
                      website: AboutTextProvider.dev1['website'],
                    ),
                    bioCard(
                      bio: getTextOrNull(AboutTextProvider.dev2['bio']),
                      fullName:
                          getTextOrNull(AboutTextProvider.dev2['fullName']),
                      srcImg: 'assets/images/f4.jpg',
                      githubLink: AboutTextProvider.dev2['github'],
                    ),
                    bioCard(
                      bio: getTextOrNull(AboutTextProvider.dev3['bio']),
                      fullName:
                          getTextOrNull(AboutTextProvider.dev3['fullName']),
                      srcImg: 'assets/images/f3.jpg',
                      githubLink: AboutTextProvider.dev3['github'],
                    ),
                    bioCard(
                        bio: getTextOrNull(AboutTextProvider.dev4['bio']),
                        fullName:
                            getTextOrNull(AboutTextProvider.dev4['fullName']),
                        srcImg: 'assets/images/f2.jpg'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Card bioCard({
    required String srcImg,
    required String fullName,
    required String bio,
    String? githubLink,
    String? website,
  }) =>
      Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          // height: 190,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text(
                fullName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    // color: Color(0xff007CEF),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        bio,
                        softWrap: true,
                        style: GoogleFonts.poppins(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                          srcImg,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (githubLink != null)
                    IconButton(
                      onPressed: () async {
                        await _launchURL(Uri(
                          scheme: "https",
                          host: "github.com",
                          path: githubLink,
                        ));
                      },
                      icon: Image.asset('assets/icons/github.png', width: 30),
                    ),
                  if (website != null)
                    IconButton(
                        onPressed: () async {
                          await _launchURL(Uri(
                            scheme: "https",
                            host: website,
                          ));
                        },
                        icon: Image.asset('assets/icons/globe.png', width: 26)),
                  // IconButton(
                  //     onPressed: () {},
                  //     icon:
                  //         Image.asset('assets/icons/linkedin.png', width: 30)),
                ],
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      );
}
