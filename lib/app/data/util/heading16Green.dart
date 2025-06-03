import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vehicle_booking/app/data/app_colors.dart';

class Heading16Green extends StatelessWidget {
  const Heading16Green({
    super.key,
    required this.text,
    this.size = 20,
  });
  final String text;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
            fontSize: size?.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.green),
      ),
    );
  }
}
