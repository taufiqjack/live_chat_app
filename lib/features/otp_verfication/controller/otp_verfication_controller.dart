import 'package:flutter/material.dart';
import 'package:live_chat_app/features/otp_verfication/view/otp_verfication_view.dart';
import 'package:live_chat_app/routes/route.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class OtpVerificationController extends State<OtpVerficationView> {
  final otpField = TextEditingController();

  void otpAlert(value) {
    otpField.text = value;
    setState(() {});

    otpField.text == '1234'
        ? Alert(context: context, type: AlertType.success, desc: 'Success!')
            .show()
        : Alert(
            context: context,
            type: AlertType.error,
            desc: 'Wrong Code!',
            buttons: [
                DialogButton(
                  child: Text('OK'),
                  onPressed: () {
                    Go.back();
                    otpField.clear();
                  },
                )
              ]).show();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
