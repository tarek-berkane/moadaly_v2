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

const Map<String,List<String>> info_specialities = {
  "licence": ["L1MI", "L2Info", "L3ISIL", "L3SI"],
  "master": ["M1GSI", "M1ISIL", "M2GSI", "M2ISIL"],
};

const Map<String,List<String>> st_specialities = {
  "licence": ["L1ST"],
  "master": []
};

const Map<String,List<String>> sm_specialities = {
  "licence": ['L1SM'],
  "master": []
};

const all_specialities = {
  "info_specialities": info_specialities,
  "st_specialities": st_specialities,
  "sm_specialities": sm_specialities
};

const all_specialities_dep = {
  "info_specialities": "DÉPARTEMENT D'INFORMATIQUE",
  "st_specialities": "DÉPARTEMENT DES SCIENCES ET DE LA TECHNOLOGIE",
  "sm_specialities": "DÉPARTEMENT DES SCIENCES ET DE LA MATIÉRE"
};
