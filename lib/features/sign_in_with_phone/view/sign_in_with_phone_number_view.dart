import 'package:flutter/material.dart';
import 'package:live_chat_app/constants/color_constant.dart';
import 'package:live_chat_app/features/sign_in_with_phone/controller/sign_in_with_phone_number.controller.dart';
import 'package:live_chat_app/features/sign_in_with_phone/view/phone_number_verification_view.dart';
import 'package:live_chat_app/routes/route.dart';

class SignInWithPhoneNumberView extends StatefulWidget {
  const SignInWithPhoneNumberView({super.key});

  Widget build(
      BuildContext context, SignInWithPhoneNumberController controller) {
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
                'Masuk',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const Text('Silahkan masukkan Nomor Telp. Anda'),
              const SizedBox(height: 20),
              Container(
                height: 52,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: grey, width: 2)),
                child: TextFormField(
                  maxLength: 12,
                  controller: controller.phoneNumber,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(color: black),
                  decoration: InputDecoration(
                    counterText: '',
                    prefixIcon: ValueListenableBuilder(
                      valueListenable: controller.countryCode,
                      builder: (BuildContext context, dynamic value,
                              Widget? child) =>
                          Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  right: BorderSide(width: 2, color: grey))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: const Text('+62'),
                              value: controller.countryCode.value,
                              items: controller.listCountryCode
                                  .map((e) => DropdownMenuItem(
                                      value: e, child: Text(e)))
                                  .toList(),
                              onChanged: (value) {
                                controller.countryCode.value = value;
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: controller.phoneNumber.text.isEmpty
                      ? null
                      : () => controller.sendCodeVerification(),
                  style: TextButton.styleFrom(
                      backgroundColor:
                          controller.phoneNumber.text.isEmpty ? greyLight : red,
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
  State<StatefulWidget> createState() => SignInWithPhoneNumberController();
}
