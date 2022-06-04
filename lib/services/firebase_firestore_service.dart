import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> setDataForCollection(
      {required String collectionName,
      required String userEmail,
      required String text}) async {
    await _db.collection(collectionName).doc(userEmail).set(
      {'text': text},
    );
  }

  Future<List<String>?> getDataFromCollection(
      {required String userEmail,
      required String collectionName,
      required String key}) async {
    List<String> list = [];
    QuerySnapshot<Map<String, dynamic>> data = await _db
        .collection(collectionName)
        .where('__name__', isEqualTo: userEmail)
        .get();
    if (data.docs.isNotEmpty) {
      for (var doc in data.docs) {
        list.add(doc.data()[key]);
      }
      return list;
    } else {
      return null;
    }
  }
}
