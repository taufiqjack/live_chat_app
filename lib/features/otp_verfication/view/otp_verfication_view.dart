import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:live_chat_app/constants/asset_path.dart';
import 'package:live_chat_app/constants/color_constant.dart';
import 'package:live_chat_app/constants/number_constant.dart';
import 'package:live_chat_app/features/otp_verfication/controller/otp_verfication_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerficationView extends StatefulWidget {
  final String phoneNumber;
  const OtpVerficationView({
    super.key,
    required this.phoneNumber,
  });

  Widget build(BuildContext context, OtpVerificationController controller) {
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
                        Text(
                            '+62 ${int.parse(phoneNumber).phoneFormat().toString().replaceAll('.', '-')}'),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: PinCodeTextField(
                            controller: controller.otpField,
                            appContext: context,
                            length: 4,
                            pinTheme: PinTheme(
                                inactiveColor: grey, errorBorderColor: red),
                            onCompleted: (value) => controller.otpAlert(value),
                          ),
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
  State<StatefulWidget> createState() => OtpVerificationController();
}
