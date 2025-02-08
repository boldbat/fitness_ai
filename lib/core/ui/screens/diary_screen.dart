import 'package:flutter/material.dart';
import 'package:fitness_ai/core/models/note.dart';
import 'package:fitness_ai/core/ui/screens/note_editing_screen.dart';
import 'package:fitness_ai/core/services/note_service.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({Key? key}) : super(key: key);

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  final NoteService _noteService = NoteService();
  late Future<List<Note>> _notesFuture;

  @override
  void initState() {
    super.initState();
    _notesFuture = _noteService.getNotes();
  }

  Future<void> _refreshNotes() async {
    setState(() {
      _notesFuture = _noteService.getNotes();
    });
  }

  void _createNewNote() async {
    final Note? newNote = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NoteEditingScreen(),
      ),
    );
    if (newNote != null) {
      await _noteService.createNote(newNote);
      _refreshNotes();
    }
  }

  void _editNote(Note note) async {
    final Note? updatedNote = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteEditingScreen(note: note),
      ),
    );
    if (updatedNote != null) {
      await _noteService.updateNote(updatedNote);
      _refreshNotes();
    }
  }

  void _deleteNote(Note note) async {
    await _noteService.deleteNote(note.id);
    _refreshNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Diary'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _createNewNote,
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<List<Note>>(
        future: _notesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.white)));
          }
          final notes = snapshot.data ?? [];
          if (notes.isEmpty) {
            return const Center(
              child: Text(
                'No notes yet. Click + to create one.',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: _refreshNotes,
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return _buildNoteCard(note);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildNoteCard(Note note) {
    return GestureDetector(
      onTap: () => _editNote(note),
      onLongPress: () => _deleteNote(note),
      child: Card(
        color: Colors.grey[900],
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                note.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
