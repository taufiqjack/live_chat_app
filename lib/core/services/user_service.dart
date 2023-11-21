import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:live_chat_app/constants/firestore_constants.dart';
import 'package:live_chat_app/core/models/user_model.dart';

DocumentReference get userCollection {
  return FirebaseFirestore.instance
      .collection(FirestoreConstants.pathUserCollection)
      .doc(FirebaseAuth.instance.currentUser!.uid);
}

class UserService {
  static createUserIfNotExists() async {
    var snapshot = await userCollection.get();
    if (!snapshot.exists) {
      await userCollection.set({
        FirestoreConstants.id: FirebaseAuth.instance.currentUser!.uid,
        FirestoreConstants.photoUrl:
            FirebaseAuth.instance.currentUser!.photoURL,
        FirestoreConstants.email: FirebaseAuth.instance.currentUser!.email,
        FirestoreConstants.nickname:
            FirebaseAuth.instance.currentUser!.displayName,
      });
    }
  }

  static getUserData() {
    return {
      FirestoreConstants.id: FirebaseAuth.instance.currentUser!.uid,
      FirestoreConstants.email: FirebaseAuth.instance.currentUser!.email,
      FirestoreConstants.nickname:
          FirebaseAuth.instance.currentUser!.displayName,
    };
  }

  static getUser() async {
    final documentSnapshot = FirebaseFirestore.instance
        .collection(FirestoreConstants.pathUserCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid) as Map<String, dynamic>;

    return UserModel.fromJson(documentSnapshot);
  }

  static updateProfil(String newProfilePic) async {
    await userCollection.update({
      FirestoreConstants.photoUrl: newProfilePic,
    });
  }
}
