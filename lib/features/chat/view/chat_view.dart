import 'package:flutter/material.dart';
import 'package:live_chat_app/features/chat/controller/chat_controller.dart';

class ChatView extends StatefulWidget {
  final String? title;
  final String? price;
  final String? image;
  const ChatView({
    super.key,
    this.title,
    this.price,
    this.image,
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
          child: Column(
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
          ),
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
              decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'Tulis pesanmu',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.grey)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          )),
        ),
        InkWell(
          onTap: () {},
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

  @override
  State<StatefulWidget> createState() => ChatController();
}
