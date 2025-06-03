import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vehicle_booking/app/data/app_colors.dart';

class ChatBubbleWidget extends StatelessWidget {
  final String message;
  final bool isUser;

  const ChatBubbleWidget({
    super.key,
    required this.message,
    this.isUser = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        child: Row(
          mainAxisAlignment:
              isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: isUser ? AppColors.lighGreen : Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  message,
                  style: TextStyle(fontSize: 15.sp, color: Colors.black87),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
