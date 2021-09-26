import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:moadaly_v2/constants.dart';

Widget textTable(String text) {
  return Text(
    text,
    style: TABLE_TEXT_STYLE,
    textAlign: TextAlign.center,
  );
}

Widget textUnity(String text) {
  return Text(
    text,
    style: UNITY_RESULT_ROW_STYLE,
    textAlign: TextAlign.center,
  );
}

Widget titleTable(String text) {
  return Container(
    height: 40,
    child: Text(
      text,
      style: TABLE_TITLE_STYLE,
    ),
    alignment: Alignment.center,
    decoration: const BoxDecoration(
      color: Colors.blueAccent,
    ),
  );
}
