import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_ai/core/models/note.dart';
import 'package:fitness_ai/core/ui/screens/note_editing_screen.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({Key? key}) : super(key: key);

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  final CollectionReference notesCollection =
      FirebaseFirestore.instance.collection('notes');

  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    _fetchNotes();
  }

  Future<void> _fetchNotes() async {
    final QuerySnapshot snapshot = await notesCollection.get();
    final List<Note> fetchedNotes =
        snapshot.docs.map((doc) => Note.fromFirestore(doc)).toList();
    setState(() {
      notes = fetchedNotes;
    });
  }

  Future<void> _addNoteToFirestore(Note note) async {
    await notesCollection.add(note.toFirestore());
  }

  Future<void> _updateNoteInFirestore(Note note) async {
    await notesCollection.doc(note.id).update(note.toFirestore());
  }

  Future<void> _deleteNoteFromFirestore(Note note) async {
    await notesCollection.doc(note.id).delete();
  }

  void _createNewNote() async {
    final Note? newNote = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NoteEditingScreen(),
      ),
    );

    if (newNote != null) {
      await _addNoteToFirestore(newNote);
      setState(() {
        notes.add(newNote);
      });
    }
  }

  void _editNote(Note note) async {
    final updatedNote = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteEditingScreen(note: note),
      ),
    ) as Note?;

    if (updatedNote != null) {
      await _updateNoteInFirestore(updatedNote);
      setState(() {
        final index = notes.indexOf(note);
        if (index != -1) {
          notes[index] = updatedNote;
        }
      });
    }
  }

  void _deleteNote(Note note) async {
    await _deleteNoteFromFirestore(note);
    setState(() {
      notes.remove(note);
    });
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
      body: notes.isEmpty
          ? const Center(
              child: Text(
                'No notes yet. Click + to create one.',
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return _buildNoteCard(note);
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
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
