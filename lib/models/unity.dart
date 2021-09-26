import 'dart:io';
import 'dart:math' as math;

import 'module.dart';

class Unity {
  Unity(this.data) {
    assert(data.isNotEmpty);
    initBuild(data);
    // moy = notes[name]['moy'];
    // creditObtained = notes[name]['credit'];
  }

  // late Map notes;
  // late String title, name;
  Map data;
  List<Module> modules = [];
  // int coef = 0, creditObtained = 0, creditsOrigine = 0;
  // double moy = 0;

  void initBuild(data) {
    // name = data['name'];
    // title = data['title'];

    for (var module in data['modules']) {
      // print(module);

      modules.add(Module(module));
    }
    // exit(1);
  }

  void calculMoy() {
    data['moy'] = 0;
    // datacoef = 0;
    double totalNotes = 0;

    // print("Unity ${data['name']}");
    for (var i = 0; i < modules.length; i++) {
      modules[i].calculMoy();
      totalNotes += modules[i].data['moy'] * modules[i].data['coef'];
      // print("module ${modules[i].data['name']} ${modules[i].data['moy']}");

      // coef += modules[i].coef;
    }
    // print('\n');
    // print('\n\n');

    data['moy'] = totalNotes / data['coef'];
    // notes[name]['moy'] = moy;
  }

  void setCredits(moy) {
    // if moy is up to 10, get all credits
    int totalCredits = 0;

    for (var i = 0; i < modules.length; i++) {
      double moyModule = modules[i].data['moy'] * 1.0;

      // setup credit for the module if the unit moy is up to 10, or the module moy is up to 10
      modules[i].setCredit(math.max<double>(moy, moyModule));

      // sum credits
      if ((moy >= 10) || (moyModule >= 10)) {
        totalCredits += modules[i].data['credit_obtained'] as int;
      }
    }

    data['credit'] = totalCredits;
    // return totalCredits;
  }

  // double moyenneUnites(data) {
  //   // calculMoy(data);
  //   var moyenneU = moy;
  //   return moyenneU;
  // }

  // void credUnites() {
  //   // if unit average is up to 10 then all modules set up their credits
  //   // else make sum of existing modules crédits
  //   creditObtained = setCredits(moy);
  //   //~ var credit = 7;
  // }

  // Map getData() {
  //   List modulesData = [];

  //   for (var module in modules) {
  //     modulesData.add(module.getData());
  //   }

  //   return {
  //     name: {
  //       'title': title,
  //       'modules': modulesData,
  //     }
  //   };
  // }
}
