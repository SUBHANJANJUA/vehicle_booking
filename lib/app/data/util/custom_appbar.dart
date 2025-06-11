import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vehicle_booking/app/data/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? chatOntap;
  final Widget? actionWidget;

  const CustomAppBar(
      {super.key, required this.title, this.chatOntap, this.actionWidget});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.green,
          ),
        ),
        actions: [
          Row(
            children: [
              actionWidget ?? SizedBox.shrink(),
              chatOntap == null
                  ? SizedBox.shrink()
                  : Padding(
                      padding: EdgeInsets.only(right: 15.w),
                      child: InkWell(
                        onTap: chatOntap,
                        child: Icon(
                          Icons.message_outlined,
                          color: AppColors.green,
                        ),
                      ),
                    ),
            ],
          )
        ],
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.keyboard_arrow_left,
            color: AppColors.green,
            size: 35.sp,
          ),
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
