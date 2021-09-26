import 'package:flutter/material.dart';

class AboutTextProvider {
  static const enText = {
    'title':
        'Moadaly is an application that allow you to calculate your pass marks. The app is for computer science student " LMD "',
    'DevTitle': 'Developers',
  };

  static const dev1 = {
    "fullName": 'Taha Zerrouki',
    'bio':
        'Computer Science Professor\nInterest : Arabic Natural Language processing Open source software developer'
  };
  static const dev4 = {
    'fullName': "Aouf Ali",
    'bio':
        "A student of information technology specializing in artificial intelligence"
  };

  static const dev3 = {
    'fullName': "Abd El Madjid Smail ",
    'bio': 'Computer science student, open source developer & JS lover',
  };

  static const dev2 = {
    'fullName': "Berkane tarek",
    'bio': 'mobile app developer A student of information technology ',
  };

  static const dev5 = {
    'fullName': "Sofiane Mekroud",
    'bio': 'Designer\n A student of information technology ',
  };
}

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
      // backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 60,
              alignment: Alignment.center,
              child: const Text(
                "Moadaly V2",
                style: TextStyle(
                  fontSize: 30,
                  // color: Color(0xff007CEF),
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
                        srcImg: 'assets/images/f1.jpg'),
                    bioCard(
                        bio: getTextOrNull(AboutTextProvider.dev2['bio']),
                        fullName:
                            getTextOrNull(AboutTextProvider.dev2['fullName']),
                        srcImg: 'assets/images/f4.jpg'),
                    bioCard(
                        bio: getTextOrNull(AboutTextProvider.dev3['bio']),
                        fullName:
                            getTextOrNull(AboutTextProvider.dev3['fullName']),
                        srcImg: 'assets/images/f3.jpg'),
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

  Card bioCard(
          {required String srcImg,
          required String fullName,
          required String bio}) =>
      Card(
        margin: EdgeInsets.symmetric(vertical: 10),
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Container(
          height: 190,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                child: Container(
                  width: 120.0,
                  height: 120.0,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      srcImg,
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    fullName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        // color: Color(0xff007CEF),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    alignment: Alignment.center,
                    width: 200,
                    child: Text(
                      bio,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.7,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
