import 'package:flutter/material.dart';

class CommonSnackbar {
  final String content;
  final BuildContext context;

  CommonSnackbar(this.context, {required this.content}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }
}
