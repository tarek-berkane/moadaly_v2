import 'package:flutter/material.dart';
import 'package:get/state_manager.dart' as state;

import 'package:moadaly_app/components/text.dart';
import 'package:moadaly_app/controller/note_controller.dart';
import 'package:moadaly_app/screens/partial/note_input.dart';

// ----------
// YEAR
// ----------
class NoteTableBuilder {
  NoteTableBuilder(this.noteController);
  late Map rawData;
  NoteController noteController;

  Widget getView(BuildContext context) => buildYearTable(context);

  Widget buildYearTable(context) {
    return GestureDetector(
       onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
      },
      child: state.GetBuilder<NoteController>(
        init: noteController, // INIT IT ONLY THE FIRST TIME
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
            decoration: BoxDecoration(
              color: Colors.grey[700]
              // gradient: LinearGradient(
              //   colors: [
              //     Color(UNITY_START_COLOR),
              //     Color(UNITY_START_COLOR),
              //     Color(SEMESTRE_END_COLOR),
              //   ],
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              // ),
            ),
            children: [
              TableCell(
                child: SizedBox(
                  height: 40,
                  // color: Colors.red,
                  child: Center(child: textTable("Semestre/année",color: Colors.white)),
                ),
              ),
              TableCell(child: textTable("Moyenne",color: Colors.white)),
              TableCell(child: textTable("Crédits",color: Colors.white)),
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
        0: FlexColumnWidth(0.65),
        1: FixedColumnWidth(40),
        2: FixedColumnWidth(40),
        3: FlexColumnWidth(0.35),
        4: FixedColumnWidth(60),
        5: FixedColumnWidth(40),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          decoration:  BoxDecoration(
            color: Colors.grey[700],
            // gradient: LinearGradient(
            //   colors: [
            //     Color.fromARGB(255, 91, 91, 91),
            //     Color.fromARGB(255, 49, 49, 49),
            //   ],
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            // ),
          ),
          children: [
            TableCell(
              child: SizedBox(
                height: 40,
                // color: Colors.red,
                child: Center(child: textTable("Modules",color: Colors.white)),
              ),
            ),
            TableCell(child: textTable("Coef",color: Colors.white)),
            TableCell(child: textTable("Cred",color: Colors.white)),
            TableCell(
              child: Container(child: textTable("Note",color: Colors.white)),
            ),
            TableCell(
              child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: textTable("Moyenne module",color: Colors.white)),
            ),
            TableCell(
              child: textTable("Cred Mod",color: Colors.white),
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
        decoration: BoxDecoration(
          color: Colors.grey[300]
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
            padding: const EdgeInsets.symmetric(vertical: 2,horizontal:4 ),
            child: Center(
              child: textTable(controller.notes[semesterName]['unites'][unityId]
                  ['modules'][moduleId]['title'],fontSize: 10),
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
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (controller.notes[semesterName]['unites'][unityId]['modules']
                        [moduleId]['poids_tp'] !=
                    0)
                  NoteInput(
                      "TP", 'tp', controller, semesterName, unityId, moduleId),
                if (controller.notes[semesterName]['unites'][unityId]['modules']
                        [moduleId]['poids_td'] !=
                    0)
                  NoteInput(
                      "TD", 'td', controller, semesterName, unityId, moduleId),
                NoteInput("Exam", 'exam', controller, semesterName, unityId,
                    moduleId),
                const SizedBox(height: 10),
              ],
            ),
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
}

