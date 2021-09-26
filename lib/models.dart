// import 'dart:math' as math;

// import 'package:flutter/material.dart';
// import 'package:get/state_manager.dart' as state;
// import 'package:get/get.dart';

// import 'package:moadaly_v2/components/text.dart';
// import 'package:moadaly_v2/constants.dart';
// import 'package:moadaly_v2/controller/note_controller.dart';

// // ----------
// // YEAR
// // ----------
// class Year {
//   Year(Map data) {
//     this.name = data['name'];
//     this.semestre1 = Semestre(data['semestre1']);
//     this.semestre2 = Semestre(data['semestre2']);
//   }

//   late String name;
//   late Semestre semestre1, semestre2;
//   late double moy = 0;
//   int credit = 0;

//   void display_results(data) {
//     bool is_s1_valid = this.semestre1.calcul_moy(data);

//     bool is_s2_valid = this.semestre2.calcul_moy(data);

//     if (is_s1_valid && is_s2_valid) {
//       moy = (semestre1.moy * semestre1.coef + semestre2.moy * semestre2.coef) /
//           (semestre1.coef + semestre2.coef);
//       calc_credit();
//     }
//   }

//   void calc_credit() {
//     if (moy >= 10) {
//       credit = some_of_credits();
//     } else {
//       credit = semestre1.credits + semestre2.credits;
//     }
//   }

//   int some_of_credits() {
//     int some = 0;

//     for (var unite in semestre1.unites) {
//       for (var j in unite.modules) {
//         some += j.credit;
//       }
//     }

//     for (var unite in semestre2.unites) {
//       for (var j in unite.modules) {
//         some += j.credit;
//       }
//     }

//     return some;
//   }

//   Map get_data() {
//     Map data = {};

//     var s1_data = semestre1.get_data();
//     for (var i in s1_data) {
//       data.addAll(i);
//     }

//     var s2_data = semestre2.get_data();
//     for (var i in s2_data) {
//       data.addAll(i);
//     }

//     data[name] = {'moy': moy, 'credit': credit};
//     return data;
//   }

//   Widget getView() {
//     return state.GetBuilder<NoteController>(
//         init: NoteController(data), // INIT IT ONLY THE FIRST TIME
//         builder: (controller) => ListView(
//               children: [
//                 titleTable("SEMESTER 1"),
//                 semestre1.getView(controller),
//                 const SizedBox(height: 50),
//                 titleTable("SEMESTER 2"),
//                 semestre2.getView(controller),
//               ],
//             ));
//   }
// }

// // -----------
// // SEMESTER
// // -----------
// class Semestre {
//   Semestre(Map data) {
//     name = data['name'];

//     unites = [];

//     for (var i = 0; i < data['unites'].length; i++) {
//       unites.add(Unite(data['unites'][i]));
//     }

//     for (var i = 0; i < unites.length; i++) {
//       coef += unites[i].coef;
//       credits_origine += unites[i].credits_origine;
//     }
//   }

//   late String name;
//   late List<Unite> unites;
//   late double moy = 0;
//   late int coef = 0;
//   late int credits_origine = 0;
//   late int credits = 0;

//   bool calcul_moy(data) {
//     moy = 0;
//     double total_notes = 0;
//     int total_coef = 0;

//     bool is_semester_valid = true;
//     bool is_unity_valid = true;

//     for (var i = 0; i < unites.length; i++) {
//       is_unity_valid = unites[i].calcul_moy(data);
//       is_semester_valid = is_semester_valid && is_unity_valid;

//       total_coef += unites[i].coef;
//       total_notes += unites[i].moy * unites[i].coef;
//     }

//     if (is_unity_valid) {
//       moy = total_notes / total_coef;
//       coef = total_coef;
//       set_credits();
//       return true;
//     }

//     return false;
//   }

//   set_credits() {
//     // if moy is up to 10, get all credits
//     int total_credits = 0;

//     for (var i = 0; i < unites.length; i++) {
//       var moy_unite = unites[i].moy;

//       // setup credit for the module if the unit moy is up to 10, or the module moy is up to 10
//       unites[i].set_credits(math.max(moy, moy_unite));

//       // sum credits
//       // if ((moy >= 10) || (moy_unite >= 10))
//       total_credits += unites[i].credit;
//     }
//     credits = total_credits;
//     // print("credit ${name} = ${credits}");
//   }

//   calcul_semestre_unites_moy(data) {
//     for (var unite_x in unites) {
//       // calcul every module
//       for (var module_x in unite_x.modules) {
//         //~ moyennemodule2(module_x);
//         module_x.moyennemodule2(data);
//       }

//       unite_x.moyenneUnites(data);
//       unite_x.credUnites();
//     }
//   }

//   List get_data() {
//     List data = [];

//     for (var i = 0; i < unites.length; i++) {
//       data.addAll(unites[i].get_data());
//     }

//     data.add({
//       name: {"moy": moy, "credit": credits}
//     });

//     return data;
//   }

//   Widget getView(NoteController controller) {
//     return Table(
//       border: TableBorder.all(),
//       columnWidths: const <int, TableColumnWidth>{
//         0: FlexColumnWidth(0.6),
//         1: FixedColumnWidth(40),
//         2: FixedColumnWidth(40),
//         3: FlexColumnWidth(0.4),
//         4: FixedColumnWidth(60),
//         5: FixedColumnWidth(40),
//       },
//       defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//       children: [
//         TableRow(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color(UNITY_START_COLOR),
//                 Color(SEMESTRE_END_COLOR),
//               ],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           children: [
//             TableCell(
//               child: Container(
//                 height: 40,
//                 // color: Colors.red,
//                 child: Center(child: textTable("Modules")),
//               ),
//             ),
//             TableCell(child: textTable("Coef")),
//             TableCell(child: textTable("Cred")),
//             TableCell(
//               child: Container(child: textTable("Note")),
//             ),
//             TableCell(
//               child: Padding(
//                   padding: const EdgeInsets.all(1.0),
//                   child: textTable("Moyenne module")),
//             ),
//             TableCell(
//               child: textTable("Cred Mod"),
//             ),
//           ],
//         ),
//         for (var item in unites) ...item.getView(controller),
//         TableRow(
//             decoration: const BoxDecoration(color: Colors.white54),
//             children: [
//               TableCell(
//                 child: Container(
//                   height: 40,
//                   // color: Colors.red,
//                   child: Center(child: textTable(name)),
//                 ),
//               ),
//               TableCell(child: Center(child: textTable(this.coef.toString()))),
//               TableCell(
//                   child: Center(child: textTable(credits_origine.toString()))),
//               TableCell(
//                 child: Container(
//                   child: Center(
//                     child: Text(""),
//                   ),
//                 ),
//               ),
//               TableCell(
//                   child: Padding(
//                 padding: const EdgeInsets.all(1.0),
//                 child: Center(
//                     child: textTable(
//                   this.moy.toStringAsFixed(2),
//                 )),
//               )),
//               TableCell(
//                 child: Center(
//                   child: textTable(
//                     credits.toString(),
//                   ),
//                 ),
//               ),
//             ]),
//       ],
//     );
//   }
// }

// // -----------------
// // UNITE
// // -----------------
// class Unite {
//   Unite(Map data) {
//     name = data['name'];
//     title = data['title'];

//     modules = [];

//     for (var i = 0; i < data['modules'].length; i++) {
//       modules.add(Module((data['modules'][i])));
//     }

//     for (var i = 0; i < modules.length; i++) {
//       coef += modules[i].coef;
//       credits_origine += modules[i].credit;
//     }
//   }

//   late String title, name;
//   late List<Module> modules;
//   int coef = 0, credit = 0, credits_origine = 0;
//   double moy = 0;

//   bool calcul_moy(data) {
//     bool is_unity_valid = true;
//     bool is_module_valid = true;

//     moy = 0;
//     // ignore: omit_local_variable_types
//     double total_notes = 0;
//     for (var i = 0; i < modules.length; i++) {
//       is_module_valid = modules[i].calcul_moy(data);
//       is_unity_valid = is_unity_valid && is_module_valid;

//       total_notes += modules[i].moy * modules[i].coef;
//     }

//     if (is_unity_valid) {
//       moy = total_notes / coef;
//       return true;
//     }

//     return false;
//   }

//   int set_credits(double moy) {
//     // if moy is up to 10, get all credits
//     var total_credits = 0;

//     for (var i = 0; i < modules.length; i++) {
//       var moy_module = modules[i].moy;

//       // setup credit for the module if the unit moy is up to 10, or the module moy is up to 10
//       modules[i].set_credit(math.max<double>(moy, moy_module));

//       // sum credits
//       if ((moy >= 10) || (moy_module >= 10)) total_credits += modules[i].credit;
//     }

//     credit = total_credits;
//     return total_credits;
//   }

//   double moyenneUnites(data) {
//     this.calcul_moy(data);
//     var moyenneU = this.moy;
//     return moyenneU;
//   }

//   void credUnites() {
//     // if unit average is up to 10 then all modules set up their credits
//     // else make sum of existing modules crédits
//     credit = set_credits(moy);
//     //~ var credit = 7;
//   }

//   List get_data() {
//     List data = [];

//     for (var i = 0; i < modules.length; i++) {
//       Map module_data = modules[i].get_data();
//       data.add({modules[i].name: module_data});
//     }

//     data.add({
//       name: {'moy': moy, 'credit': credit}
//     });
//     return data;
//   }

//   List getView(NoteController controller) {
//     List<TableRow> items = [];
//     for (var item in modules) {
//       items.add(item.getView(controller));
//     }
//     // TODO: Add Table cell here

//     items.add(TableRow(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(UNITY_START_COLOR),
//               Color(SEMESTRE_END_COLOR),
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         children: [
//           TableCell(
//             child: Container(
//               height: 35,
//               // color: Colors.red,
//               child: Center(
//                 child: textUnity(title),
//               ),
//             ),
//           ),
//           TableCell(child: Center(child: textUnity("4"))),
//           TableCell(child: Center(child: textUnity("4"))),
//           TableCell(
//             child: Container(),
//           ),
//           TableCell(child: Center(child: textUnity("4"))),
//           TableCell(child: Center(child: textUnity("4"))),
//         ]));
//     return items;
//   }
// }

// // -----------------
// // MODULE
// // -----------------
// class Module {
//   Module(Map data) {
//     name = data['name'];
//     title = data['title'];
//     coef = data['coef'];
//     credit = data['credit'];
//     poids = data['poids'];

//     poids_tp = poids[2] / 100;
//     poids_td = poids[1] / 100;
//     poids_exam = poids[0] / 100;
//     moy = 0;
//   }

//   late String name, title;
//   late int coef, credit;
//   late List<int> poids;
//   late double poids_tp, poids_td, poids_exam;
//   late double moy;

//   late int credit_result = 0;

//   bool calcul_moy(Map data) {
//     bool is_module_valid = true;
//     moy = 0;

//     // validate tp note
//     if (poids_tp > 0) {
//       int tp_note = data[name]['tp'];
//       if (tp_note < 0) {
//         is_module_valid = false;
//       } else {
//         // if valid calc moy
//         moy += tp_note * poids_tp;
//       }
//     }

//     // validate td note
//     if (poids_td > 0) {
//       int td_note = data[name]['td'];
//       if (td_note < 0) {
//         is_module_valid = false;
//       } else {
//         // if valid calc moy
//         moy += td_note * poids_td;
//       }
//     }

//     // validate exam note
//     if (poids_exam > 0) {
//       int exam_note = data[name]['exam'];
//       if (exam_note < 0) {
//         is_module_valid = false;
//       } else {
//         // if valid calc moy
//         moy += exam_note * poids_exam;
//         data[name]['moy'] = moy;
//         print("name ${name} moy=${moy}");
//       }
//     }

//     return is_module_valid;
//   }

//   // TODO: fix this
//   void set_credit(result) {
//     print("excuted");
//     if (moy >= 10) {
//       credit_result = credit;
//     } else {
//       credit_result = 0;
//     }
//   }

//   double moyennemodule2(data) {
//     // list of ids
//     var module = name;
//     //~ var poids = module_obj.poids;
//     // html items' IDs
//     // calcul moyen
//     calcul_moy(data);
//     var moy = this.moy;
//     this.set_credit(moy);

//     // TODO: I removed this because it's not html
//     // this.set_moy(moy);

//     return moy;
//   }

//   Map get_data() {
//     return {
//       'moy': moy,
//       'credit': credit_result,
//     };
//   }

//   TableRow getView(NoteController controller) {
//     return TableRow(
//       children: [
//         TableCell(
//           child: Container(
//             // height: 60,
//             // color: Colors.red,
//             constraints: BoxConstraints(minHeight: 60),
//             padding: const EdgeInsets.symmetric(vertical: 2),
//             child: Center(
//               child: textTable(title),
//             ),
//           ),
//         ),
//         TableCell(child: Center(child: Text(coef.toString()))),
//         TableCell(child: Center(child: Text(credit.toString()))),
//         TableCell(
//           child: Container(
//             // color: Colors.red,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 if (poids_tp != 0) module_button("TP", 'tp', controller),
//                 if (poids_td != 0) module_button("TD", 'td', controller),
//                 module_button("Exam", 'exam', controller),
//               ],
//             ),
//           ),
//         ),
//         TableCell(
//             child: Center(
//                 child:
//                     Text(controller.getValue(name, 'moy').toStringAsFixed(2)))),
//         TableCell(child: Center(child: Text(credit_result.toString()))),
//       ],
//     );
//   }

//   Container module_button(var title, var type, NoteController controller) {
//     WidgetHelp widgetHelp = WidgetHelp();

//     return Container(
//       constraints: BoxConstraints(maxWidth: 100),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.black45),
//         borderRadius: BorderRadius.circular(15),
//         color: Colors.white,
//       ),
//       margin: EdgeInsets.symmetric(vertical: 1.5, horizontal: 5),
//       padding: EdgeInsets.symmetric(vertical: 2),
//       alignment: Alignment.center,
//       child: InkWell(
//         onTap: () async {
//           double? value =
//               await widgetHelp.asyncInputDialog(Get.context!, "hello", "test");
//           if (value != null && value >= 0 && value <= 20) {
//             controller.setValue(name, type, value);
//           }
//           // print(value);
//         },
//         child: Text(
//           controller.getValue(name, type).toString() == '-1'
//               ? title
//               : controller.getValue(name, type).toString(),
//         ),
//       ),
//     );
//   }

//   Dialog getDialog(String type) {
//     String temp_value = '';
//     return Dialog(
//       child: Container(
//         constraints: BoxConstraints(maxWidth: 200),
//         height: 150,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             titleTable("insert ${type}"),
//             SizedBox(height: 5),
//             Container(
//               width: 200,
//               child: TextField(
//                 onChanged: (s) => temp_value = s,
//               ),
//             ),
//             SizedBox(height: 10),
//             Container(
//               height: 50,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   TextButton(
//                     onPressed: () {
//                       Get.back();
//                     },
//                     child: Text("back"),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       if (validate_valio(temp_value)) {
//                         Get.back(result: double.parse(temp_value));
//                       } else {
//                         // TODO: set error
//                       }
//                     },
//                     child: Text("save"),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   bool validate_valio(String value) {
//     try {
//       double note = double.parse(value);
//       if (note > 20 || note < 0) return false;
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }
// }

// class WidgetHelp {
//   Future<double?> asyncInputDialog(
//       BuildContext context, String text, String type) async {
//     double note = -1;
//     final formKey = GlobalKey<FormState>();
//     String? check_valide(String? text) {
//       try {
//         if (text == null) {
//           return "pls insert value";
//         }
//         double a = double.parse(text.toString());
//         print(a);
//         return (a <= 20 && a >= 0) ? null : "Erreur de numéro";
//       } catch (e) {
//         print(e);
//         return "Erreur de numéro";
//       }
//     }

//     return showDialog<double>(
//       context: context,
//       barrierDismissible:
//           false, // dialog is dismissible with a tap on the barrier
//       builder: (BuildContext context) {
//         return SingleChildScrollView(
//           child: AlertDialog(
//             title: Text('Entrerz la note de ${text}'),
//             content: Container(
//               child: Form(
//                 key: formKey,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: <Widget>[
//                     Container(
//                       margin: EdgeInsets.only(top: 30),
//                       alignment: Alignment.center,
//                       width: 150,
//                       child: TextFormField(
//                         autofocus: true,
//                         keyboardType: TextInputType.number,
//                         validator: check_valide,
//                         onSaved: (str) {
//                           note = num.parse(str!).toDouble();
//                         },
//                         onEditingComplete: () {
//                           var form = formKey.currentState;
//                           if (form!.validate()) {
//                             form.save();
//                             Navigator.of(context).pop(note);
//                           }
//                         },
//                         decoration: InputDecoration(
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             labelText: type,
//                             labelStyle: TextStyle(color: Colors.blue)),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             actions: <Widget>[
//               FlatButton(
//                 child: Text('Ok'),
//                 onPressed: () {
//                   var form = formKey.currentState;
//                   if (form!.validate()) {
//                     form.save();
//                     Navigator.of(context).pop(note);
//                   }
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
