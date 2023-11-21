import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:live_chat_app/constants/firestore_constants.dart';
import 'package:live_chat_app/core/models/user_chat_model.dart';
import 'package:live_chat_app/core/services/dashboard_service.dart';
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
                  children: [
                    GridView(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 2.7 / 4,
                      ),
                      children: [
                        InkWell(
                          onTap: () => Go.to(ChatView(
                            currentUser: FirebaseAuth.instance.currentUser!.uid,
                            title: 'Hanasui',
                            price: 'Rp 123.500',
                            image: 'assets/images/hanasui_lipcream.jpeg',
                          )),
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            semanticContainer: true,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              children: [
                                ClipRRect(
                                  child: Image.asset(
                                    'assets/images/hanasui_lipcream.jpeg',
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text('Hanasui'),
                                      SizedBox(height: 5),
                                      Text(
                                        'Rp 123.500',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => Go.to(ChatView(
                            currentUser: FirebaseAuth.instance.currentUser!.uid,
                            title: 'Skentific 5X',
                            price: 'Rp 176.200',
                            image: 'assets/images/skentific_5x.jpeg',
                          )),
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            semanticContainer: true,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              children: [
                                ClipRRect(
                                  child: Image.asset(
                                    'assets/images/skentific_5x.jpeg',
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text('Skentific 5X'),
                                      SizedBox(height: 5),
                                      Text(
                                        'Rp 176.200',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => Go.to(ChatView(
                            currentUser: FirebaseAuth.instance.currentUser!.uid,
                            title: 'Skentific Sunscreen',
                            price: 'Rp 65.300',
                            image: 'assets/images/skentific_sunscreen.jpeg',
                          )),
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            semanticContainer: true,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              children: [
                                ClipRRect(
                                  child: Image.asset(
                                    'assets/images/skentific_sunscreen.jpeg',
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text('Skentific Sunscreen'),
                                      SizedBox(height: 5),
                                      Text(
                                        'Rp 65.300',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    StreamBuilder(
                      stream: DashboardService.getStreamFirestore(
                          FirestoreConstants.pathUserCollection,
                          controller.limit,
                          controller.textSearch),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if ((snapshot.data?.docs.length ?? 0) > 0) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data?.docs.length,
                              itemBuilder: (context, index) {
                                if (snapshot.data?.docs != null) {
                                  UserChatModel userChat =
                                      UserChatModel.fromDocument(
                                          snapshot.data?.docs[index]
                                              as DocumentSnapshot<Object?>);
                                  return userChat.id == controller.currentUserId
                                      ? const SizedBox()
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: InkWell(
                                            onTap: () => Go.to(ChatView(
                                                currentUser: userChat.id)),
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade600,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    backgroundImage:
                                                        NetworkImage(
                                                            userChat.photoUrl),
                                                    radius: 20,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    userChat.nickname
                                                        .toUpperCase(),
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            );
                          } else {
                            return const Center(
                              child: Text(
                                'No User not found',
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.chat),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => DashboardController();
}
