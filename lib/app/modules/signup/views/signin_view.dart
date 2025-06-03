import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vehicle_booking/app/data/app_colors.dart';
import 'package:vehicle_booking/app/data/util/heading16Green.dart';
import 'package:vehicle_booking/app/modules/forgot_password/views/forgot_password_view.dart';
import 'package:vehicle_booking/app/modules/signup/controllers/signup_controller.dart';
import '../../../../gen/assets.gen.dart';
import '../../../data/util/signup_row.dart';

class SignInView extends StatelessWidget {
  SignInView({super.key});
  final formKey = GlobalKey<FormState>();
  final SignupController controller = Get.put(SignupController());
  @override
  Widget build(BuildContext context) {
    Get.put(SignupController());
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
                    'Sign In ',
                    style: TextStyle(
                        fontSize: 35.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.green),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Heading16Green(text: "Email"),
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
                        return "Enter Email";
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
                  SizedBox(
                    height: 15.h,
                  ),
                  Heading16Green(text: 'Password'),
                  Obx(() {
                    return TextFormField(
                      controller: controller.passwordController,
                      obscureText: controller.obsecure.value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter your password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock,
                            color: Colors.black.withValues(alpha: 0.50)),
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.obsecure.value =
                                !controller.obsecure.value;
                          },
                          icon: controller.obsecure.value
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
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () => Get.to(() => ForgotPasswordView()),
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.green,
                        ),
                      ),
                    ),
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
                              final email =
                                  controller.emailController.text.trim();
                              final password =
                                  controller.passwordController.text.trim();

                              Get.find<SignupController>()
                                  .login(email, password);
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
