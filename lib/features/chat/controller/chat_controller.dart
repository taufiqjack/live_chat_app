import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:live_chat_app/constants/firestore_constants.dart';
import 'package:live_chat_app/core/services/chat_provider.dart';
import 'package:live_chat_app/features/chat/view/chat_view.dart';
import 'package:toast/toast.dart';

class ChatController extends State<ChatView> {
  var textMessage = TextEditingController();

  List<QueryDocumentSnapshot> listMessage = [];
  String? currentUserId;
  int limit = 20;
  String groupChatId = '';
  @override
  void initState() {
    super.initState();
    readDocument();
  }

  void readDocument() {
    if (FirebaseAuth.instance.currentUser != null) {
      currentUserId = FirebaseAuth.instance.currentUser?.uid;

      String peerId = widget.currentUser;
      if (currentUserId!.compareTo(peerId) > 0) {
        groupChatId = '$currentUserId-$peerId';
      } else {
        groupChatId = '$peerId-$currentUserId';
      }
      ChatProvider.updateFirestoreData(
          FirestoreConstants.pathUserCollection, currentUserId!, {
        FirestoreConstants.chattingWith: widget.currentUser,
      });
    }
  }

  void onSendMessage(int type) async {
    if (textMessage.text.trim().isNotEmpty) {
      ChatProvider.sendMesaage(textMessage.text, type, groupChatId,
          currentUserId!, widget.currentUser);
      textMessage.clear();
    } else {
      Toast.show('Nothing to send',
          gravity: Toast.bottom, duration: Toast.lengthLong);
    }
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
