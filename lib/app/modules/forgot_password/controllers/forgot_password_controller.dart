import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordController extends GetxController {
  var obsecure1 = true.obs;
  var obsecure2 = true.obs;
  final TextEditingController emailController = TextEditingController();

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void sendResetEmail() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      Get.snackbar(
        "Success",
        "Password reset email sent!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        e.message ?? "An error occurred",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
