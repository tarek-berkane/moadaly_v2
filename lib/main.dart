import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/route_manager.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:moadaly_v2/components/note_table_builder.dart';
import 'package:moadaly_v2/data/schema.dart';
import 'package:moadaly_v2/components/footer.dart';

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
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(" Moadaly"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              color: Colors.black45,
              height: 60.0,
              alignment: Alignment.center,
              child: DefaultTextStyle(
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, color: Colors.white),
                // style: GoogleFonts.tajawal(fontSize: 18, color: Colors.white),
                child: AnimatedTextKit(
                  animatedTexts: [
                    FadeAnimatedText('Université Akli Mohand Oulhadj Bouira',
                        duration: Duration(seconds: 5)),
                    FadeAnimatedText(
                        'Faculte des sciences et sciences appliquees'),
                    FadeAnimatedText('Departement Informatique'),
                  ],
                  onTap: () {},
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(10),
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: 2,
                childAspectRatio: 3,
                children: <Widget>[
                  for (var data in all_data)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ModuleCard(data),
                    ),
                ],
              ),
            ),
            const Footer(),
          ],
        ));
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage(this.data, {Key? key}) : super(key: key);
  Map data;

  @override
  Widget build(BuildContext context) {
    NoteTableBuilder noteTableBuilder = NoteTableBuilder(data);
    // List<Widget> rows = [Center(child: Text("semster1")), uniteTable()];
    return Scaffold(
      appBar: AppBar(
        title: Text(data['name']),
      ),
      body: Center(
        child: noteTableBuilder.getView(),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  CustomCard(this.srcImage, this.text, this.page);
  final String srcImage, text;
  final Widget page;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      // color: Color(0xFFFFFFFF),
      child: InkWell(
        child: Container(
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(fontSize: 18),
            // style: GoogleFonts.ubuntu(fontSize: 18),
          ),
        ),
        onTap: () {
          Get.to(page);
        },
      ),
    );
  }
}

enum ButtonState { loading, done }

class ModuleCard extends StatefulWidget {
  const ModuleCard(this.text, {Key? key}) : super(key: key);
  final String text;

  @override
  _ModuleCardState createState() => _ModuleCardState();
}

class _ModuleCardState extends State<ModuleCard> {
  ButtonState btn_state = ButtonState.done;

  Widget getContent() {
    if (btn_state == ButtonState.done) {
      return Text(
        widget.text,
        style: const TextStyle(fontSize: 18),
        // style: GoogleFonts.ubuntu(fontSize: 18),
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  Future loadData() async {
    try {
      setState(() {
        btn_state = ButtonState.loading;
      });

      final data = await readJson(widget.text);
      setState(() {
        btn_state = ButtonState.done;
      });
      Get.to(MyHomePage(data));
    } catch (e) {
      setState(() {
        btn_state = ButtonState.done;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: InkWell(
        child: Container(alignment: Alignment.center, child: getContent()),
        onTap: () async {
          await loadData();
        },
      ),
    );
  }

  Future<Map> readJson(fileName) async {
    final String response =
        await rootBundle.loadString('assets/json/$fileName.json');
    Map data = await json.decode(response);
    return data;
  }
}
