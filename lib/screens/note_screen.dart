import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:moadaly_app/components/note_table_builder.dart';
import 'package:moadaly_app/controller/note_controller.dart';
import 'package:moadaly_app/utils/file.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen(this.fileName, {Key? key}) : super(key: key);
  final String fileName;

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  Map? schema;
  NoteController? noteController;
  NoteTableBuilder? noteTableBuilder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () async {
              await noteController!.clearData();
              setState(() {});
            },
            icon: const Icon(Icons.clear),
            tooltip: "Clear data",
          )
        ],
        title: Text(
          widget.fileName,
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: loadingData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const InfoScreen(
                image: 'assets/icons/loading.png', message: "Loading data");
          }

          if (snapshot.data == true) {
            return NoteTable(
              noteTableBuilder: noteTableBuilder,
              context: context,
            );
          }

          return const InfoScreen(
              image: 'assets/icons/warning.png', message: "Error");
        },
      ),
    );
  }

  Future<bool> loadingData() async {
    schema = await loadSchema(widget.fileName);
    if (schema != null) {
      noteController = NoteController(schema!);
      await noteController!.loadDumpedData();
      noteTableBuilder = NoteTableBuilder(noteController!);
      return true;
    }
    return false;
  }
}

class NoteTable extends StatelessWidget {
  const NoteTable({
    super.key,
    required this.noteTableBuilder,
    required this.context,
  });

  final NoteTableBuilder? noteTableBuilder;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: noteTableBuilder!.getView(context),
    );
  }
}

class InfoScreen extends StatelessWidget {
  const InfoScreen({required this.image, required this.message, super.key});

  final String image;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: Image.asset(image),
            ),
            const SizedBox(height: 10),
            Text(
              message,
              style: GoogleFonts.poppins(
                  fontSize: 15, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
