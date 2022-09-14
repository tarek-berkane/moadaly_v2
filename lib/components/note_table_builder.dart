import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart' as state;
import 'package:get/get.dart';

import 'package:moadaly_v2/components/text.dart';
import 'package:moadaly_v2/constants.dart';
import 'package:moadaly_v2/controller/note_controller.dart';

// ----------
// YEAR
// ----------
class NoteTableBuilder {
  NoteTableBuilder(this.rawData);
  late Map rawData;

  Widget getView() => buildYearTable();

  Widget buildYearTable() {
    return state.GetBuilder<NoteController>(
      init: NoteController(rawData), // INIT IT ONLY THE FIRST TIME
      builder: (controller) => ListView(
        children: [
          titleTable("SEMESTER 1"),
          buildSemester(controller, 'semestre1'),
          const SizedBox(height: 50),
          titleTable("SEMESTER 2"),
          buildSemester(controller, 'semestre2'),
          const SizedBox(height: 50),
          buildMoyTable(controller),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget buildMoyTable(NoteController controller) {
    return Center(
      child: Table(
        border: TableBorder.all(),
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(0.5),
          1: FlexColumnWidth(0.25),
          2: FlexColumnWidth(0.25),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(UNITY_START_COLOR),
                  Color(UNITY_START_COLOR),
                  Color(SEMESTRE_END_COLOR),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            children: [
              TableCell(
                child: SizedBox(
                  height: 40,
                  // color: Colors.red,
                  child: Center(child: textTable("Semestre/année")),
                ),
              ),
              TableCell(child: textTable("Moyenne")),
              TableCell(child: textTable("Crédits")),
            ],
          ),
          TableRow(
            decoration: const BoxDecoration(color: Colors.white12),
            children: [
              TableCell(
                child: SizedBox(
                  height: 40,
                  // color: Colors.red,
                  child: Center(
                    child: textTable(
                      "semestre1",
                    ),
                  ),
                ),
              ),
              TableCell(
                child: Center(
                  child: textTable(
                    controller
                        .getSemester('semestre1', 'moy')
                        .toStringAsFixed(2),
                  ),
                ),
              ),
              TableCell(
                child: Center(
                  child: textTable(
                    controller
                        .getSemester('semestre1', 'credits')
                        .toStringAsFixed(2),
                  ),
                ),
              ),
            ],
          ),
          TableRow(
            decoration: const BoxDecoration(color: Colors.white12),
            children: [
              TableCell(
                child: Container(
                  height: 40,
                  // color: Colors.red,
                  child: Center(
                    child: textTable(
                      "semestre2",
                    ),
                  ),
                ),
              ),
              TableCell(
                child: Center(
                  child: textTable(
                    controller
                        .getSemester('semestre2', 'moy')
                        .toStringAsFixed(2),
                  ),
                ),
              ),
              TableCell(
                child: Center(
                  child: textTable(
                    controller
                        .getSemester('semestre2', 'credits')
                        .toStringAsFixed(2),
                  ),
                ),
              ),
            ],
          ),
          TableRow(
            decoration: const BoxDecoration(color: Colors.white12),
            children: [
              TableCell(
                child: SizedBox(
                  height: 40,
                  // color: Colors.red,
                  child: Center(
                    child: textTable(
                      "Année",
                    ),
                  ),
                ),
              ),
              TableCell(
                child: Center(
                  child: textTable(
                    controller.getYear('moy').toStringAsFixed(2),
                  ),
                ),
              ),
              TableCell(
                child: Center(
                  child: textTable(
                    controller.getYear('credits').toStringAsFixed(2),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSemester(NoteController controller, String semesterName) {
    return Table(
      border: TableBorder.all(),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(0.6),
        1: FixedColumnWidth(40),
        2: FixedColumnWidth(40),
        3: FlexColumnWidth(0.4),
        4: FixedColumnWidth(60),
        5: FixedColumnWidth(40),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(UNITY_START_COLOR),
                Color(SEMESTRE_END_COLOR),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          children: [
            TableCell(
              child: SizedBox(
                height: 40,
                // color: Colors.red,
                child: Center(child: textTable("Modules")),
              ),
            ),
            TableCell(child: textTable("Coef")),
            TableCell(child: textTable("Cred")),
            TableCell(
              child: Container(child: textTable("Note")),
            ),
            TableCell(
              child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: textTable("Moyenne module")),
            ),
            TableCell(
              child: textTable("Cred Mod"),
            ),
          ],
        ),
        for (int i = 0;
            i < controller.notes[semesterName]['unites'].length;
            i++)
          ...buildUnity(controller, semesterName, i),
        TableRow(
            decoration: const BoxDecoration(color: Colors.white12),
            children: [
              TableCell(
                child: SizedBox(
                  height: 40,
                  // color: Colors.red,
                  child: Center(
                      child: textTable(controller.notes[semesterName]['name'])),
                ),
              ),
              TableCell(
                  child: Center(
                      child: textTable(
                          controller.notes[semesterName]['coef'].toString()))),
              TableCell(
                  child: Center(
                      child: textTable(controller.notes[semesterName]
                              ['credits_origine']
                          .toString()))),
              TableCell(
                child: Container(
                  child: Center(
                    child: Text(""),
                  ),
                ),
              ),
              TableCell(
                  child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Center(
                    child: textTable(
                  controller.notes[semesterName]['moy'].toStringAsFixed(2),
                )),
              )),
              TableCell(
                child: Center(
                  child: textTable(
                    controller.notes[semesterName]['credits'].toString(),
                  ),
                ),
              ),
            ]),
      ],
    );
  }

  List buildUnity(NoteController controller, String semesterName, int unityId) {
    List<TableRow> items = [];
    for (int i = 0;
        i < controller.notes[semesterName]['unites'][unityId]['modules'].length;
        i++) {
      items.add(
        buildModule(
          controller,
          semesterName,
          unityId,
          i,
        ),
      );
    }
    // TODO: Add Table cell here

    items.add(TableRow(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(UNITY_START_COLOR),
              Color(SEMESTRE_END_COLOR),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        children: [
          TableCell(
            child: SizedBox(
              height: 35,
              // color: Colors.red,
              child: Center(
                // child: textUnity("here"),
                child: textUnity(
                    "Unité ${controller.notes[semesterName]['unites'][unityId]['title']}"),
              ),
            ),
          ),
          TableCell(
              child: Center(
                  child: textUnity(controller.notes[semesterName]['unites']
                          [unityId]['coef']
                      .toString()))),
          TableCell(
              child: Center(
                  child: textUnity(controller.notes[semesterName]['unites']
                          [unityId]['credits_origine']
                      .toString()))),
          TableCell(
            child: Container(),
          ),
          TableCell(
            child: Center(
              child: textUnity(
                controller
                    .getUnity(semesterName, unityId, 'moy')
                    .toStringAsFixed(2),
              ),
            ),
          ),
          TableCell(
            child: Center(
              child: textUnity(
                controller.getUnity(semesterName, unityId, 'credit').toString(),
              ),
            ),
          ),
        ]));
    return items;
  }

  TableRow buildModule(NoteController controller, String semesterName,
      int unityId, int moduleId) {
    return TableRow(
      children: [
        TableCell(
          child: Container(
            // height: 60,
            // color: Colors.red,
            constraints: const BoxConstraints(minHeight: 60),
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Center(
              child: textTable(controller.notes[semesterName]['unites'][unityId]
                  ['modules'][moduleId]['title']),
            ),
          ),
        ),
        TableCell(
            child: Center(
                child: Text(controller.notes[semesterName]['unites'][unityId]
                        ['modules'][moduleId]['coef']
                    .toString()))),
        TableCell(
            child: Center(
                child: Text(controller.notes[semesterName]['unites'][unityId]
                        ['modules'][moduleId]['credit']
                    .toString()))),
        TableCell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (controller.notes[semesterName]['unites'][unityId]['modules']
                      [moduleId]['poids_tp'] !=
                  0)
                moduleButton(
                    "TP", 'tp', controller, semesterName, unityId, moduleId),
              if (controller.notes[semesterName]['unites'][unityId]['modules']
                      [moduleId]['poids_td'] !=
                  0)
                moduleButton(
                    "TD", 'td', controller, semesterName, unityId, moduleId),
              moduleButton("Exam", 'exam', controller, semesterName, unityId,
                  moduleId),
            ],
          ),
        ),
        TableCell(
          child: Center(
            child: Text(
              controller
                  .getModule(semesterName, unityId, moduleId, 'moy')
                  .toStringAsFixed(2),
            ),
          ),
        ),
        TableCell(
          child: Center(
            child: Text(
              controller
                  .getModule(semesterName, unityId, moduleId, 'credit_obtained')
                  .toString(),
            ),
          ),
        ),
      ],
    );
  }

  Container moduleButton(var title, var type, NoteController controller,
      String semesterName, int unityId, int moduleId) {
    WidgetHelp widgetHelp = WidgetHelp();

    return Container(
      constraints: const BoxConstraints(maxWidth: 100),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white54),
        borderRadius: BorderRadius.circular(15),
        // color: Colors.white,
      ),
      margin: const EdgeInsets.symmetric(vertical: 1.5, horizontal: 5),
      padding: const EdgeInsets.symmetric(vertical: 2),
      alignment: Alignment.center,
      child: InkWell(
        onTap: () async {
          double? value =
              await widgetHelp.asyncInputDialog(Get.context!, title, type);
          if (value != null && value >= 0 && value <= 20) {
            controller.setModule(semesterName, unityId, moduleId, type, value);
          }
          // print(value);
        },
        child: Container(
          alignment: Alignment.center,
          child: Text(
            controller.getModule(semesterName, unityId, moduleId, type) < 0
                ? title
                : controller
                    .getModule(semesterName, unityId, moduleId, type)
                    .toString(),
          ),
        ),
      ),
    );
  }
}

// --
class WidgetHelp {
  Future<double?> asyncInputDialog(
      BuildContext context, String text, String type) async {
    double note = -1;
    final formKey = GlobalKey<FormState>();
    String? checkValide(String? text) {
      try {
        if (text == null) {
          return "pls insert value";
        }
        double a = double.parse(text.toString());
        // print(a);
        return (a <= 20 && a >= 0) ? null : "Erreur de numéro";
      } catch (e) {
        // print(e);
        return "Erreur de numéro";
      }
    }

    return showDialog<double>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text('Entrerz la note de $text'),
            content: Form(
              key: formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    alignment: Alignment.center,
                    width: 150,
                    child: TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      validator: checkValide,
                      onSaved: (str) {
                        note = num.parse(str!).toDouble();
                      },
                      onEditingComplete: () {
                        var form = formKey.currentState;
                        if (form!.validate()) {
                          form.save();
                          Navigator.of(context).pop(note);
                        }
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          labelText: type,
                          labelStyle: const TextStyle(color: Colors.blue)),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  var form = formKey.currentState;
                  if (form!.validate()) {
                    form.save();
                    Navigator.of(context).pop(note);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
