import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  String id;
  String title;
  String content;
  DateTime creationDate;
  DateTime lastEditDate;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.creationDate,
    required this.lastEditDate,
  });

  factory Note.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Note(
      id: doc.id,
      title: data['title'],
      content: data['content'],
      creationDate: (data['creationDate'] as Timestamp).toDate(),
      lastEditDate: (data['lastEditDate'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'content': content,
      'creationDate': Timestamp.fromDate(creationDate),
      'lastEditDate': Timestamp.fromDate(lastEditDate),
    };
  }
}
