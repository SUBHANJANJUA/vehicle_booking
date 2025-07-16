import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vehicle_booking/app/data/models/user_model.dart';
import 'package:vehicle_booking/app/modules/home/views/home_view.dart';
import 'package:vehicle_booking/app/modules/signup/views/signin_view.dart';

class SignupController extends GetxController {
  RxBool driver = false.obs;
  var selectedValue = 2.obs;
  var vehicletype = 1.obs;
  var ac = 1.obs;
  var obsecure = true.obs;

  void onChanged(int? value) {
    if (value != null) {
      selectedValue.value = value;
    }
  }

  void onVehicleChange(int? value) {
    if (value != null) {
      vehicletype.value = value;
    }
  }

  void onAC(int? value) {
    if (value != null) {
      ac.value = value;
    }
  }

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final licenseNumberController = TextEditingController();
  final cnicNumberController = TextEditingController();
  final licenseExpDateController = TextEditingController();
  final licenseTypeController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final userModel = Rxn<UserModel>();

  Future<void> saveUserToken(String uid) async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'fcmToken': token,
      });
    }
  }

  // Sign up
  Future<void> register(String email, String password, String userType) async {
    try {
      EasyLoading.show(status: 'Sign up ...');
      final userCred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCred.user!.uid;

      final userData = UserModel(
        uid: uid,
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        userType: userType,
        licenseNumber: licenseNumberController.text,
        licenseExpDate: licenseExpDateController.text,
        licenseType: licenseTypeController.text,
        cnic: cnicNumberController.text,
      );

      await _firestore.collection('users').doc(uid).set(userData.toJson());

      userModel.value = userData;

      EasyLoading.showSuccess('Signup Successful!');
      _navigateToHome(userType);

      await saveUserToken(uid);
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar('Error', e.toString());
    }
  }

  // Login
  Future<void> login(String email, String password) async {
    try {
      EasyLoading.show(status: 'Sign In ...');
      final userCred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final doc =
          await _firestore.collection('users').doc(userCred.user!.uid).get();

      final userType = doc['userType'];

      // ✅ Load full profile data before navigating
      await loadUserProfile();
      // await homecontroller.loadTrukList();
      EasyLoading.showSuccess('Signin Successful!');
      _navigateToHome(userType);
      await saveUserToken(userCred.user!.uid);
      EasyLoading.dismiss();
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
      EasyLoading.dismiss();
    }
  }

  void _navigateToHome(String userType) {
    log('tap after navigation');
    if (userType == 'customer') {
      driver.value = false;
      Get.offAll(HomeView());
    } else if (userType == 'driver') {
      driver.value = true;
      Get.offAll(HomeView());
    }
  }

  // Optional: Auto login logic

  Future<void> checkLoginStatus() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      final userType = doc['userType'];
      _navigateToHome(userType);
    } else {
      Get.offAll(() => SignInView());
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(() => SignInView());
  }

  Future<void> loadUserProfile() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      userModel.value = UserModel.fromJson(doc.data()!);
    }
  }
}
