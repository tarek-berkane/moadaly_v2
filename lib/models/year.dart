import 'semestre.dart';

class Year {
  // late String name;
  // late double moy = 0;
  // int credit = 0;

  Year(this.data) {
    initBuild(data);
  }

  late Semestre semestre1, semestre2;
  late Map data;

  void initBuild(data) {
    semestre1 = Semestre(data['semestre1']);
    semestre2 = Semestre(data['semestre2']);
    someOfCredits();
  }

  // Map generateNotes(Map data) {
  //   Map result = {};

  //   result[name] = {'moy': moy, "credit": credit};

  //   Semestre s1 = semestre1;
  //   result[s1.name] = {'moy': s1.moy, "credit": s1.credits};

  //   for (var unity in s1.unites) {
  //     result[unity.name] = {
  //       'moy': unity.moy,
  //       'credit': unity.creditObtained,
  //       'origin_credit': unity.creditsOrigine
  //     };

  //     for (var module in unity.modules) {
  //       result[module.name] = {
  //         'moy': module.moy,
  //         'origin_credit': module.credit,
  //         'credit': module.credit,
  //         'coef': module.coef,
  //         'tp': -1,
  //         'td': -1,
  //         "exam": -1
  //       };
  //     }
  //   }

  //   Semestre s2 = semestre2;
  //   result[s2.name] = {'moy': s2.moy, "credit": s2.credits};

  //   for (var unity in s2.unites) {
  //     result[unity.name] = {'moy': unity.moy, 'credit': unity.creditObtained};

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

  void clac() {
    semestre1.calculMoy();
    semestre2.calculMoy();

    var moy = (semestre1.data['moy'] * semestre1.data['coef'] +
            semestre2.data['moy'] * semestre2.data['coef']) /
        (semestre1.data['coef'] + semestre2.data['coef']);
    // print("moy general ${semestre1.data['moy']} ${semestre2.data['moy']}");
    data['moy'] = moy;
    calcCredit();
  }

  void calcCredit() {
    semestre1.setCredits();
    semestre2.setCredits();
    if (data['moy'] >= 10) {
      data['credits'] = data['credits_origine'];
    } else {
      data['credits'] = semestre1.data['credits'] + semestre2.data['credits'];
    }
  }

  void someOfCredits() {
    int some = 0;

    for (var unite in semestre1.unites) {
      for (var j in unite.modules) {
        some += j.data['credit'] as int;
      }
    }

    for (var unite in semestre2.unites) {
      for (var j in unite.modules) {
        some += j.data['credit'] as int;
      }
    }

    data['credits_origine'] = some;
  }

  // Map getNotes() {
  //   return notes;
  // }
}
