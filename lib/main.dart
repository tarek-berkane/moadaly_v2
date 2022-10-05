import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:moadaly_v2/constants.dart';
import 'package:moadaly_v2/data/schema.dart';
import 'package:moadaly_v2/screens/note_screen.dart';
import 'package:moadaly_v2/screens/partial/footer.dart';
import 'package:moadaly_v2/screens/splash.dart';

enum Menu { itemOne, itemTwo, itemThree, itemFour }

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

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFAFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(width: 150, child: MOADALY_LOGO),
            
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
                  for (var data in specialities) ModuleCard(data),
                ],
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage(this.data, {Key? key}) : super(key: key);
//   Map data;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   late NoteController noteController;

//   @override
//   Widget build(BuildContext context) {
//     noteController = NoteController(widget.data);
//     NoteTableBuilder noteTableBuilder = NoteTableBuilder(noteController);
//     // List<Widget> rows = [Center(child: Text("semster1")), uniteTable()];
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(onPressed: ()async{
//             await noteController.clearData();
//             noteController = NoteController(widget.data);
//             setState(() {

//             });
//           }, icon: const Icon(Icons.clear),tooltip: "Clear data",)
//         ],
//         title: Text(widget.data['name']),
//       ),
//       body: Center(
//         child: noteTableBuilder.getView(),
//       ),
//     );
//   }
// }

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
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        // style: GoogleFonts.ubuntu(fontSize: 18),
      );
    } else {
      return const CircularProgressIndicator();
    }
  }

  // Future loadData() async {
  //   try {
  //     setState(() {
  //       btn_state = ButtonState.loading;
  //     });

  //     final data = await readJson(widget.text);
  //     setState(() {
  //       btn_state = ButtonState.done;
  //     });
  //     Get.to(MyHomePage(data));
  //   } catch (e) {
  //     setState(() {
  //       btn_state = ButtonState.done;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: InkWell(
        child: Container(alignment: Alignment.center, child: getContent()),
        onTap: () async {
          // await loadData();
          Get.to(NoteScreen(widget.text));
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
