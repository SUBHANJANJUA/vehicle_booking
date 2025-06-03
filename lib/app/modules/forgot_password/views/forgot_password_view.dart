import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vehicle_booking/app/data/util/heading16Green.dart';
import 'package:vehicle_booking/app/data/util/signup_row.dart';
import 'package:vehicle_booking/app/modules/signup/views/signin_view.dart';
import 'package:vehicle_booking/gen/assets.gen.dart';
import '../../../data/app_colors.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  ForgotPasswordView({super.key});
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Get.put(ForgotPasswordController());
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.white,
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 50.h,
                    width: double.infinity,
                  ),
                  Image.asset(
                    Assets.image.logo.path,
                    width: 100.w,
                    height: 100.h,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Forgot Password',
                    style: TextStyle(
                        fontSize: 35.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.green),
                  ),
                  SizedBox(
                    height: 70.h,
                  ),
                  Heading16Green(text: 'Email'),
                  TextFormField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.black.withValues(alpha: 0.50),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter Email";
                      }
                      // Email validation pattern
                      final emailRegex = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                      if (!emailRegex.hasMatch(value)) {
                        return "Enter a valid email address";
                      }
                      return null;
                    },
                  ),
                  Spacer(),
                  SignUpRowWidget(),
                  SizedBox(
                    height: 5.h,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 45.h,
                      child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              controller.sendResetEmail();
                              Get.offAll(SignInView());
                            }
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(color: AppColors.white),
                          )))
                ],
              ),
            ),
          )),
    );
  }
}
