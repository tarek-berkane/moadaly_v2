import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:moadaly_v2/main.dart';
import 'package:moadaly_v2/models.dart';
import 'package:moadaly_v2/models/module.dart';
import 'package:moadaly_v2/models/year.dart';

class NoteController extends GetxController {
  NoteController(Map data) {
    convertNote(data);
    year = Year(data);
    notes = data;
    // notes = generateNotes(data);
  }

  late Year year;
  late Map notes;
  // late Map notes;


  void convertNote(data) {
    data['credits_origine'] = 0;
    data['credits'] = 0;
    data['coef'] = 0;

    data["semestre1"]['credits'] = 0;
    data["semestre2"]['credits'] = 0;

    for (var unity in data['semestre1']['unites']) {
      for (var module in unity['modules']) {
        module['tp'] = -1;
        module['td'] = -1;
        module['exam'] = -1;
        module['credit_obtained'] = 0;
      }
    }

    for (var unity in data['semestre2']['unites']) {
      for (var module in unity['modules']) {
        module['tp'] = -1;
        module['td'] = -1;
        module['exam'] = -1;
        module['credit_obtained'] = 0;
      }
    }
  }

  void setModule(
      String semesterName, int unity, int module, String type, double note) {
    notes[semesterName]["unites"][unity]["modules"][module][type] = note;
    year.clac();
    // print("here");
    update();
  }

  double getSemester(String semesterName, String type) {
    try {
      return notes[semesterName][type].toDouble();
    } catch (e) {
      // print(e);
      // print("${semesterName} ${type}");
      return 0;
    }
  }

  double getUnity(String semesterName, int unity, String type) {
    return notes[semesterName]["unites"][unity][type].toDouble();
  }

  double getModule(String semesterName, int unity, int module, String type) {
    return notes[semesterName]["unites"][unity]["modules"][module][type]
        .toDouble();
  }

  double getYear(String type) {
    return notes[type].toDouble();
  }
}
