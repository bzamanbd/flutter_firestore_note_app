import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //to create and save note//
  Future insertNote(String title, description, userid) async {
    try {
      await firestore.collection('notes').add({
        'title': title,
        'description': description,
        'userid': userid,
        'date': DateTime.now(),
      });
    } catch (e) {
      return e.toString();
    }
  }

  //to update the exist note//
  Future updateNote(String docId, title, description) async {
    try {
      await firestore.collection('notes').doc(docId).update({
        'title': title,
        'description': description,
      });
    } catch (e) {
      return e.toString();
    }
  }

  //to update the exist note//
  Future deleteNote(String docId) async {
    try {
      await firestore.collection('notes').doc(docId).delete();
    } catch (e) {
      return e.toString();
    }
  }
}
