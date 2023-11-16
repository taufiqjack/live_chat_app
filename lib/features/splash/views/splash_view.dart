import 'package:flutter/material.dart';
import 'package:live_chat_app/features/splash/controllers/splash_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  Widget build(BuildContext context, SplashController controller) {
    return Material(
      child: Container(
        color: Colors.blue.shade800,
        child: const Center(
          child: Text(
            'Live Chat',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => SplashController();
}
