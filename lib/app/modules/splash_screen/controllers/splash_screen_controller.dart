import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_booking/app/modules/signup/controllers/signup_controller.dart';
import 'package:vehicle_booking/notificaitons_services.dart';

// class SplashScreenController extends GetxController {

// }

class SplashScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  NotificationServices notificationServices = NotificationServices();
  late AnimationController animationController;
  late Animation<double> scaleAnimation;
  late Animation<double> fadeAnimation;

  @override
  void onInit() {
    super.onInit();
    notificationServices.initializeNotifications();
    Future.delayed(Duration(seconds: 2), () {
      Get.find<SignupController>().checkLoginStatus();
    });
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    scaleAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    fadeAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
