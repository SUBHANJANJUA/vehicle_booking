import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vehicle_booking/app/data/app_colors.dart';

class HeadingBlack extends StatelessWidget {
  const HeadingBlack({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class TextGry extends StatelessWidget {
  const TextGry({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text,
      style: TextStyle(
        fontSize: 14.sp,
        // fontWeight: FontWeight.w600,
        color: AppColors.grey,
      ),
    );
  }
}
