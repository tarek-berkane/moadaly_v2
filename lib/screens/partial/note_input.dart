import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moadaly_app/controller/note_controller.dart';

class NoteInput extends StatefulWidget {
  NoteInput(
    this.title,
    this.noteType,
    this.noteController,
    this.semesterName,
    this.unityId,
    this.moduleId, {
    super.key,
  });

  String title;
  String noteType;
  NoteController noteController;
  String semesterName;
  int unityId;
  int moduleId;

  @override
  State<NoteInput> createState() => _NoteInputState();
}

class _NoteInputState extends State<NoteInput> {
  late TextEditingController _controller;
  bool _notValide = false;
  FocusNode focusNode = FocusNode();
  bool lostFocus = false;

  double? converToNumber(String value) {
    try {
      return double.parse(value);
    } catch (e) {
      return null;
    }
  }

  @override
  initState() {
    double note = widget.noteController.getModule(
        widget.semesterName, widget.unityId, widget.moduleId, widget.noteType);

    if (note < 0) {
      _controller = TextEditingController();
    } else {
      _controller = TextEditingController(text: note.toString());
    }

    focusNode.addListener(() async {
      if (!focusNode.hasFocus) {
        if (lostFocus == false) {
          lostFocus = true;
          await submitWithoutFocus();
        }
      }
    });


    super.initState();
  }

  Future<void> submitWithoutFocus() async {
    _notValide = !valueValide();
    if (valueValide()) {
      await widget.noteController.setModule(widget.semesterName, widget.unityId,
          widget.moduleId, widget.noteType, getNote());
    }
    setState(() {});
  }

  Future<void> submitNote() async {
    _notValide = !valueValide();
    if (valueValide()) {
      await widget.noteController.setModule(widget.semesterName, widget.unityId,
          widget.moduleId, widget.noteType, getNote());
    } else {
      focusNode.requestFocus();
    }
    setState(() {});
  }

  bool valueValide() {
    if (_controller.text.isNotEmpty) {
      double? note = converToNumber(_controller.text);
      if (note != null) {
        if (note >= 0 && note <= 20) {
          return true;
        }
      }
    }
    return false;
  }

  double getNote() {
    _controller.text.isEmpty ? _notValide = true : _notValide = false;
    double? note = converToNumber(_controller.text);
    return note!;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: TextField(
        maxLength: 5,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        onChanged: (value) => lostFocus = false,
        
        onSubmitted: (value) async => await submitNote(),
        textInputAction:
            widget.noteType == 'exam' ? null : TextInputAction.next,
        controller: _controller,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: _notValide ? Colors.red[500] : Colors.black,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 0),
          hintText: widget.noteType.toUpperCase(),
          counterText: "",
          hintStyle: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: _notValide ? Colors.red[500] : Colors.black,
          ),
          enabledBorder: _notValide
              ? UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red[500]!))
              : const UnderlineInputBorder(),
          focusedBorder: _notValide
              ? UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red[500]!))
              : const UnderlineInputBorder(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
