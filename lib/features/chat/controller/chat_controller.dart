import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:live_chat_app/constants/firestore_constants.dart';
import 'package:live_chat_app/core/services/chat_provider.dart';
import 'package:live_chat_app/features/chat/view/chat_view.dart';
import 'package:toast/toast.dart';

class ChatController extends State<ChatView> {
  var textMessage = TextEditingController();
  final ScrollController scrollController = ScrollController();

  List<QueryDocumentSnapshot> listMessage = [];
  String? currentUserId;
  int limit = 20;
  int limitIncrement = 20;
  String groupChatId = '';
  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
    readDocument();
  }

  scrollListener() {
    if (!scrollController.hasClients) return;
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange &&
        limit <= listMessage.length) {
      limit += limitIncrement;
      setState(() {});
    }
  }

  void readDocument() {
    if (FirebaseAuth.instance.currentUser != null) {
      currentUserId = FirebaseAuth.instance.currentUser?.uid;

      String peerId = widget.userChatId;
      if (currentUserId!.compareTo(peerId) > 0) {
        groupChatId = '$currentUserId-$peerId';
      } else {
        groupChatId = '$peerId-$currentUserId';
      }
      ChatProvider.updateFirestoreData(
          FirestoreConstants.pathUserCollection, currentUserId!, {
        FirestoreConstants.chattingWith: widget.userChatId,
      });
    }
  }

  void onSendMessage(int type) async {
    if (textMessage.text.trim().isNotEmpty) {
      ChatProvider.sendMesaage(textMessage.text, type, groupChatId,
          currentUserId!, widget.userChatId);
      textMessage.clear();
      if (scrollController.hasClients) {
        scrollController.animateTo(-1,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    } else {
      Toast.show('Nothing to send',
          gravity: Toast.bottom, duration: Toast.lengthLong);
    }
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
