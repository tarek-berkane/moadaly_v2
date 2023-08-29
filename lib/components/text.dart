import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:moadaly_app/constants.dart';

Widget textTable(String text, {Color? color, double? fontSize}) {
  return Text(
    text,
    style: GoogleFonts.poppins(
      color: color ?? Colors.black,
      fontSize: fontSize ?? 11,
      fontWeight: FontWeight.w700,
    ),
    textAlign: TextAlign.center,
  );
}


Widget textUnity(String text, {Color? color}) {
  return Text(
    text,
    style: GoogleFonts.poppins(
      color: color ?? Colors.black,
      fontSize: 11,
      fontWeight: FontWeight.w700,
    ),
    textAlign: TextAlign.center,
  );
}

Widget titleTable(String text) {
  return Container(
    height: 40,
    alignment: Alignment.center,
    decoration: const BoxDecoration(
      color: Colors.white60,
    ),
    child: Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w700
      ),
    ),
  );
}
