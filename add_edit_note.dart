import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/note_model.dart';

class AddEditNote extends StatelessWidget {
  final int? index;
  final Note? note;

  AddEditNote({this.index, this.note});

  final titleC = TextEditingController();
  final contentC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (note != null) {
      titleC.text = note!.title;
      contentC.text = note!.content;
    }

    final box = Hive.box<Note>('notesBox');

    return Scaffold(
      appBar: AppBar(title: Text("Tambah Catatan")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: titleC,
                decoration: InputDecoration(labelText: "Judul")),
            TextField(
                controller: contentC,
                decoration: InputDecoration(labelText: "Isi")),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (index == null) {
                  box.add(Note(title: titleC.text, content: contentC.text));
                } else {
                  box.putAt(
                      index!, Note(title: titleC.text, content: contentC.text));
                }
                Navigator.pop(context);
              },
              child: Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
