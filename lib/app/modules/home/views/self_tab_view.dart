import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vehicle_booking/app/data/app_colors.dart';
import 'package:vehicle_booking/app/data/util/featured_vehicle_container.dart';
import 'package:vehicle_booking/app/data/util/search_form_field.dart';
import 'package:vehicle_booking/app/modules/home/controllers/home_controller.dart';

class SelfDriveTabView extends StatelessWidget {
  SelfDriveTabView({super.key});
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          dividerColor: AppColors.white,
          controller: controller.tabController,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 4.w, color: AppColors.green),
          ),
          labelColor: AppColors.black,
          unselectedLabelColor: AppColors.grey,
          labelStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
          tabs: const [
            Tab(text: 'All Cars'),
            Tab(text: 'AC Cars'),
          ],
        ),
        SizedBox(height: 20.h),
        Expanded(
          child: Obx(() {
            final selfCars = controller.filteredSelfDrives;
            final acSelfCars = selfCars.where((v) => v.acType == "AC").toList();

            return TabBarView(
              controller: controller.tabController,
              children: [
                /// All Self-Drive Cars Tab
                Column(
                  children: [
                    SearchFormField(
                      controller: controller.selfController,
                      onChanged: (value) =>
                          controller.searchSelfDrive.value = value,
                    ),
                    Expanded(
                      child: selfCars.isEmpty
                          ? Center(child: Text("No self-drive vehicles found."))
                          : ListView.builder(
                              itemCount: selfCars.length,
                              itemBuilder: (context, index) {
                                final vehicle = selfCars[index];
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 7.h),
                                  child: FeaturedVehicleContainer(
                                    deriveruserId: vehicle.userId,
                                    name: vehicle.name,
                                    number: vehicle.number,
                                    location: vehicle.location,
                                    type: vehicle.vehicleType,
                                    ac: vehicle.acType == "AC",
                                    phone: vehicle.contact,
                                    description: vehicle.description,
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),

                /// AC Self-Drive Cars Tab
                Column(
                  children: [
                    SearchFormField(
                      controller: controller.selfController,
                      onChanged: (value) =>
                          controller.searchSelfDrive.value = value,
                    ),
                    Expanded(
                      child: acSelfCars.isEmpty
                          ? Center(
                              child: Text("No AC self-drive vehicles found."))
                          : ListView.builder(
                              itemCount: acSelfCars.length,
                              itemBuilder: (context, index) {
                                final vehicle = acSelfCars[index];
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 7.h),
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
                              },
                            ),
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}
