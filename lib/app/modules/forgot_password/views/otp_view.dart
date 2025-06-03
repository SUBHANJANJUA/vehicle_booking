import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import 'package:vehicle_booking/app/modules/forgot_password/views/new_password_view.dart';
import 'package:vehicle_booking/gen/assets.gen.dart';
import '../../../data/app_colors.dart';
import '../../../data/util/signup_row.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  var showPin = false.obs;
  final defaultPinTheme = PinTheme(
    width: 60,
    height: 78,
    textStyle: TextStyle(
        fontSize: 25, color: AppColors.green, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.green, width: 1.5),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  final disablePinTheme = PinTheme(
    width: 60,
    height: 78,
    textStyle: TextStyle(
        fontSize: 25, color: AppColors.green, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  final errorPinTheme = PinTheme(
    width: 60,
    height: 78,
    textStyle: const TextStyle(
        fontSize: 25, color: Colors.red, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.red, width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.white,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
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
                  'OTP Verification',
                  style: TextStyle(
                      fontSize: 35.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.green),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Text(
                    textAlign: TextAlign.center,
                    'Please Enter the 6 digit verification code sent on user@domain.com',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.green),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Pinput(
                  defaultPinTheme: disablePinTheme,
                  submittedPinTheme: defaultPinTheme,
                  errorPinTheme: errorPinTheme,
                  focusedPinTheme: defaultPinTheme,
                  length: 5,
                  onChanged: (pin) {
                    if (pin.length == 5) {
                      showPin.value = true;
                    } else {
                      showPin.value = false;
                    }
                  },
                  onCompleted: (pin) {
                    showPin.value = true;
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
                          showPin.value
                              ? Get.to(() => NewPasswordView())
                              : null;
                        },
                        child: Text(
                          'Next',
                          style: TextStyle(color: AppColors.white),
                        )))
              ],
            ),
          )),
    );
  }
}
