const specialities = [
  "L1MI",
  "L1SM",
  "L1ST",
  "L2Info",
  "L3ISIL",
  "L3SI",
  "M1GSI",
  "M1ISIL",
  "M2GSI",
  "M2ISIL"
];

const Map<String, List<String>> info_specialities = {
  "licence": ["L1MI", "L2Info", "L3ISIL", "L3SI"],
  "master": [
    "M1GSI",
    "M2GSI",
    "M1ISIL",
    "M2ISIL",
    "M1IA",
    "M2IA",
    "M1GSI old",
    "M1ISIL old",
    "M2GSI old",
    "M2ISIL old"
  ],
};

const Map<String, List<String>> st_specialities = {
  "licence": ["L1ST"],
  "master": []
};

const Map<String, List<String>> sm_specialities = {
  "licence": ['L1SM'],
  "master": []
};

const Map<String, List<String>> other_specialities = {
  "licence": [
    "L1arab",
    "L1droit",
    "L1economie",
    "L1francais",
    "L1humaines",
    "L1islamic",
    "L1politics",
    "L1sociales",
  ],
  "master": []
};

const all_specialities = {
  "info_specialities": info_specialities,
  "st_specialities": st_specialities,
  "sm_specialities": sm_specialities,
  "other_specialities": other_specialities,
};

const all_specialities_dep = {
  "info_specialities": "DÉPARTEMENT D'INFORMATIQUE",
  "st_specialities": "DÉPARTEMENT DES SCIENCES ET DE LA TECHNOLOGIE",
  "sm_specialities": "DÉPARTEMENT DES SCIENCES ET DE LA MATIÉRE",
  "other_specialities": "AUTRES DÉPARTEMENTS",
};
