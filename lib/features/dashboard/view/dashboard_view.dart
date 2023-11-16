import 'package:flutter/material.dart';
import 'package:live_chat_app/features/chat/view/chat_view.dart';
import 'package:live_chat_app/features/dashboard/controller/dashboard_controller.dart';
import 'package:live_chat_app/features/widgets/common_modal_progress.dart';
import 'package:live_chat_app/routes/route.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  Widget build(BuildContext context, DashboardController controller) {
    return ModalProgress(
      inAsyncCall: controller.isAsync,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0.5,
          centerTitle: true,
          title: const Text(
            'Live Chat',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            PopupMenuButton(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Icon(
                            Icons.logout,
                            color: Colors.black,
                          )
                        ]),
                    onTap: () => controller.logout(),
                  )
                ];
              },
            )
          ],
        ),
        body: WillPopScope(
          onWillPop: () => controller.willPop(),
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Start Chat'),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Go.to(
            const ChatView(),
          ),
          child: const Icon(Icons.chat),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => DashboardController();
}
