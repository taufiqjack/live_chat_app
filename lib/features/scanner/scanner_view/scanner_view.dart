import 'package:flutter/material.dart';
import 'package:live_chat_app/features/scanner/scanner_controller/scanner_controller.dart';
import 'package:live_chat_app/routes/route.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerView extends StatefulWidget {
  const ScannerView({super.key});

  Widget build(BuildContext context, ScannerController controller) {
    return Scaffold(
        body: Stack(
      children: [
        MobileScanner(
          controller: controller.scanController,
          onDetect: (capture) {
            controller.barcode(capture);
          },
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 50,
                bottom: 10,
                left: 10,
              ),
              child: InkWell(
                onTap: () {
                  Go.back();
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }

  @override
  State<StatefulWidget> createState() => ScannerController();
}
