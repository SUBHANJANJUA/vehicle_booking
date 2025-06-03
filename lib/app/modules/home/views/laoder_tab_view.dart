import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vehicle_booking/app/data/util/featured_vehicle_container.dart';
import 'package:vehicle_booking/app/data/util/search_form_field.dart';
import 'package:vehicle_booking/app/modules/home/controllers/home_controller.dart';

class LoaderTabview extends StatelessWidget {
  LoaderTabview({super.key});
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchFormField(
          controller: controller.loaderController,
          onChanged: (value) => controller.searchLoader.value = value,
        ),
        Expanded(
          child: Obx(() {
            final loaders = controller.filteredLoaders;
            return loaders.isEmpty
                ? Center(child: Text("No loader vehicles found."))
                : ListView.builder(
                    itemCount: loaders.length,
                    itemBuilder: (context, index) {
                      final vehicle = loaders[index];
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
