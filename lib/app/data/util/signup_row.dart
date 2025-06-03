import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vehicle_booking/app/modules/signup/views/signin_view.dart';

import '../../modules/signup/views/signup_choice.dart';
import '../app_colors.dart';

class SignUpRowWidget extends StatelessWidget {
  const SignUpRowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Do not have an account? ',
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        InkWell(
          onTap: () => Get.to(() => SignupChoiceView()),
          child: Text(
            'Sign Up ',
            style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.green),
          ),
        ),
      ],
    );
  }
}

class SignInRowWidget extends StatelessWidget {
  const SignInRowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        InkWell(
          onTap: () => Get.to(() => SignInView()),
          child: Text(
            'Sign In ',
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.green),
          ),
        ),
      ],
    );
  }
}
