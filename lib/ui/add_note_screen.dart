import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lab7/providers/note_provider.dart';
import 'package:lab7/data/note_model.dart';

class AddNoteScreen extends StatefulWidget {
  final Note? note;
  const AddNoteScreen({super.key, this.note});

  @override
  createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _saveNote() {
    if (_formKey.currentState!.validate()) {
      final note = Note(
        id: widget.note?.id,
        title: _titleController.text,
        description: _descriptionController.text,
        dateTime: widget.note == null ? DateTime.now() : widget.note?.dateTime,
      );

      // Use the provider to save the note
      final provider = Provider.of<NoteProvider>(context, listen: false);
      if (widget.note == null) {
        provider.addNote(note);
      } else {
        provider.updateNote(note);
      }
      Navigator.pop(context);
    }
  }

  // add the current note's title and description to the controllers so you don't have to put everything in every time
  void _applyCurrentNoteInfo(Note note) {
    _titleController.text = note.title;
    _descriptionController.text = note.description;
  }

  @override
  Widget build(BuildContext context) {
    // if the note exists already, apply its title and description to the controllers
    if (widget.note != null) {
      _applyCurrentNoteInfo(widget.note!);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.note == null
              ? "Creating Note"
              : "Editing Note ${widget.note?.id}",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveNote,
        child: const Icon(Icons.save),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: .center,
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "ENTER A TITLE";
                }
                return null;
              },
              controller: _titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter title",
              ),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                // border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ],
        ),
      ),
    );
  }
}
