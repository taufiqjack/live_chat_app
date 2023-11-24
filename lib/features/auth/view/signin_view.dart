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
                    TextFormField(
                      controller: controller.email,
                      decoration: InputDecoration(
                          label: const Text('Email'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: controller.password,
                      obscureText: true,
                      decoration: InputDecoration(
                          label: const Text('Password'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () => controller.signInAdmin(),
                      style: TextButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 3, 150, 172),
                          fixedSize: Size(
                              MediaQuery.of(context).size.width / 1.7, 40)),
                      child: const Text(
                        'Sign In as Admin',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text('Or'),
                    ),
                    TextButton(
                      onPressed: () => controller.signInMember(),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          fixedSize: Size(
                              MediaQuery.of(context).size.width / 1.7, 40)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset('assets/svg/google_icon.svg'),
                          const Text(
                            'Sign In as Member',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
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
