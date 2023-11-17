import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:live_chat_app/features/auth/controller/signin_controller.dart';
import 'package:live_chat_app/features/widgets/common_modal_progress.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  Widget build(BuildContext context, SignInController controller) {
    return ModalProgress(
      inAsyncCall: controller.isAsync,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white24,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: WillPopScope(
          onWillPop: () => controller.willPop(),
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () => controller.signIn(),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          fixedSize: Size(
                              MediaQuery.of(context).size.width / 1.7, 40)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset('assets/svg/google_icon.svg'),
                          const Text(
                            'Sign In with Google',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => SignInController();
}
