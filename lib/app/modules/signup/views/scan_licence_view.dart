import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:vehicle_booking/app/data/util/custom_appbar.dart';
import 'package:vehicle_booking/app/modules/signup/controllers/signup_controller.dart';
import 'package:vehicle_booking/app/modules/signup/views/signup_view.dart';
import 'package:vehicle_booking/gen/assets.gen.dart';

class ScanLicenceView extends StatefulWidget {
  ScanLicenceView({super.key});

  @override
  State<ScanLicenceView> createState() => _ScanLicenceViewState();
}

class _ScanLicenceViewState extends State<ScanLicenceView> {
  final SignupController controller = Get.put(SignupController());
  final MobileScannerController scannerController = MobileScannerController();
  bool isScanned = false;
  bool showScanner = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        showScanner = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Scan License QR'),
      body: Center(
        child: showScanner
            ? MobileScanner(
                controller: scannerController,
                onDetect: (BarcodeCapture capture) {
                  if (isScanned) return;

                  final barcode = capture.barcodes.first;
                  final rawData = barcode.rawValue;
                  log('QR Code Scanned: $rawData');

                  if (rawData != null && rawData.contains(';')) {
                    final parts = rawData.split(';');
                    if (parts.length >= 3) {
                      isScanned = true;

                      controller.cnicNumberController.text = parts[0];
                      controller.nameController.text = parts[1];
                      controller.licenseNumberController.text = parts[2];

                      scannerController.stop();
                      Get.off(() => SignupView());
                    }
                  }
                },
              )
            : Lottie.asset(Assets.animations.qrScannerLottie),
      ),
    );
  }
}
