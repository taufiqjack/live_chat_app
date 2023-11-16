import 'package:flutter/material.dart';
import 'package:live_chat_app/features/auth/view/signin_view.dart';
import 'package:live_chat_app/features/dashboard/view/dashboard_view.dart';
import 'package:live_chat_app/features/splash/views/splash_view.dart';
import 'package:live_chat_app/routes/route.dart';

class SplashController extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () => Go.to(const SignInView()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
