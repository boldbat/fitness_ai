import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_ai/core/models/note.dart';

class NoteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _notesCollection =
      FirebaseFirestore.instance.collection('notes');

  Future<List<Note>> getNotes() async {
    try {
      QuerySnapshot notesSnapshot = await _notesCollection
          .orderBy('creationDate', descending: true)
          .get();
      return notesSnapshot.docs.map((doc) => Note.fromFirestore(doc)).toList();
    } catch (e) {
      print("Error fetching notes: $e");
      return [];
    }
  }

  Future<Note?> createNote(Note note) async {
    try {
      DocumentReference docRef = await _notesCollection.add(note.toFirestore());
      DocumentSnapshot snapshot = await docRef.get();
      return Note.fromFirestore(snapshot);
    } catch (e) {
      print("Error creating note: $e");
      return null;
    }
  }

  Future<Note?> updateNote(Note note) async {
    try {
      await _notesCollection.doc(note.id).update(note.toFirestore());
      DocumentSnapshot snapshot = await _notesCollection.doc(note.id).get();
      return Note.fromFirestore(snapshot);
    } catch (e) {
      print("Error updating note: $e");
      return null;
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      await _notesCollection.doc(noteId).delete();
    } catch (e) {
      print("Error deleting note: $e");
    }
  }
}
