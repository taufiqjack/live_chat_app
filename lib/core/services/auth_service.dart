import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:live_chat_app/constants/firestore_constants.dart';
import 'package:live_chat_app/core/models/user_model.dart';
import 'package:live_chat_app/hive/hive_storage.dart';
import 'package:toast/toast.dart';
import 'user_service.dart';

class AuthService {
  static User? currentUser;
  static UserModel? userModel;

  static loginAsMember() async {
    var isLoggedIn = await googleSignIn();
    if (isLoggedIn) {
      currentUser = FirebaseAuth.instance.currentUser!;
      loggedBox.put(FirestoreConstants.isAdmin, false);
      await UserService.getUserData();
      await UserService.createUserIfNotExists();
    }
    return isLoggedIn;
  }

  static loginAsAdmin(String email, String password) async {
    var isLoggedIn = await signInEmailPassword(email, password);
    if (isLoggedIn) {
      currentUser = FirebaseAuth.instance.currentUser!;
      loggedBox.put(FirestoreConstants.isAdmin, true);
      await UserService.createUserAdmin();
      await UserService.getAdmin();
    }
    return isLoggedIn;
  }

  static logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<bool> signInEmailPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print('No user found for that email.');
        }
        Toast.show('No user found for that email.',
            gravity: Toast.bottom, duration: Toast.lengthLong);
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Wrong password provided for that user.');
        }
        Toast.show('Wrong password provided for that user.',
            gravity: Toast.bottom, duration: Toast.lengthLong);
      }
      return false;
    }
  }

  static Future<bool> googleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );

    try {
      await googleSignIn.disconnect();
    } catch (_) {}

    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      return Future.value(true);
    } catch (_) {
      return Future.value(false);
    }
  }
}
