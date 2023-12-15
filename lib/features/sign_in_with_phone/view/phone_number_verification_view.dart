import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:live_chat_app/constants/color_constant.dart';
import 'package:live_chat_app/constants/number_constant.dart';
import 'package:live_chat_app/features/sign_in_with_phone/controller/phone_number_verfication_controller.dart';
import 'package:live_chat_app/routes/route.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PhoneNumberVerificationView extends StatefulWidget {
  final String phoneNumber;
  const PhoneNumberVerificationView({super.key, required this.phoneNumber});

  Widget build(
      BuildContext context, PhoneNumberVerificationController controller) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () => Go.back(),
          child: const Icon(
            Icons.arrow_back_ios,
            color: black,
          ),
        ),
        backgroundColor: white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Verifikasi',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const Text('Silahkan masukkan kode yang telah dikirim ke'),
              Text(
                  '+62 ${int.parse(phoneNumber).phoneFormat().replaceAll('.', '-')}'),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: PinCodeTextField(
                  controller: controller.otpField,
                  appContext: context,
                  length: 4,
                  pinTheme:
                      PinTheme(inactiveColor: grey, errorBorderColor: red),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                  alignment: Alignment.center,
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'Tidak menerima kode?',
                        style: TextStyle(
                          fontFamily: GoogleFonts.montserrat().fontFamily,
                          color: black,
                        )),
                    WidgetSpan(
                        child: InkWell(
                            onTap: () {},
                            child: RichText(
                                text: TextSpan(
                                    text: ' Kirim ulang',
                                    style: TextStyle(
                                        fontFamily:
                                            GoogleFonts.montserrat().fontFamily,
                                        color: red)))))
                  ]))),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      backgroundColor: red,
                      elevation: 0,
                      fixedSize: Size(MediaQuery.of(context).size.width, 45)),
                  child: const Text(
                    'Kirim Kode',
                    style: TextStyle(color: white, fontWeight: FontWeight.w700),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => PhoneNumberVerificationController();
}
