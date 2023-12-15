import 'package:flutter/material.dart';
import 'package:live_chat_app/features/sign_in_with_phone/view/phone_number_verification_view.dart';
import 'package:live_chat_app/features/sign_in_with_phone/view/sign_in_with_phone_number_view.dart';
import 'package:live_chat_app/routes/route.dart';
import 'package:toast/toast.dart';

class SignInWithPhoneNumberController extends State<SignInWithPhoneNumberView> {
  final phoneNumber = TextEditingController();
  final ValueNotifier countryCode = ValueNotifier(null);
  final ValueNotifier form = ValueNotifier(bool);
  var listCountryCode = [
    '+62',
  ];
  @override
  void initState() {
    super.initState();
    ToastContext().init(context);
  }

  void sendCodeVerification() {
    if (phoneNumber.text.isEmpty) {
      Toast.show("Telephone number can't be empty", duration: Toast.lengthLong);
    } else {
      Go.to(PhoneNumberVerificationView(
        phoneNumber: phoneNumber.text,
      ));
    }
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
