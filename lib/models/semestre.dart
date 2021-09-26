import 'dart:math' as math;

import 'unity.dart';

// -----------
// SEMESTER
// -----------
class Semestre {
  Semestre(this.data) {
    initBuild(data);
  }

  late Map data;
  // late Map notes;
  // late String name;
  List<Unity> unites = [];
  // late double moy = 0;
  // late int coef = 0;
  // late int creditsOrigine = 0;
  // late int credits = 0;

  void initBuild(data) {
    for (var unity in data['unites']) {
      unites.add(Unity(unity));
    }
  }

  void calculMoy() {
    data['moy'] = 0;
    double totalNotes = 0;
    var totalCoef = 0;

    for (var i = 0; i < unites.length; i++) {
      unites[i].calculMoy();
      totalCoef += unites[i].data['coef'] as int;
      totalNotes += unites[i].data['moy'] * unites[i].data['coef'];
      // print("${data['name']} totalNotes ${totalNotes}");
    }

    data['moy'] = totalNotes / totalCoef;
    // data['coef'] = totalCoef;
    // notes[name]['moy'] = moy;
    // setCredits(moy);
  }

  setCredits() {
    // if moy is up to 10, get all credits
    int totalCredits = 0;

    for (var i = 0; i < unites.length; i++) {
      var moyUnite = unites[i].data['moy'];

      // setup credit for the module if the unit moy is up to 10, or the module moy is up to 10
      unites[i].setCredits(math.max<double>(data['moy'], moyUnite));

      // sum credits
      // if ((moy >= 10) || (moy_unite >= 10))
      totalCredits += unites[i].data['credit'] as int;
    }
    data['credits'] = totalCredits;
    // notes[name]['credit'] = totalCredits;
  }

  // Map getData() {
  //   List unitesData = [];

  //   for (var i = 0; i < unites.length; i++) {
  //     unitesData.add(unites[i].getData());
  //   }

  //   return {
  //     'name': name,
  //     'unites': unitesData,
  //   };
  // }
}
