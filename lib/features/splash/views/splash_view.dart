import 'package:flutter/material.dart';
import 'package:live_chat_app/features/splash/controllers/splash_controller.dart';
import 'package:live_chat_app/routes/route.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  Widget build(BuildContext context, SplashController controller) {
    return Material(
      child: Container(
        color: Colors.white54,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/mutiara_cosmetics.png',
              height: Go.height / 3,
            ),
          ],
        )),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => SplashController();
}
