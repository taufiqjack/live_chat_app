// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:live_chat_app/constants/firestore_constants.dart';
import 'package:live_chat_app/core/services/auth_service.dart';
import 'package:live_chat_app/core/services/internet_connection.dart';
import 'package:live_chat_app/features/auth/view/signin_view.dart';
import 'package:live_chat_app/features/dashboard/view/dashboard_view.dart';
import 'package:live_chat_app/features/widgets/common_snackbar.dart';
import 'package:live_chat_app/hive/hive_storage.dart';
import 'package:live_chat_app/routes/route.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:toast/toast.dart';

class SignInController extends State<SignInView> {
  var email = TextEditingController();
  var password = TextEditingController();
  bool isAsync = false;
  bool isCheck = false;
  var googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  @override
  void initState() {
    ToastContext().init(context);
    super.initState();
    getEmailPass();
  }

  void remember(value) {
    if (email.text.isEmpty || password.text.isEmpty) {
      Toast.show("Form can't be empty",
          gravity: Toast.bottom, duration: Toast.lengthLong);
    } else {
      isCheck = value;
      setState(() {});
      if (value == false) {
        isCheck = false;
        setState(() {});
        checkBox.put(FirestoreConstants.ISCHECK, isCheck);
        emailPassBox.clear();
      } else {
        isCheck = true;
        setState(() {});
        rememberEmailPass();
      }
    }
  }

  void rememberEmailPass() {
    emailPassBox.put(FirestoreConstants.EMAIL, email.text);
    emailPassBox.put(FirestoreConstants.PASS, password.text);
    checkBox.put(FirestoreConstants.ISCHECK, isCheck);
  }

  void getEmailPass() {
    isCheck = checkBox.get(FirestoreConstants.ISCHECK) ?? false;
    email.text = emailPassBox.get(FirestoreConstants.EMAIL) ?? '';
    password.text = emailPassBox.get(FirestoreConstants.PASS) ?? '';
    isCheck = checkBox.get(FirestoreConstants.ISCHECK) ?? false;
  }

  signInMember() async {
    isAsync = true;
    setState(() {});
    var success = await AuthService.loginAsMember();
    if (success == true) {
      Future.delayed(const Duration(milliseconds: 500),
          () => Go.to(const DashboardView()));
    }
  }

  signInAdmin() async {
    if (email.text.isEmpty || password.text.isEmpty) {
      Toast.show("Form can't be empty",
          gravity: Toast.bottom, duration: Toast.lengthLong);
    } else {
      await InternetConnection.isInternet().then((connection) async {
        if (connection) {
          isAsync = true;
          setState(() {});
          var success =
              await AuthService.loginAsAdmin(email.text, password.text);
          if (success == true) {
            Future.delayed(const Duration(milliseconds: 500),
                () => Go.to(const DashboardView()));
          } else {
            isAsync = false;
            setState(() {});
            Alert(
                context: context,
                type: AlertType.error,
                desc: 'Wrong Email or Password\nfor that User',
                style: AlertStyle(
                    descStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.red.withOpacity(0.7))),
                buttons: [
                  DialogButton(
                    color: Colors.grey.shade500,
                    child: const Text(
                      'OK',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Go.back();
                    },
                  )
                ]).show();
          }
        } else {
          CommonSnackbar(context, content: 'No Internet Connection');
        }
      });
    }
  }

  Future<bool> willPop() async {
    isAsync = false;
    setState(() {});
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
                    'OK',
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
