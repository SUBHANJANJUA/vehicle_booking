import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vehicle_booking/app/data/app_colors.dart';
import 'package:vehicle_booking/app/data/util/headingBlack.dart';
import 'package:vehicle_booking/app/modules/add_vehicle/controllers/add_vehicle_controller.dart';
import 'package:vehicle_booking/app/modules/add_vehicle/views/add_vehicle_detail_view.dart';
import 'package:vehicle_booking/app/modules/vehicle_detail/views/vehicle_detail_view.dart';
import 'package:vehicle_booking/gen/assets.gen.dart';

class FeaturedVehicleContainer extends StatelessWidget {
  FeaturedVehicleContainer({
    super.key,
    required this.name,
    required this.number,
    required this.location,
    required this.description,
    required this.deriveruserId,
    required this.type,
    required this.phone,
    this.ac,
    this.edit = false,
    this.documentId,
  });
  final AddVehicleController addvehiclecontroller =
      Get.put(AddVehicleController());
  final String name;
  final String number;
  final String location;
  final String deriveruserId;
  final String phone;
  final String description;
  final String type;
  final bool? ac;
  final bool? edit;
  final String? documentId;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: edit == true
          ? () {
              Get.to(AddVehicleDetailView(edit: true, documentId: documentId));
              addvehiclecontroller.nameController.text = name;
              addvehiclecontroller.numberController.text = number;
              addvehiclecontroller.locationController.text = location;
              addvehiclecontroller.contactController.text = phone;
              addvehiclecontroller.descriptionController.text = description;

              addvehiclecontroller.acVehicle = ac == true ? 1.obs : 2.obs;
              addvehiclecontroller.vehicleType = type == "self"
                  ? 1.obs
                  : type == "passenger"
                      ? 2.obs
                      : type == "loader"
                          ? 3.obs
                          : 4.obs;
            }
          : () => Get.to(() => VehicleDetailView(
                type: type,
                name: name,
                location: location,
                number: number,
                ac: ac,
                description: description,
                phone: phone,
                driverUserId: deriveruserId,
              )),
      child: Container(
        padding: EdgeInsets.all(5.h),
        width: 280.w,
        height: 80.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.green.withValues(alpha: 0.4),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 70.h,
                width: 70.w,
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppColors.lighGreen),
                child: type == "loader"
                    ? Image.asset(Assets.image.truckIcon.path)
                    : type == "bike"
                        ? Image.asset(Assets.image.bykeIcon.path)
                        : Image.asset(Assets.image.carIcon.path)),
            SizedBox(
              width: 15.h,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(child: HeadingBlack(text: name)),
                      ac == true
                          ? Text(
                              'AC',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.green),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                  TextGry(text: number),
                  TextGry(text: location),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
