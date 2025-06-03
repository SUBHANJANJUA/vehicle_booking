import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vehicle_booking/app/data/util/featured_vehicle_container.dart';
import 'package:vehicle_booking/app/data/util/search_form_field.dart';
import 'package:vehicle_booking/app/modules/home/controllers/home_controller.dart';

class BykeTabview extends StatelessWidget {
  BykeTabview({super.key});
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchFormField(
          controller: controller.bykeController,
          onChanged: (value) => controller.searchBike.value = value,
        ),
        Expanded(
          child: Obx(() {
            final bikes = controller.filteredBikes;
            return bikes.isEmpty
                ? Center(child: Text("No Byke found."))
                : ListView.builder(
                    itemCount: bikes.length,
                    itemBuilder: (context, index) {
                      final vehicle = bikes[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 7.h),
                        child: FeaturedVehicleContainer(
                          deriveruserId: vehicle.userId,
                          name: vehicle.name,
                          number: vehicle.number,
                          location: vehicle.location,
                          type: vehicle.vehicleType,
                          ac: false,
                          phone: vehicle.contact,
                          description: vehicle.description,
                        ),
                      );
                    },
                  );
          }),
        )
      ],
    );
  }
}
