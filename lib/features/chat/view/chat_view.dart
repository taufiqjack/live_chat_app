import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:live_chat_app/core/models/chat_message_model.dart';
import 'package:live_chat_app/core/services/chat_provider.dart';
import 'package:live_chat_app/features/chat/controller/chat_controller.dart';

class ChatView extends StatefulWidget {
  final String currentUser;
  final String? title;
  final String? price;
  final String? image;
  const ChatView({
    super.key,
    this.title,
    this.price,
    this.image,
    required this.currentUser,
  });

  Widget build(BuildContext context, ChatController controller) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: const Text('Admin'),
        centerTitle: true,
        elevation: 0.5,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 16, right: 16),
        child: SingleChildScrollView(
          child: buildMessage(controller),
          /*  Column(
            children: [
              Align(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(title.toString()),
                                Text(price.toString()),
                              ])
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  child: const Text('Hay'),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  child: const Text('Hallo'),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  child: const Text('Apa Kabar?'),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  child: const Text('Alhamdulillah, baik'),
                ),
              ),
            ],
          ), */
        ),
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
    return Flexible(
        child: controller.groupChatId.isNotEmpty
            ? StreamBuilder<QuerySnapshot>(
                stream: ChatProvider.getChatMessage(
                    controller.groupChatId, controller.limit),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    controller.listMessage = snapshot.data!.docs;
                    if (controller.listMessage.isNotEmpty) {
                      return ListView.builder(
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          ChatMessageModel chatMessage =
                              ChatMessageModel.fromDocument(snapshot.data
                                  ?.docs[index] as DocumentSnapshot<Object?>);
                          return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white),
                                      child: Text('${chatMessage.content}'))));
                        },
                      );
                    } else {
                      return const Center(
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
              ));
  }

  @override
  State<StatefulWidget> createState() => ChatController();
}
