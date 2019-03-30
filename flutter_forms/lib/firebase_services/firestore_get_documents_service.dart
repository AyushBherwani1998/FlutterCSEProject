import 'package:cloud_firestore/cloud_firestore.dart';

class GetDocuments {
  getFirestoreDocuments() {
    return Firestore.instance
        .collection('recent_entries').getDocuments();
  }
}