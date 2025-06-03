import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';

class VehicleDetailController extends GetxController {
  Future<void> callNumber(String rawNumber) async {
    final cleaned = rawNumber.replaceAll(RegExp(r'[^0-9+]'), '');

    // Request permission
    if (await Permission.phone.request().isGranted) {
      final called = await FlutterPhoneDirectCaller.callNumber(cleaned);
      if (!called!) {
        Get.snackbar('Error', 'Call failed to start.');
      }
    } else {
      Get.snackbar('Permission', 'Phone call permission denied.');
    }
  }
}
