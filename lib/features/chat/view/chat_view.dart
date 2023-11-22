import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:live_chat_app/constants/datetime_constant.dart';
import 'package:live_chat_app/constants/string_extension.dart';
import 'package:live_chat_app/core/models/chat_message_model.dart';
import 'package:live_chat_app/core/services/chat_provider.dart';
import 'package:live_chat_app/features/chat/controller/chat_controller.dart';

class ChatView extends StatefulWidget {
  final String userChatId;
  final String name;
  final String? title;
  final String? price;
  final String? image;
  const ChatView({
    super.key,
    this.title,
    this.price,
    this.image,
    required this.userChatId,
    required this.name,
  });

  Widget build(BuildContext context, ChatController controller) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: Text(name),
        centerTitle: true,
        elevation: 0.5,
        actions: [
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: const Text(
                    'Delete all chat',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  onTap: () {},
                )
              ];
            },
          )
        ],
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 15, left: 16, right: 16, bottom: 60),
        child: SingleChildScrollView(
            controller: controller.scrollController,
            reverse: true,
            child: Column(
              children: [
                image != null
                    ? Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width / 5),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Kamu mananyakan produk ini'),
                              const Divider(),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Image.asset(
                                    image.toString(),
                                    height: 75,
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(title.toString()),
                                        Text(price.toString()),
                                      ])
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(),
                buildMessage(controller),
              ],
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(children: [
        InkWell(
          onTap: () {},
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: const Center(
              child: Icon(Icons.add),
            ),
          ),
        ),
        Flexible(
          child: TextFormField(
              controller: controller.textMessage,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: 'Tulis pesanmu',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.grey)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              )),
        ),
        InkWell(
          onTap: () => controller.onSendMessage(TypeMessage.text),
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: const Center(
              child: Icon(Icons.send),
            ),
          ),
        ),
      ]),
    );
  }

  Widget buildMessage(ChatController controller) {
    return controller.groupChatId.isNotEmpty
        ? StreamBuilder<QuerySnapshot>(
            stream: ChatProvider.getChatMessage(
                controller.groupChatId, controller.limit),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                controller.listMessage = snapshot.data!.docs;
                if (controller.listMessage.isNotEmpty) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      ChatMessageModel chatMessage =
                          ChatMessageModel.fromDocument(snapshot
                              .data?.docs[index] as DocumentSnapshot<Object?>);
                      return Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 8),
                        child: Slidable(
                          endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  backgroundColor: Colors.red.shade300,
                                  onPressed: (context) {
                                    ChatProvider.deleteMessageId(
                                        controller.groupChatId,
                                        chatMessage.timeStamp!);
                                  },
                                  icon: Icons.delete,
                                )
                              ]),
                          child: Align(
                            alignment: image == null
                                ? chatMessage.idFrom == userChatId
                                    ? Alignment.topLeft
                                    : Alignment.topRight
                                : Alignment.topRight,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: chatMessage.idFrom != userChatId
                                      ? Colors.green.shade300
                                      : Colors.white),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${chatMessage.content}',
                                    style: TextStyle(
                                        color: chatMessage.idFrom != userChatId
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                  Text(
                                    chatMessage.timeStamp!
                                        .fromMiliSecond()
                                        .toTime(),
                                    style: TextStyle(
                                        fontSize: 8,
                                        color: chatMessage.idFrom != userChatId
                                            ? Colors.black54
                                            : Colors.black),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'No Message here',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  @override
  State<StatefulWidget> createState() => ChatController();
}
