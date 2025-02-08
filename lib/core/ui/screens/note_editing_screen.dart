import 'package:flutter/material.dart';
import 'package:fitness_ai/core/models/note.dart';
import 'package:fitness_ai/core/services/note_service.dart';

class NoteEditingScreen extends StatefulWidget {
  final Note? note;

  const NoteEditingScreen({Key? key, this.note}) : super(key: key);

  @override
  State<NoteEditingScreen> createState() => _NoteEditingScreenState();
}

class _NoteEditingScreenState extends State<NoteEditingScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  final NoteService _noteService = NoteService();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController =
        TextEditingController(text: widget.note?.content ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.note == null ? 'Create New Note' : 'Edit Note',
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save, color: Colors.white),
            onPressed: _saveNote,
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              style: const TextStyle(color: Colors.white, fontSize: 24),
              decoration: const InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null,
                expands: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Start writing...',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveNote() async {
    final note = Note(
      id: widget.note?.id ?? '',
      title: _titleController.text,
      content: _contentController.text,
      creationDate: widget.note?.creationDate ?? DateTime.now(),
      lastEditDate: DateTime.now(),
    );

    Note? savedNote;
    if (widget.note == null) {
      savedNote = await _noteService.createNote(note);
    } else {
      savedNote = await _noteService.updateNote(note);
    }

    if (savedNote != null) {
      Navigator.pop(context, savedNote);
    } else {
      // Handle error, maybe show a snackbar
      print('Failed to save note');
      Navigator.pop(context); // Pop without returning note
    }
  }
}
