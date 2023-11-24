import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:live_chat_app/constants/firestore_constants.dart';
import 'package:live_chat_app/core/services/auth_service.dart';
import 'package:live_chat_app/core/services/dashboard_service.dart';
import 'package:live_chat_app/features/auth/view/signin_view.dart';
import 'package:live_chat_app/features/dashboard/view/dashboard_view.dart';
import 'package:live_chat_app/hive/hive_storage.dart';
import 'package:live_chat_app/routes/route.dart';
import 'package:toast/toast.dart';

class DashboardController extends State<DashboardView> {
  bool isAsync = false;
  int limit = 20;
  String textSearch = '';
  String? currentUserId;
  @override
  void initState() {
    super.initState();
    getToken();
  }

  void getToken() {
    if (FirebaseAuth.instance.currentUser != null) {
      currentUserId = FirebaseAuth.instance.currentUser?.uid;
      FirebaseMessaging.instance.requestPermission();

      FirebaseMessaging.instance.getToken().then((token) {
        if (kDebugMode) {
          print('token : $token');
        }
        if (token != null) {
          DashboardService.updateDataFirestore(
              FirestoreConstants.pathUserCollection, currentUserId!, {
            'pushToken': token,
            'isAdmin': loggedBox.get(FirestoreConstants.isAdmin)
          });
        }
      }).catchError((err) {
        Toast.show(err.toString());
      });
    }
  }

  logout() async {
    isAsync = true;
    setState(() {});
    await AuthService.doLogout();
    Future.delayed(
            const Duration(milliseconds: 500), () => Go.to(const SignInView()))
        .then((value) => loggedBox.clear());
  }

  Future<bool> willPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Text(
              'Exit',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            content: const Text(
              'Are you sure want to close this app?',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  )),
              TextButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: const Text(
                    'Ok',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ))
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
