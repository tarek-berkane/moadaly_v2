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

  // Map generateNotes(Map data) {
  //   Map result = {};

  //   result[year.name] = {'moy': year.moy, "credit": year.credit};

  //   Semestre s1 = year.semestre1;
  //   result[s1.name] = {'moy': s1.moy, "credit": s1.credits};

  //   for (var unity in s1.unites) {
  //     result[unity.name] = {'moy': unity.moy, 'credit': unity.credit};

  //     for (var module in unity.modules) {
  //       result[module.name] = {
  //         'moy': module.moy,
  //         'credit': module.credit,
  //         'tp': -1,
  //         'td': -1,
  //         "exam": -1
  //       };
  //     }
  //   }

  //   Semestre s2 = year.semestre2;
  //   result[s2.name] = {'moy': s2.moy, "credit": s2.credits};

  //   for (var unity in s2.unites) {
  //     result[unity.name] = {'moy': unity.moy, 'credit': unity.credit};

  //     for (var module in unity.modules) {
  //       result[module.name] = {
  //         'moy': module.moy,
  //         'credit': module.credit,
  //         'tp': -1,
  //         'td': -1,
  //         "exam": -1
  //       };
  //     }
  //   }

  //   return result;
  // }

  // void convertNote(data) {
  //   data['credits_origine'] = 0;
  //   data['credits'] = 0;
  //   data['coef'] = 0;

  //   for (var unity in data['semestre1']) {
  //     for (var module in unity['modules']) {
  //       module['tp'] = -1;
  //       module['td'] = -1;
  //       module['exam'] = -1;
  //       module['credit_obtained']=0;
  //     }
  //   }

  //   for (var unity in data['semestre2']) {
  //     for (var module in unity['modules']) {
  //       module['tp'] = -1;
  //       module['td'] = -1;
  //       module['exam'] = -1;
  //       module['credit_obtained'] = 0;
  //     }
  //   }
  // }

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
