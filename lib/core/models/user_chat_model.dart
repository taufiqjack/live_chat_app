// ignore_for_file: empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:live_chat_app/constants/firestore_constants.dart';

class UserChatModel {
  final String id;
  final String photoUrl;
  final String nickname;
  final String aboutMe;
  final bool isAdmin;

  const UserChatModel({
    required this.id,
    required this.photoUrl,
    required this.nickname,
    required this.aboutMe,
    required this.isAdmin,
  });

  Map<String, String> toJson() {
    return {
      FirestoreConstants.nickname: nickname,
      FirestoreConstants.aboutMe: aboutMe,
      FirestoreConstants.photoUrl: photoUrl,
      FirestoreConstants.isAdmin: isAdmin.toString(),
    };
  }

  factory UserChatModel.fromDocument(DocumentSnapshot doc) {
    String aboutMe = "";
    String photoUrl = "";
    String nickname = "";
    bool? isAdmin;
    try {
      aboutMe = doc.get(FirestoreConstants.aboutMe);
    } catch (e) {}
    try {
      photoUrl = doc.get(FirestoreConstants.photoUrl);
    } catch (e) {}
    try {
      nickname = doc.get(FirestoreConstants.nickname);
    } catch (e) {}
    try {
      isAdmin = doc.get(FirestoreConstants.isAdmin);
    } catch (e) {}
    return UserChatModel(
      id: doc.id,
      photoUrl: photoUrl,
      nickname: nickname,
      aboutMe: aboutMe,
      isAdmin: isAdmin!,
    );
  }
}
