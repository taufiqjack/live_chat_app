import 'package:flutter/material.dart';
import 'package:live_chat_app/features/dashboard/view/dashboard_view.dart';
import 'package:live_chat_app/features/scanner/scanner_view/scanner_view.dart';
import 'package:live_chat_app/routes/route.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:toast/toast.dart';

class ScannerController extends State<ScannerView> {
  MobileScannerController scanController = MobileScannerController(
      formats: [BarcodeFormat.code128],
      detectionSpeed: DetectionSpeed.noDuplicates);
  String? result;

  @override
  void initState() {
    super.initState();
    ToastContext().init(context);
  }

  @override
  void dispose() {
    super.dispose();
    scanController.dispose();
  }

  void barcode(BarcodeCapture capture) {
    final barcode = capture.barcodes.first;
    result = barcode.rawValue.toString();
    setState(() {});
    alertDialog();
  }

  alertDialog() {
    result == null
        ? null
        : Future.delayed(
            const Duration(milliseconds: 1000),
            () => Alert(
                type: AlertType.success,
                context: context,
                desc: 'Kode Barang : \n$result',
                buttons: [
                  DialogButton(
                      child: const Text(
                        'OK',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Go.to(const DashboardView());
                        scanController.dispose();
                      })
                ]).show(),
          );
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
