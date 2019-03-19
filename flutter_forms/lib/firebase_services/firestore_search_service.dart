import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  searchByName(String searchField) {
    return Firestore.instance
        .collection('user')
        .where('searchKey',
        isEqualTo: searchField.substring(0, 1))
        .getDocuments();
  }
}