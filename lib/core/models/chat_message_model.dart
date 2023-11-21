import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:live_chat_app/constants/firestore_constants.dart';

class ChatMessageModel {
  String? idFrom;
  String? idTo;
  String? timeStamp;
  String? content;
  int? type;

  ChatMessageModel({
    this.idFrom,
    this.idTo,
    this.timeStamp,
    this.content,
    this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      FirestoreConstants.idFrom: idFrom,
      FirestoreConstants.idTo: idTo,
      FirestoreConstants.timestamp: timeStamp,
      FirestoreConstants.content: content,
      FirestoreConstants.type: type,
    };
  }

  factory ChatMessageModel.fromDocument(DocumentSnapshot doc) {
    String idFrom = doc.get(FirestoreConstants.idFrom);
    String idTo = doc.get(FirestoreConstants.idTo);
    String timeStamp = doc.get(FirestoreConstants.timestamp);
    String content = doc.get(FirestoreConstants.content);
    int type = doc.get(FirestoreConstants.type);
    return ChatMessageModel(
        idFrom: idFrom,
        idTo: idTo,
        timeStamp: timeStamp,
        content: content,
        type: type);
  }
}
