import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // get collection of notes
  final CollectionReference notes;
  FirestoreService({required this.notes});
  // CREATE: add new note
  Future addnote(String note) {
    return notes.add({
      'note': note,
      'timestamp': Timestamp.now(),
    });
  }

  // READ: get notes from database
  Stream getnoteScteam() {
    final noteStream = notes.orderBy('timestamp', descending: true).snapshots();
    return noteStream;
  }

  // Update: editing and updating the note
  Future updateNote(String docID, String newNoteText) {
    return notes.doc(docID).update({
      'note': newNoteText,
      'timestamp': Timestamp.now(),
    });
  }

  // DELETE: delete notes from given doc id
  Future deleteNote(String docID) {
    return notes.doc(docID).delete();
  }
}
