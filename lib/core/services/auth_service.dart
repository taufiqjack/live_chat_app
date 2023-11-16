import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:live_chat_app/core/models/user_model.dart';
import 'user_service.dart';

class AuthService {
  static User? currentUser;
  static UserModel? userModel;
  static bool isMember = false;
  static bool isVendor = false;

  static doLoginAsMember() async {
    var isLoggedIn = await doGoogleLogin();
    await UserService.createUserIfNotExists();
    await UserService.getUserData();
    if (isLoggedIn) {
      currentUser = FirebaseAuth.instance.currentUser!;
    }
    return isLoggedIn;
  }

  static doLogout() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<bool> doGoogleLogin() async {
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
      var userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return Future.value(true);
    } catch (_) {
      return Future.value(false);
    }
  }
}
