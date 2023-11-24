import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:live_chat_app/core/services/auth_service.dart';
import 'package:live_chat_app/features/auth/view/signin_view.dart';
import 'package:live_chat_app/features/dashboard/view/dashboard_view.dart';
import 'package:live_chat_app/routes/route.dart';
import 'package:toast/toast.dart';

class SignInController extends State<SignInView> {
  var email = TextEditingController();
  var password = TextEditingController();
  bool isAsync = false;
  var googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  @override
  void initState() {
    ToastContext().init(context);
    super.initState();
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
    if (email.text.isEmpty && password.text.isEmpty) {
      Toast.show("Form can't be empty",
          gravity: Toast.bottom, duration: Toast.lengthLong);
    } else {
      isAsync = true;
      setState(() {});
      var success = await AuthService.loginAsAdmin(email.text, password.text);
      if (success == true) {
        Future.delayed(const Duration(milliseconds: 500),
            () => Go.to(const DashboardView()));
      } else {
        isAsync = false;
        setState(() {});
        Toast.show('Wrong Email or Password for that User',
            gravity: Toast.bottom, duration: Toast.lengthLong);
      }
    }
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
