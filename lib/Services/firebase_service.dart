import 'package:cloud_firestore/cloud_firestore.dart';
class FirebaseService {

  // get a collection of notes.
  final CollectionReference notes = FirebaseFirestore.instance.collection(
    'notes',
  );

  // CREATE:
  Future<void> addNewnote(String note) {
    return notes.add({'name': note, 'TimeStamp': Timestamp.now()});
  }

  // READ:
  Stream<QuerySnapshot> getNoteStream() {
    final noteStream = notes.orderBy('TimeStamp', descending: true).snapshots();
    return noteStream;
  }

  // UPDATE:
  editNotes(String docId, String newNote) {
    return notes.doc(docId).update({
      'name':newNote,
      'TimeStamp':Timestamp.now()
    });
  }

  // DELETE:
  deleteNotes(String docId) {
    return notes.doc(docId).delete();
  }
}
