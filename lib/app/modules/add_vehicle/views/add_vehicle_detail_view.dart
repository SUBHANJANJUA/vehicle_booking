import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vehicle_booking/app/data/app_colors.dart';
import 'package:vehicle_booking/app/data/util/custom_appbar.dart';
import 'package:vehicle_booking/app/data/util/heading16Green.dart';
import 'package:vehicle_booking/app/modules/add_vehicle/controllers/add_vehicle_controller.dart';
import 'package:vehicle_booking/app/modules/home/controllers/home_controller.dart';
import 'package:vehicle_booking/app/modules/home/views/home_view.dart';
import 'package:vehicle_booking/app/modules/signup/controllers/signup_controller.dart';

class AddVehicleDetailView extends StatelessWidget {
  AddVehicleDetailView({
    super.key,
    this.edit = false,
    this.documentId,
  });

  final AddVehicleController controller = Get.put(AddVehicleController());
  final SignupController signupcontroller = Get.put(SignupController());
  final HomeController homecontroller = Get.put(HomeController());
  final bool? edit;
  final String? documentId;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  resizeToAvoidBottomInset: false,

      appBar: CustomAppBar(title: 'Add Vehicle Details'),
      body: Obx(
        () => Form(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 110.h,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 120.w,
                          child: Container(
                            width: 100.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                              color: AppColors.green,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              controller.vehicleType == 3
                                  ? Icons.fire_truck_outlined
                                  : controller.vehicleType == 4
                                      ? Icons.motorcycle_outlined
                                      : Icons.directions_car,
                              color: AppColors.white,
                              size: 75.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Heading16Green(
                    text: "Enter Vehicle name",
                  ),
                  TextFormField(
                    controller: controller.nameController,
                    readOnly: edit == true,
                    decoration: InputDecoration(
                      hintText: 'Vehicle name',
                      prefixIcon: Icon(
                        Icons.car_crash_outlined,
                        color: Colors.black.withValues(alpha: 0.50),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter vehicle name";
                      }
                      if (value.length < 3) {
                        return "Vehicle name be at least 3 characters";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Heading16Green(
                    text: "Vehicle Registration no.",
                  ),
                  TextFormField(
                    readOnly: edit == true,
                    controller: controller.numberController,
                    textCapitalization: TextCapitalization.characters,
                    decoration: InputDecoration(
                      hintText: 'LEC-10-661',
                      prefixIcon: Icon(
                        Icons.car_crash_outlined,
                        color: Colors.black.withValues(alpha: 0.50),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Vehicle Registration no.";
                      }
                      if (value.length < 3) {
                        return "Vehicle Registration no. be at least 3 characters";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Heading16Green(
                    text: "Contact no.",
                  ),
                  TextFormField(
                    controller: controller.contactController,
                    decoration: InputDecoration(
                      prefixText: "+92",
                      hintText: '3000000000',
                      prefixIcon: Icon(
                        Icons.car_crash_outlined,
                        color: Colors.black.withValues(alpha: 0.50),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Contact no.";
                      }
                      if (value.length != 10) {
                        return "Contact no. be at least 10 characters";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Heading16Green(
                    text: "Enter Location",
                  ),
                  TextFormField(
                    controller: controller.locationController,
                    decoration: InputDecoration(
                      hintText: 'Sialkot, Punjab',
                      prefixIcon: Icon(
                        Icons.car_crash_outlined,
                        color: Colors.black.withValues(alpha: 0.50),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Location";
                      }
                      if (value.length < 3) {
                        return "Location be at least 3 characters";
                      }
                      return null;
                    },
                  ),
                  (controller.vehicleType.value == 3 ||
                          controller.vehicleType.value == 4)
                      ? SizedBox.shrink()
                      : Column(
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 20.w,
                                      height: 20.h,
                                      child: Radio(
                                        value: 1,
                                        groupValue: controller.acVehicle.value,
                                        onChanged: controller.onACvehicle,
                                        activeColor: AppColors.green,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      'AC',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 80.w),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 20.w,
                                      height: 20.h,
                                      child: Radio(
                                        value: 2,
                                        groupValue: controller.acVehicle.value,
                                        onChanged: controller.onACvehicle,
                                        activeColor: AppColors.green,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      'Non AC',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Heading16Green(
                    text: "Description",
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.lighGreen,
                        borderRadius: BorderRadius.circular(15.r)),
                    child: TextFormField(
                      maxLines: 5,
                      controller: controller.descriptionController,
                      decoration: InputDecoration(
                        hintText: 'Enter Description',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Description";
                        }
                        if (value.length < 3) {
                          return "Description be at least 3 characters";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  edit == true
                      ? Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        AppColors.red),
                                  ),
                                  onPressed: () async {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: AppColors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12.r)),
                                            title: Text(
                                              "Delete Vehicle",
                                              style: TextStyle(
                                                  color: AppColors.green,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                    'Are you sure want to delete this vehicle?'),
                                                SizedBox(
                                                  height: 20.h,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  spacing: 10.w,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Get.back(),
                                                      child: Text('Cancal'),
                                                    ),
                                                    ElevatedButton(
                                                        onPressed: () async {
                                                          if (documentId !=
                                                              null) {
                                                            await controller
                                                                .deleteVehicle(
                                                                    documentId!);
                                                            homecontroller
                                                                .resetTabIndex();
                                                            Get.offAll(() =>
                                                                HomeView());
                                                          }
                                                        },
                                                        child: Text(
                                                          "Delete",
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .white),
                                                        ))
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: Text(
                                    'Delele',
                                    style: TextStyle(
                                        fontSize: 20, color: AppColors.white),
                                  )),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formkey.currentState!.validate()) {
                                      if (documentId != null) {
                                        await controller
                                            .updateVehicle(documentId!);
                                        homecontroller.resetTabIndex();
                                        Get.offAll(() => HomeView());
                                      }
                                    }
                                  },
                                  child: Text(
                                    'Update',
                                    style: TextStyle(
                                        fontSize: 20, color: AppColors.white),
                                  )),
                            ),
                          ],
                        )
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () async {
                                if (_formkey.currentState!.validate()) {
                                  final user = signupcontroller.userModel.value;
                                  if (user != null) {
                                    await controller.saveVehicleToFirebase(
                                        userId: user.uid);
                                    homecontroller.resetTabIndex();
                                    Get.offAll(() => HomeView());
                                  }
                                }
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                    fontSize: 20, color: AppColors.white),
                              )),
                        ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
