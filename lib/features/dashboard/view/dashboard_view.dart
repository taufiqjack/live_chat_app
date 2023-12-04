import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:live_chat_app/constants/firestore_constants.dart';
import 'package:live_chat_app/core/models/user_chat_model.dart';
import 'package:live_chat_app/core/services/dashboard_service.dart';
import 'package:live_chat_app/features/chat/view/chat_view.dart';
import 'package:live_chat_app/features/dashboard/controller/dashboard_controller.dart';
import 'package:live_chat_app/features/profile/view/profile_view.dart';
import 'package:live_chat_app/features/scanner/scanner_view/scanner_view.dart';
import 'package:live_chat_app/features/widgets/common_loading_dashboard.dart';
import 'package:live_chat_app/features/widgets/common_modal_progress.dart';
import 'package:live_chat_app/hive/hive_storage.dart';
import 'package:live_chat_app/routes/route.dart';
import 'package:skeleton_text/skeleton_text.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  Widget build(BuildContext context, DashboardController controller) {
    return ModalProgress(
        inAsyncCall: controller.isAsync,
        child: StreamBuilder(
          stream: DashboardService.getStreamFirestore(
              FirestoreConstants.pathUserCollection,
              controller.limit,
              controller.textSearch),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if ((snapshot.data?.docs.length ?? 0) > 0) {
                return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    elevation: 0.5,
                    centerTitle: true,
                    title: const Text(
                      'Mutiara Cosmetics',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        'Profile',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Icon(
                                        Icons.person,
                                        color: Colors.black,
                                      )
                                    ]),
                                onTap: () {
                                  SchedulerBinding.instance
                                      .addPostFrameCallback((timeStamp) {
                                    Go.to(const ProfileView());
                                  });
                                }),
                            PopupMenuItem(
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                                  Card(
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
                                  Card(
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
                                  Card(
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
                                ],
                              ),
                              const SizedBox(height: 10),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data?.docs.length,
                                itemBuilder: (context, index) {
                                  if (snapshot.data?.docs != null) {
                                    UserChatModel userChat =
                                        UserChatModel.fromDocument(
                                            snapshot.data?.docs[index]
                                                as DocumentSnapshot<Object?>);
                                    return userChat.id ==
                                            controller.currentUserId
                                        ? const SizedBox()
                                        : userChat.isAdmin ==
                                                loggedBox.get(
                                                    FirestoreConstants.isAdmin)
                                            ? const SizedBox()
                                            : userChat.isAdmin == true
                                                ? Column(
                                                    children: [
                                                      InkWell(
                                                        onTap: () =>
                                                            Go.to(ChatView(
                                                          userChatId:
                                                              userChat.id,
                                                          title: 'Skentific 5X',
                                                          price: 'Rp 176.200',
                                                          image:
                                                              'assets/images/skentific_5x.jpeg',
                                                          name: 'Admin',
                                                        )),
                                                        child: Card(
                                                          elevation: 0.5,
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          semanticContainer:
                                                              true,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: ListTile(
                                                              trailing: Text(
                                                                'Chat Admin',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red
                                                                        .shade600),
                                                              ),
                                                              leading:
                                                                  ClipRRect(
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/skentific_5x.jpeg',
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                              title: const Text(
                                                                  'Skentific 5X'),
                                                              subtitle: const Text(
                                                                  'Rp 176.200')),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () =>
                                                            Go.to(ChatView(
                                                          userChatId:
                                                              userChat.id,
                                                          title: 'Hanasui',
                                                          price: 'Rp 123.500',
                                                          image:
                                                              'assets/images/hanasui_lipcream.jpeg',
                                                          name: 'Admin',
                                                        )),
                                                        child: Card(
                                                          elevation: 0.5,
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          semanticContainer:
                                                              true,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: ListTile(
                                                              trailing: Text(
                                                                'Chat Admin',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red
                                                                        .shade600),
                                                              ),
                                                              leading:
                                                                  ClipRRect(
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/hanasui_lipcream.jpeg',
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                              title: const Text(
                                                                  'Skentific 5X'),
                                                              subtitle: const Text(
                                                                  'Rp 123.500')),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () =>
                                                            Go.to(ChatView(
                                                          userChatId:
                                                              userChat.id,
                                                          title:
                                                              'Skentific Sunscreen',
                                                          price: 'Rp 65.300',
                                                          image:
                                                              'assets/images/skentific_sunscreen.jpeg',
                                                          name: 'Admin',
                                                        )),
                                                        child: Card(
                                                          elevation: 0.5,
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          semanticContainer:
                                                              true,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: ListTile(
                                                              trailing: Text(
                                                                'Chat Admin',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red
                                                                        .shade600),
                                                              ),
                                                              leading:
                                                                  ClipRRect(
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/skentific_sunscreen.jpeg',
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                              title: const Text(
                                                                  'Skentific 5X'),
                                                              subtitle: const Text(
                                                                  'Rp 65.300')),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    child: Column(
                                                      children: [
                                                        InkWell(
                                                          onTap: () => Go.to(
                                                              ChatView(
                                                                  name: userChat
                                                                      .nickname,
                                                                  userChatId:
                                                                      userChat
                                                                          .id)),
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .transparent,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            child: Row(
                                                              children: [
                                                                CircleAvatar(
                                                                  child:
                                                                      ClipOval(
                                                                    child:
                                                                        CachedNetworkImage(
                                                                      height:
                                                                          Go.height /
                                                                              5,
                                                                      width:
                                                                          Go.width /
                                                                              5,
                                                                      imageUrl:
                                                                          userChat
                                                                              .photoUrl,
                                                                      placeholder: (context,
                                                                              url) =>
                                                                          SkeletonAnimation(
                                                                              child: Container(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade300,
                                                                        height:
                                                                            Go.height /
                                                                                5,
                                                                        width:
                                                                            Go.width /
                                                                                5,
                                                                      )),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                Text(
                                                                  userChat
                                                                              .isAdmin ==
                                                                          true
                                                                      ? 'Admin'
                                                                          .toUpperCase()
                                                                      : userChat
                                                                          .nickname
                                                                          .toUpperCase(),
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  floatingActionButton:
                      loggedBox.get(FirestoreConstants.isAdmin) != true
                          ? null
                          : FloatingActionButton(
                              onPressed: () => Go.to(const ScannerView()),
                              child: const Icon(Icons.qr_code_sharp),
                            ),
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
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  elevation: 0.5,
                  centerTitle: true,
                  title: const Text(
                    'Mutiara Cosmetics',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                ),
                body: const CommonLoadingDashboard(),
              );
            }
          },
        ));
  }

  @override
  State<StatefulWidget> createState() => DashboardController();
}
