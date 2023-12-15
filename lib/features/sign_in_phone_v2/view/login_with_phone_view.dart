import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:live_chat_app/constants/asset_path.dart';
import 'package:live_chat_app/constants/color_constant.dart';
import 'package:live_chat_app/features/auth/view/login_view.dart';
import 'package:live_chat_app/features/otp_verfication/view/otp_verfication_view.dart';
import 'package:live_chat_app/features/sign_in_phone_v2/controller/login_with_phone_controller.dart';
import 'package:live_chat_app/routes/route.dart';

class LoginWithPhoneView extends StatefulWidget {
  const LoginWithPhoneView({super.key});

  Widget build(BuildContext context, LoginWithPhoneController controller) {
    return Scaffold(
      backgroundColor: white,
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 0),
        child: Stack(
          children: [
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Align(
                    heightFactor: 1.4,
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset(AssetPath.svg('login_vector')),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    height: MediaQuery.of(context).size.height / 2.1,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.fromBorderSide(
                          BorderSide(color: black.withOpacity(0.2), width: 2),
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        )),
                    child: Column(
                      children: [
                        const Text('Masuk'),
                        const SizedBox(height: 10),
                        const Align(
                          heightFactor: 1.5,
                          alignment: Alignment.topLeft,
                          child: Text('Login with phone number'),
                        ),
                        TextFormField(
                          controller: controller.phoneNumberField,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              prefix: const Text('+62'),
                              hintText: 'Masukkan nomor telepon',
                              border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: greyLight),
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                            onPressed: () => controller.sendOtp(),
                            style: TextButton.styleFrom(
                                backgroundColor: blueTosca,
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width, 45)),
                            child: const Text(
                              'Kirim OTP',
                              style: TextStyle(color: white),
                            )),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () => Go.to(const LoginView()),
                          child: const Text('Login with username/email'),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            )
          ],
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => LoginWithPhoneController();
}
