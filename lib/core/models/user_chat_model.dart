import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:live_chat_app/constants/firestore_constants.dart';

class UserChatModel {
  final String id;
  final String photoUrl;
  final String nickname;
  final String aboutMe;

  const UserChatModel(
      {required this.id,
      required this.photoUrl,
      required this.nickname,
      required this.aboutMe});

  Map<String, String> toJson() {
    return {
      FirestoreConstants.nickname: nickname,
      FirestoreConstants.aboutMe: aboutMe,
      FirestoreConstants.photoUrl: photoUrl,
    };
  }

  factory UserChatModel.fromDocument(DocumentSnapshot doc) {
    String aboutMe = "";
    String photoUrl = "";
    String nickname = "";
    try {
      aboutMe = doc.get(FirestoreConstants.aboutMe);
    } catch (e) {}
    try {
      photoUrl = doc.get(FirestoreConstants.photoUrl);
    } catch (e) {}
    try {
      nickname = doc.get(FirestoreConstants.nickname);
    } catch (e) {}
    return UserChatModel(
      id: doc.id,
      photoUrl: photoUrl,
      nickname: nickname,
      aboutMe: aboutMe,
    );
  }
}
