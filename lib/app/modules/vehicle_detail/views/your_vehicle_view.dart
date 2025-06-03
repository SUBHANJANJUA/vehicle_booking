import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vehicle_booking/app/data/util/custom_appbar.dart';
import 'package:vehicle_booking/app/data/util/featured_vehicle_container.dart';
import 'package:vehicle_booking/app/modules/home/controllers/home_controller.dart';
import 'package:vehicle_booking/app/modules/signup/controllers/signup_controller.dart';

class YourVehicleView extends StatelessWidget {
  YourVehicleView({super.key});
  final HomeController controller = Get.put(HomeController());
  final SignupController signupcontroller = Get.put(SignupController());
  @override
  Widget build(BuildContext context) {
    final user = signupcontroller.userModel.value;
    return Scaffold(
      appBar: CustomAppBar(title: 'Your Vehicle'),
      body: controller.vehicleList.isEmpty
          ? Center(child: Text("No vehicles found."))
          : ListView.builder(
              itemCount: controller.vehicleList.length,
              itemBuilder: (context, index) {
                final vehicle = controller.vehicleList[index];

                return vehicle.userId == user!.uid
                    ? Padding(
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
                          documentId: vehicle.documentId,
                          edit: true,
                        ),
                      )
                    : SizedBox.shrink();
              },
            ),
    );
  }
}
