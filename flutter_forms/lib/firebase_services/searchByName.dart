import 'package:cloud_firestore/cloud_firestore.dart';

class SearchServiceByName {
  searchByName(String searchField) {
    return Firestore.instance
        .collection('user')
        .where('searchKeyName',
        isEqualTo: searchField.substring(0, 1))
        .getDocuments();
  }
}