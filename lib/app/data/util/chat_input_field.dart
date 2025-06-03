import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vehicle_booking/app/data/app_colors.dart';

class ChatInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const ChatInputField({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      color: AppColors.lighGreen,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: "Ask anything about your note",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          GestureDetector(
            onTap: onSend,
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
              child: Icon(Icons.send, color: AppColors.green, size: 20.sp),
            ),
          ),
        ],
      ),
    );
  }
}
