import 'package:flutter/material.dart';
import 'package:live_chat_app/features/sign_in_with_phone/view/phone_number_verification_view.dart';

class PhoneNumberVerificationController
    extends State<PhoneNumberVerificationView> {
  final otpField = TextEditingController();
  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
