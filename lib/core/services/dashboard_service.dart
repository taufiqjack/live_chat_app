import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:live_chat_app/constants/firestore_constants.dart';

class DashboardService {
  static Future<void> updateDataFirestore(
      String collectionPath, String path, Map<String, dynamic> dataNeedUpdate) {
    return FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(path)
        .update(dataNeedUpdate);
  }

  static Stream<QuerySnapshot> getStreamFirestore(
      String pathCollection, int limit, String? textSearch) {
    if (textSearch?.isNotEmpty == null) {
      return FirebaseFirestore.instance
          .collection(pathCollection)
          .limit(limit)
          .where(FirestoreConstants.nickname, isEqualTo: textSearch)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection(pathCollection)
          .limit(limit)
          .snapshots();
    }
  }

  static Future<dynamic>? getDatabase() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('products').get();
  }
}
