import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vehicle_booking/app/data/app_colors.dart';
import 'package:vehicle_booking/app/data/util/featured_vehicle_container.dart';
import 'package:vehicle_booking/app/modules/home/controllers/home_controller.dart';
import '../../../data/util/headingBlack.dart';

class HomeTabView extends StatelessWidget {
  HomeTabView({super.key});
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top Banner
        Container(
          width: double.infinity,
          height: 150.h,
          decoration: BoxDecoration(
            color: AppColors.lighGreen,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(35.r)),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome Back...!',
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.green,
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  'From passengers to packages\nbook the right vehicle for every journey, anytime, anywhere.',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.green,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Content
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.h),

                // Featured Cars
                HeadingBlack(text: 'Featured Cars'),
                SizedBox(height: 5.h),
                SizedBox(
                  height: 110.h,
                  child: controller.vehicleList.isEmpty
                      ? Center(child: Text("No AC vehicles found."))
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.vehicleList.length,
                          itemBuilder: (context, index) {
                            final vehicle = controller.vehicleList[index];
                            if (vehicle.acType == "AC" &&
                                vehicle.vehicleType == "passenger") {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 15.h),
                                child: FeaturedVehicleContainer(
                                  deriveruserId: vehicle.userId,
                                  name: vehicle.name,
                                  number: vehicle.number,
                                  location: vehicle.location,
                                  type: vehicle.vehicleType,
                                  ac: true,
                                  phone: vehicle.contact,
                                  description: vehicle.description,
                                ),
                              );
                            } else {
                              return SizedBox.shrink();
                            }
                          },
                        ),
                ),

                SizedBox(height: 10.h),

                // All Cars
                HeadingBlack(text: 'All Cars'),
                Expanded(
                  child: controller.vehicleList.isEmpty
                      ? Center(child: Text("No vehicles found."))
                      : ListView.builder(
                          itemCount: controller.vehicleList.length,
                          itemBuilder: (context, index) {
                            final vehicle = controller.vehicleList[index];
                            return vehicle.vehicleType == "passenger"
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.w, vertical: 7.h),
                                    child: FeaturedVehicleContainer(
                                      name: vehicle.name,
                                      deriveruserId: vehicle.userId,
                                      number: vehicle.number,
                                      location: vehicle.location,
                                      type: vehicle.vehicleType,
                                      ac: vehicle.acType == "AC",
                                      phone: vehicle.contact,
                                      description: vehicle.description,
                                    ),
                                  )
                                : SizedBox.shrink();
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
