import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  String id;
  String title;
  String description;
  String userid;
  Timestamp date;

  NoteModel({
    required this.id,
    required this.title,
    required this.description,
    required this.userid,
    required this.date,
  });

  //taking the snapshots of document and keeping the values//
  factory NoteModel.fromJson(DocumentSnapshot snapshot) {
    return NoteModel(
        id: snapshot.id,
        title: snapshot['title'],
        description: snapshot['description'],
        userid: snapshot['userid'],
        date: snapshot['date']
    );
  }
}
