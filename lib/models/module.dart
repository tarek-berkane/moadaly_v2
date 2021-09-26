class Module {
  Module(this.data) {
    // initBuild(data);
    // moy = notes[name]['moy'];
    // creditObtained = notes[name]['credit'];
    // tp = notes[name]['tp'];
    // td = notes[name]['td'];
    // exam = notes[name]['exam'];
  }

  late Map data;
  late Map notes;
  // late String name, title;
  // late int coef, credit;
  // // late List<int> poids;
  // late double poidsTp, poidsTd, poidsExam;
  // double moy = 0;
  // double tp = -1, td = -1, exam = -1;

  // late int creditObtained = 0;

  // void initBuild(data) {
  //   name = data['name'];
  //   title = data['title'];
  //   coef = data['coef'];
  //   credit = data['credit'];
  //   poidsTp = data['poids_tp'];
  //   poidsTp = data['poids_td'];
  //   poidsExam = data['poids_exam'];
  // }

  void calculMoy() {
    // print("name ${data['name']} ${data['tp']} ${data['td']} ${data['exam']}");
    var moy = 0.0;

    if (data['poids_tp'] > 0) {
      if (data['tp'] < 0) {
        data['moy'] = 0;
        return;
      }
      moy += data['tp'] * data['poids_tp'];
    }

    if (data['poids_td'] > 0) {
      if (data['td'] < 0) {
        data['moy'] = 0;
        return;
      }
      moy += data['td'] * data['poids_td'];
    }

    if (data['poids_exam'] > 0) {
      if (data['exam'] < 0) {
        data['moy'] = 0;
        return;
      }
      moy += data['exam'] * data['poids_exam'];
    }
    data['moy'] = moy;
  }

  void setCredit(moy) {
    int creditObtained = 0;
    if (moy >= 10) {
      creditObtained = data['credit'];
    } else {
      creditObtained = 0;
    }

    data['credit_obtained'] = creditObtained;
  }

  // void moyennemodule2(data) {
  //   var module = name;

  //   calculMoy(data);
  //   var moy = this.moy;

  //   setCredit(moy);
  // }

  // Map getData() {
  //   return {
  //     name: {
  //       'title': title,
  //       'tp': tp,
  //       'td': td,
  //       'exam': exam,
  //       'credit': credit,
  //       'creditObtained': creditObtained,
  //       'coef': coef,
  //     }
  //   };
  // }

  // bool validateValue(String value) {
  //   try {
  //     double note = double.parse(value);
  //     if (note > 20 || note < 0) return false;
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }
}
