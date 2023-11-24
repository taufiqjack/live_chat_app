import 'package:badges/badges.dart%20';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:live_chat_app/core/models/user_chat_model.dart';
import 'package:live_chat_app/core/services/user_service.dart';
import 'package:live_chat_app/features/profile/controller/profile_controller.dart';
import 'package:live_chat_app/features/widgets/common_upload_widget.dart';
import 'package:badges/badges.dart' as badge;
import 'package:live_chat_app/routes/route.dart';
import 'package:skeleton_text/skeleton_text.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  Widget build(context, ProfileController controller) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Anda"),
      ),
      body: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StreamBuilder<DocumentSnapshot<Object?>>(
                    stream: userCollection.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) return const Text('error');
                      if (!snapshot.hasData) return const Text('No Data');
                      UserChatModel user = UserChatModel.fromDocument(
                          snapshot.data!.data() as DocumentSnapshot<Object?>);
                      return GestureDetector(
                        onTap: () {
                          uploadwidget(context, controller);
                        },
                        child: badge.Badge(
                          position: BadgePosition.custom(bottom: 0, end: 0),
                          badgeContent: const Icon(
                            FontAwesomeIcons.camera,
                            color: Colors.white,
                            size: 15,
                          ),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: user.photoUrl ??
                                  "https://i.ibb.co/S32HNjD/no-image.jpg",
                              height: Go.height / 5,
                              width: Go.width / 5,
                              placeholder: (context, url) => SkeletonAnimation(
                                  child: Container(
                                height: Go.height / 5,
                                width: Go.width / 5,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(Go.width / 5),
                                    color: Colors.grey),
                              )),
                            ),
                          ),
                        ),
                      );
                    }),
                Text(
                  "${FirebaseAuth.instance.currentUser!.displayName}",
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${FirebaseAuth.instance.currentUser!.email}",
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )),
      ),
    );
  }

  @override
  State<ProfileView> createState() => ProfileController();
}
