import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fitness_ai/core/models/note.dart'; // Import Note model

class AppProvider extends ChangeNotifier {
  // Backend Configuration
  String? backendUrl = dotenv.env['BACKEND_URL'];

  AppProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    if (backendUrl == null) {
      print("Warning: BACKEND_URL environment variable is not set. "
          "Please configure your backend URL.");
    } else {
      // Backend URL is configured (or not, if it's null)
      // You can add backend initialization logic here,
      // like connecting to a database or API client.
    }
  }

  // App-level state variables and methods will go here
  List<Note> diaryNotes = [];

  void addNote(Note note) {
    diaryNotes.add(note);
    notifyListeners();
  }

  void updateNote(Note updatedNote) {
    final index = diaryNotes.indexWhere((note) => note.id == updatedNote.id);
    if (index != -1) {
      diaryNotes[index] = updatedNote;
      notifyListeners();
    }
  }

  void deleteNote(Note note) {
    diaryNotes.remove(note);
    notifyListeners();
  }

  Future<void> fetchNotes() async {
    print('AppProvider.fetchNotes() called'); // Debug print

    // For now, using dummy data
    diaryNotes = [
      Note(
        id: '1',
        title: 'My First Note',
        content: 'This is my first diary note.',
        creationDate: DateTime.now(),
        lastEditDate: DateTime.now(),
      ),
      Note(
        id: '2',
        title: 'Workout Today',
        content: 'Had a great workout session today!',
        creationDate: DateTime.now(),
        lastEditDate: DateTime.now(),
      ),
    ];
    print(
        'AppProvider.fetchNotes(): diaryNotes populated: ${diaryNotes.length} notes'); // Debug print
    notifyListeners();
    print('AppProvider.fetchNotes(): notifyListeners() called'); // Debug print
  }
}
