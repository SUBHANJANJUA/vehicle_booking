import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:intl/intl.dart';
import 'package:vehicle_booking/app/data/util/heading16Green.dart';
import '../../../../gen/assets.gen.dart';
import '../../../data/app_colors.dart';
import '../../../data/util/signup_row.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  SignupView({super.key});
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Get.put(SignupController());

    return SafeArea(
        child: Scaffold(
      body: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 30.h,
                    width: double.infinity,
                  ),
                  Image.asset(
                    Assets.image.logo.path,
                    width: 100.w,
                    height: 100.h,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 35.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.green),
                  ),
                  Heading16Green(
                    text: "Name",
                  ),
                  (controller.selectedValue == 1)
                      ? TextFormField(
                          readOnly: true,
                          controller: controller.nameController,
                          decoration: InputDecoration(
                            hintText: 'Your name',
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.black.withValues(alpha: 0.50),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter your name";
                            }
                            if (value.length < 3) {
                              return "Username be at least 3 characters";
                            }
                            return null;
                          },
                        )
                      : TextFormField(
                          controller: controller.nameController,
                          decoration: InputDecoration(
                            hintText: 'Your name',
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.black.withValues(alpha: 0.50),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter your name";
                            }
                            if (value.length < 3) {
                              return "Username be at least 3 characters";
                            }
                            return null;
                          },
                        ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Heading16Green(
                    text: "Email",
                  ),
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
                        return "Enter your Email";
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
                    height: 10.h,
                  ),
                  Heading16Green(text: 'Password'),
                  TextFormField(
                    controller: controller.passwordController,
                    obscureText: controller.obsecure.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your password';
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
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  (controller.selectedValue == 1)
                      ? Column(
                          children: [
                            Heading16Green(
                              text: "CNIC no.",
                            ),
                            TextFormField(
                              readOnly: true,
                              controller: controller.cnicNumberController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'CNIC',
                                prefixIcon: Icon(
                                  Icons.car_crash_outlined,
                                  color: Colors.black
                                      .withAlpha(128), // 0.50 opacity
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter your CNIC number.";
                                }
                                if (!RegExp(r'^\d{13}$').hasMatch(value)) {
                                  return "Please enter a valid 13-digit CNIC number.";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Heading16Green(
                              text: "License no.",
                            ),
                            TextFormField(
                              readOnly: true,
                              controller: controller.licenseNumberController,
                              decoration: InputDecoration(
                                hintText: 'ST-23-1067',
                                prefixIcon: Icon(
                                  Icons.car_crash_outlined,
                                  color: Colors.black.withValues(alpha: 0.50),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter your License no.";
                                }
                                if (value.length < 3) {
                                  return "License no. be at least 3 characters";
                                }
                                return null;
                              },
                            ),
                            // SizedBox(
                            //   height: 10.h,
                            // ),
                            // Heading16Green(
                            //   text: "License Expire Date",
                            // ),
                            // TextFormField(
                            //   controller: controller.licenseExpDateController,
                            //   readOnly: true, // Prevent manual input
                            //   onTap: () async {
                            //     DateTime? pickedDate = await showDatePicker(
                            //       context: context,
                            //       initialDate: DateTime.now(),
                            //       firstDate: DateTime(1900),
                            //       lastDate: DateTime(2100),
                            //     );

                            //     if (pickedDate != null) {
                            //       controller.licenseExpDateController.text =
                            //           DateFormat('yyyy-MM-dd')
                            //               .format(pickedDate);
                            //     }
                            //   },
                            //   decoration: InputDecoration(
                            //     hintText: 'Select Expire date',
                            //     prefixIcon: Icon(
                            //       Icons.car_crash_outlined,
                            //       color: Colors.black.withOpacity(0.5),
                            //     ),
                            //   ),
                            //   validator: (value) {
                            //     if (value == null || value.isEmpty) {
                            //       return "Enter License Expire Date";
                            //     }

                            //     DateTime? selectedDate =
                            //         DateTime.tryParse(value);
                            //     if (selectedDate == null ||
                            //         selectedDate.isBefore(DateTime.now())) {
                            //       return "Please enter a valid license date";
                            //     }

                            //     return null;
                            //   },
                            // ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Heading16Green(
                              text: "License Type",
                            ),
                            TextFormField(
                              controller: controller.licenseTypeController,
                              decoration: InputDecoration(
                                hintText: 'M/CAR',
                                prefixIcon: Icon(
                                  Icons.car_crash_outlined,
                                  color: Colors.black.withValues(alpha: 0.50),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter License type";
                                }
                                if (value.length < 3) {
                                  return "License type be at least 3 characters";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        )
                      : SizedBox.shrink()
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: SizedBox(
          height: 80.h,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SignInRowWidget(),
              SizedBox(height: 5.h),
              SizedBox(
                width: double.infinity,
                height: 45.h,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      final email = controller.emailController.text.trim();
                      final password =
                          controller.passwordController.text.trim();
                      final userType = controller.selectedValue.value == 1
                          ? 'driver'
                          : 'customer';

                      Get.find<SignupController>()
                          .register(email, password, userType);
                    }
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
