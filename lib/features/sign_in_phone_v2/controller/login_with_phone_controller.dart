import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_chat_app/features/otp_verfication/view/otp_verfication_view.dart';
import 'package:live_chat_app/features/sign_in_phone_v2/view/login_with_phone_view.dart';
import 'package:live_chat_app/routes/route.dart';
import 'package:toast/toast.dart';

class LoginWithPhoneController extends State<LoginWithPhoneView> {
  final phoneNumberField = TextEditingController();
  @override
  void initState() {
    super.initState();
    ToastContext().init(context);
  }

  void sendOtp() {
    if (phoneNumberField.text.isNotEmpty) {
      Go.to(
        OtpVerficationView(phoneNumber: phoneNumberField.text),
      );
    } else {
      Toast.show("form can't be empty", duration: Toast.lengthLong);
    }
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
