import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vehicle_booking/app/data/util/signup_row.dart';
import 'package:vehicle_booking/app/modules/signup/controllers/signup_controller.dart';
import 'package:vehicle_booking/app/modules/signup/views/scan_licence_view.dart';
import 'package:vehicle_booking/app/modules/signup/views/signup_view.dart';

import '../../../../gen/assets.gen.dart';
import '../../../data/app_colors.dart';

// ignore: must_be_immutable
class SignupChoiceView extends StatelessWidget {
  SignupChoiceView({super.key});
  final controller = Get.put(SignupController());
  int selectedValue = 2;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(
                height: 70.h,
                width: double.infinity,
              ),
              Image.asset(
                Assets.image.logo.path,
                width: 100.w,
                height: 100.h,
              ),
              SizedBox(
                height: 50.h,
              ),
              Text(
                'Please select a role',
                style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.green),
              ),
              SizedBox(
                height: 50.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20.w,
                    height: 20.h,
                    child: Radio(
                      value: 1,
                      groupValue: controller.selectedValue.value,
                      onChanged: controller.onChanged,
                      activeColor: AppColors.green,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  InkWell(
                    onTap: () {
                      controller.selectedValue.value = 1;
                      controller.onChanged(1);
                    },
                    child: Text(
                      'Register as a driver',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  SizedBox(
                    width: 20.w,
                    height: 20.h,
                    child: Radio(
                      value: 2,
                      groupValue: controller.selectedValue.value,
                      onChanged: controller.onChanged,
                      activeColor: AppColors.green,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  InkWell(
                    onTap: () {
                      controller.selectedValue.value = 2;
                      controller.onChanged(2);
                    },
                    child: Text(
                      'Register as a customer',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              SignInRowWidget(),
              SizedBox(
                height: 5.h,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 45.h,
                  child: ElevatedButton(
                      onPressed: () {
                        controller.selectedValue.value == 2
                            ? Get.to(() => SignupView())
                            : Get.to(() => ScanLicenceView());
                      },
                      child: Text(
                        'Next',
                        style: TextStyle(color: AppColors.white),
                      )))
            ],
          ),
        ),
      ),
    ));
  }
}
