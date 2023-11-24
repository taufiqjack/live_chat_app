import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:live_chat_app/constants/firestore_constants.dart';
import 'package:live_chat_app/core/models/chat_message_model.dart';

class ChatProvider {
  static Future<void> updateFirestoreData(
      String collectionPath, String docPath, Map<String, dynamic> dataUpdate) {
    return FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(docPath)
        .update(dataUpdate);
  }

  static Stream<QuerySnapshot> getChatMessage(String groupChatId, int limit) {
    return FirebaseFirestore.instance
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy(FirestoreConstants.timestamp, descending: true)
        .limit(limit)
        .snapshots();
  }

  static void sendMesaage(String content, int type, String groupChatId,
      String currentUserId, String peerId) {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    ChatMessageModel messageModel = ChatMessageModel(
        idFrom: currentUserId,
        idTo: peerId,
        timeStamp: DateTime.now().millisecondsSinceEpoch.toString(),
        content: content,
        type: type);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(documentReference, messageModel.toJson());
    });
  }

  static void deleteMessageId(String groupChatId, String id) {
    FirebaseFirestore.instance
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(id)
        .delete();
  }

  static void deleteAllMessage(String groupChatId) {
    FirebaseFirestore.instance
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(groupChatId)
        .delete();
  }
}

class TypeMessage {
  static const text = 0;
  static const image = 1;
  static const sticker = 2;
}
