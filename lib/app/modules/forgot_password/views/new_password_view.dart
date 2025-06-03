import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:vehicle_booking/app/modules/forgot_password/controllers/forgot_password_controller.dart';
import 'package:vehicle_booking/app/modules/signup/views/signin_view.dart';
import '../../../../gen/assets.gen.dart';
import '../../../data/app_colors.dart';
import '../../../data/util/signup_row.dart';

class NewPasswordView extends StatelessWidget {
  NewPasswordView({super.key});
  final controller = Get.put(ForgotPasswordController());
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.white,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 150.h,
                    width: double.infinity,
                  ),
                  Image.asset(
                    Assets.image.logo.path,
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(
                    height: 70.h,
                  ),
                  Text(
                    'Enter New Password',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: AppColors.green),
                  ),
                  SizedBox(
                    height: 70.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'New Password',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.green),
                    ),
                  ),
                  Obx(() {
                    return TextFormField(
                      controller: controller.newPasswordController,
                      obscureText: controller.obsecure1.value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter your password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'New Password',
                        prefixIcon: Icon(Icons.lock,
                            color: Colors.black.withValues(alpha: 0.50)),
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.obsecure1.value =
                                !controller.obsecure1.value;
                          },
                          icon: controller.obsecure1.value
                              ? Icon(Icons.remove_red_eye_outlined,
                                  color: Colors.black.withValues(alpha: 0.50))
                              : Icon(Icons.remove_red_eye,
                                  color: Colors.black.withValues(alpha: 0.50)),
                        ),
                      ),
                    );
                  }),
                  SizedBox(
                    height: 15.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Confirm Password',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.green),
                    ),
                  ),
                  Obx(() {
                    return TextFormField(
                      controller: controller.confirmPasswordController,
                      obscureText: controller.obsecure2.value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter same password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        prefixIcon: Icon(Icons.lock,
                            color: Colors.black.withValues(alpha: 0.50)),
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.obsecure2.value =
                                !controller.obsecure2.value;
                          },
                          icon: controller.obsecure2.value
                              ? Icon(Icons.remove_red_eye_outlined,
                                  color: Colors.black.withValues(alpha: 0.50))
                              : Icon(Icons.remove_red_eye,
                                  color: Colors.black.withValues(alpha: 0.50)),
                        ),
                      ),
                    );
                  }),
                  SizedBox(
                    height: 15.h,
                  ),
                  Spacer(),
                  SignUpRowWidget(),
                  SizedBox(
                    height: 30.h,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              Get.offAll(() => SignInView());
                            }
                          },
                          child: Text(
                            'Reset Password',
                            style: TextStyle(color: AppColors.white),
                          )))
                ],
              ),
            ),
          )),
    );
  }
}
