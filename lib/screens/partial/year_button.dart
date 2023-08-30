import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:moadaly_2_1/screens/note_screen.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:get/route_manager.dart';

class YearButton extends StatelessWidget {
  const YearButton(this.text, {Key? key}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 100),
      child: Card(
        color: Colors.white,
        elevation: 2,
        child: InkWell(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
            alignment: Alignment.center,
            child: Text(
              text,
              style: GoogleFonts.poppins(
                color: const Color.fromARGB(255, 43, 58, 79),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          onTap: () async {
            Get.to(NoteScreen(text));
          },
        ),
      ),
    );
  }
}
