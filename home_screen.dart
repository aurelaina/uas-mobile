import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/note_model.dart';
import 'add_edit_note.dart';
import 'detail_note.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Box<Note> noteBox = Hive.box<Note>('notesBox');

  Future<void> openWhatsApp(BuildContext context) async {
    final Uri url = Uri.parse("https://web.whatsapp.com");

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak bisa membuka WhatsApp')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Catatan"),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat),
            onPressed: () => openWhatsApp(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddEditNote()),
          );
        },
      ),
      body: ValueListenableBuilder<Box<Note>>(
        valueListenable: noteBox.listenable(),
        builder: (context, box, _) {
          if (box.isEmpty) {
            return const Center(child: Text("Belum ada catatan"));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final note = box.getAt(index);

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(
                    note!.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailNote(note: note, index: index),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
