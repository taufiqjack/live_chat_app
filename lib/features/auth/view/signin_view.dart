import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:live_chat_app/constants/color_constant.dart';
import 'package:live_chat_app/features/auth/controller/signin_controller.dart';
import 'package:live_chat_app/features/sign_in_with_phone/view/sign_in_with_phone_number_view.dart';
import 'package:live_chat_app/features/widgets/common_modal_progress.dart';
import 'package:live_chat_app/routes/route.dart';

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
                  child: Column(children: [
                const Align(
                  heightFactor: 2,
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Username/Email',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: controller.email,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: greyLight,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: greyLight),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: greyLight),
                          borderRadius: BorderRadius.circular(5)),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: greyLight),
                          borderRadius: BorderRadius.circular(5))),
                ),
                const SizedBox(height: 15),
                const Align(
                  heightFactor: 2,
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Password',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller.password,
                  obscureText: true,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: greyLight,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: greyLight),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: greyLight),
                          borderRadius: BorderRadius.circular(5)),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: white),
                          borderRadius: BorderRadius.circular(5))),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Flexible(
                      child: CheckboxListTile(
                        contentPadding: const EdgeInsets.only(left: 0),
                        value: controller.isCheck,
                        onChanged: (value) => controller.remember(value),
                        title: const Text('Remember Me'),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    InkWell(
                      onTap: () => Go.to(const SignInWithPhoneNumberView()),
                      child: const Text(
                        'Login with Phone Number',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () => controller.signInAdmin(),
                  style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 3, 150, 172),
                      fixedSize:
                          Size(MediaQuery.of(context).size.width / 1.7, 40)),
                  child: const Text(
                    'Sign In as Admin',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text('Or'),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () => controller.signInMember(),
                        child: SvgPicture.asset('assets/svg/google_icon.svg',
                            height: 40),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: SvgPicture.asset(
                          'assets/svg/facebook_icon.svg',
                          height: 40,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: SvgPicture.asset(
                          'assets/svg/apple_icon.svg',
                          height: 40,
                        ),
                      ),
                    ])
              ])),
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => SignInController();
}
