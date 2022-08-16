import 'package:cloud_firestore/cloud_firestore.dart';

class NotesModel {
  String? docId;
  String? title;
  String? description;
  Timestamp? time;
  String? attachment;

  NotesModel(
      {this.docId, this.title, this.description, this.time, this.attachment});

  NotesModel.fromMap(DocumentSnapshot data) {
    docId = data.id;
    title = data['title'];
    description = data['description'];
    time = data['time'];
    attachment = data['attachment'];
  }
}
