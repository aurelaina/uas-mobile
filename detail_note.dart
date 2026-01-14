import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/note_model.dart';
import 'add_edit_note.dart';

class DetailNote extends StatelessWidget {
  final Note note;
  final int index;

  DetailNote({required this.note, required this.index});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Note>('notesBox');

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text("Hapus"),
                  content: Text("Yakin hapus catatan?"),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context), child: Text("Batal")),
                    TextButton(
                      onPressed: () {
                        box.deleteAt(index);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text("Hapus"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(note.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(note.content),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddEditNote(index: index, note: note),
                  ),
                );
              },
              child: Text("Edit"),
            ),
          ],
        ),
      ),
    );
  }
}
