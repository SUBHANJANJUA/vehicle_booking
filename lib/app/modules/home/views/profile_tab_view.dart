import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vehicle_booking/app/data/app_colors.dart';
import 'package:vehicle_booking/app/modules/home/controllers/home_controller.dart';
import 'package:vehicle_booking/app/modules/home/views/privacy_policy_view.dart';
import 'package:vehicle_booking/app/modules/signup/controllers/signup_controller.dart';
import 'package:vehicle_booking/app/modules/vehicle_detail/views/your_vehicle_view.dart';
import 'package:vehicle_booking/gen/assets.gen.dart';

class ProfileTabView extends StatelessWidget {
  ProfileTabView({super.key});
  final SignupController signupcontroller = Get.put(SignupController());
  final ProfileController profilecontroller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final user = signupcontroller.userModel.value;
    return Obx(
      () => Column(children: [
        SizedBox(
          height: 280.h,
          width: double.infinity,
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Image.asset(
                Assets.image.profileBg.path,
                width: double.infinity,
                height: 220.h,
                fit: BoxFit.fitWidth,
              ),
              Positioned(
                bottom: 20.h,
                left: 140.w,
                child: Container(
                  width: 100.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    shape: BoxShape.circle,
                  ),
                  child: profilecontroller.pickedImage.value != null
                      ? ClipOval(
                          child: Image.file(
                            profilecontroller.pickedImage.value!,
                            fit: BoxFit.cover,
                            width: 100.w,
                            height: 100.h,
                          ),
                        )
                      : Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 100.sp,
                        ),
                ),
              ),
              Positioned(
                bottom: 15.h,
                right: 140.w,
                child: InkWell(
                  onTap: profilecontroller.pickImage,
                  child: Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: AppColors.lighGreen,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.photo,
                      color: AppColors.green,
                      size: 20.sp,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.lighGreen,
              borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Obx(
                () => Column(
                  children: [
                    Text(
                      "Profile",
                      style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.green),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: AppColors.green,
                        ),
                        SizedBox(
                          width: 10.h,
                        ),
                        Text(
                          user?.name ?? "",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.email,
                          color: AppColors.green,
                        ),
                        SizedBox(
                          width: 10.h,
                        ),
                        Text(
                          user?.email ?? "",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    signupcontroller.driver.value
                        ? Column(children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.gavel,
                                  color: AppColors.green,
                                ),
                                SizedBox(
                                  width: 10.h,
                                ),
                                Text(
                                  '${user?.licenseNumber} ${user?.licenseType}',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.perm_identity_sharp,
                                  color: AppColors.green,
                                ),
                                SizedBox(
                                  width: 10.h,
                                ),
                                Text(
                                  // ignore: unnecessary_null_comparison
                                  (user!.cnic != null &&
                                          user.cnic.trim().isNotEmpty)
                                      ? user.cnic
                                      : "CNIC",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            InkWell(
                              onTap: () => Get.to(() => YourVehicleView()),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.drive_eta,
                                    color: AppColors.green,
                                  ),
                                  SizedBox(
                                    width: 10.h,
                                  ),
                                  Text(
                                    'Your Vehicles',
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ])
                        : SizedBox.shrink(),
                    InkWell(
                      onTap: () => Get.to(() => PrivacyPolicyView()),
                      child: Row(
                        children: [
                          Icon(
                            Icons.privacy_tip_outlined,
                            color: AppColors.green,
                          ),
                          SizedBox(
                            width: 10.h,
                          ),
                          Text(
                            "Pricay Policy",
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              title: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.logout,
                                    size: 50.sp,
                                    color: AppColors.green,
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    'Are you sure you want to logout from this account?',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // Cancel Button
                                      GestureDetector(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Container(
                                          width: 100.w,
                                          height: 40.h,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.r),
                                            color: AppColors.white,
                                            border: Border.all(
                                                color: AppColors.green),
                                          ),
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color: AppColors.green,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ),
                                      ),

                                      // Logout Button
                                      GestureDetector(
                                        onTap: () {
                                          signupcontroller.logout();
                                        },
                                        child: Container(
                                          width: 100.w,
                                          height: 40.h,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.r),
                                            color: AppColors.green,
                                          ),
                                          child: Text(
                                            'Logout',
                                            style: TextStyle(
                                              color: AppColors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.power_settings_new_rounded,
                            color: AppColors.green,
                          ),
                          SizedBox(
                            width: 10.h,
                          ),
                          Text(
                            'logout',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
