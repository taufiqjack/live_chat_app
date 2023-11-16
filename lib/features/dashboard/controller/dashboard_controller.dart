import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:live_chat_app/core/services/auth_service.dart';
import 'package:live_chat_app/features/auth/view/signin_view.dart';
import 'package:live_chat_app/features/dashboard/view/dashboard_view.dart';
import 'package:live_chat_app/routes/route.dart';

class DashboardController extends State<DashboardView> {
  bool isAsync = false;
  @override
  void initState() {
    super.initState();
  }

  logout() async {
    isAsync = true;
    setState(() {});
    await AuthService.doLogout();
    Future.delayed(
        const Duration(milliseconds: 500), () => Go.to(const SignInView()));
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
