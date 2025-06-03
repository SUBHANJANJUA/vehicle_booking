import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vehicle_booking/app/data/app_colors.dart';
import 'package:vehicle_booking/app/modules/add_vehicle/views/add_vehicle_view.dart';
import 'package:vehicle_booking/app/modules/chat/views/chat_list_view.dart';
import 'package:vehicle_booking/app/modules/home/views/byke_tab_view.dart';
import 'package:vehicle_booking/app/modules/home/views/passenger_tab_view.dart';
import 'package:vehicle_booking/app/modules/home/views/home_tab_view.dart';
import 'package:vehicle_booking/app/modules/home/views/laoder_tab_view.dart';
import 'package:vehicle_booking/app/modules/home/views/profile_tab_view.dart';
import 'package:vehicle_booking/app/modules/home/views/self_tab_view.dart';
import 'package:vehicle_booking/app/modules/signup/controllers/signup_controller.dart';
import 'package:vehicle_booking/gen/assets.gen.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  final List<Widget> screens = [
    HomeTabView(),
    BykeTabview(),
    PassengerTabView(),
    LoaderTabview(),
    SelfDriveTabView(),
    ProfileTabView(),
  ];

  final SignupController signupcontroller = Get.put(SignupController());
  final ProfileController profilecontroller = Get.put(ProfileController());

  final List<String> appBarTitles = [
    'Home',
    'Byke',
    'Cars',
    'Loaders',
    'Self Drive',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    controller.fetchAllVehicles();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        surfaceTintColor: AppColors.white,
        title: InkWell(
            onTap: () => controller.currentIndex.value = 5,
            child: Obx(() {
              final user = signupcontroller.userModel.value;
              if (user == null) return CircularProgressIndicator();
              return Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(50.r),
                      child: Image.asset(
                        Assets.image.logo.path,
                        width: 50.w,
                        height: 50.h,
                      )),
                  SizedBox(
                    width: 15.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          maxLines: 1,
                          'Hi ${user.name}!',
                          style: TextStyle(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.green),
                        ),
                        Text(
                          maxLines: 1,
                          user.email,
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            })),
        actions: [
          signupcontroller.driver.value
              ? Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: InkWell(
                    onTap: () => Get.to(() => ChatListView()),
                    child: Icon(
                      Icons.message,
                      color: AppColors.green,
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ],
        backgroundColor: AppColors.white,
      ),
      body: Obx(() {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
          child: KeyedSubtree(
            key: ValueKey<int>(controller.currentIndex.value),
            child: screens[controller.currentIndex.value],
          ),
        );
      }),
      floatingActionButton: signupcontroller.driver.value
          ? FloatingActionButton(
              onPressed: () {
                Get.to(() => AddVehicleView());
              },
              backgroundColor: Colors.green,
              shape: const CircleBorder(),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 35.sp,
              ),
            )
          : SizedBox.shrink(),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          iconSize: 30.sp,
          selectedItemColor: AppColors.green,
          unselectedItemColor: AppColors.black,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          currentIndex: controller.currentIndex.value,
          selectedLabelStyle:
              TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700),
          unselectedLabelStyle:
              TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
          onTap: (value) {
            controller.updateCurrentIndex(value);
          },
          items: [
            _buildBottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'Home', index: 0),
            _buildBottomNavigationBarItem(
                icon: Icon(Icons.motorcycle_outlined), label: 'Byke', index: 1),
            _buildBottomNavigationBarItem(
                icon: Icon(Icons.drive_eta), label: "Passenger", index: 2),
            _buildBottomNavigationBarItem(
                icon: Icon(Icons.fire_truck), label: 'Loaders', index: 3),
            _buildBottomNavigationBarItem(
                icon: Icon(Icons.electric_car), label: "Self Drive", index: 4),
            _buildBottomNavigationBarItem(
                icon: Icon(Icons.person), label: "Profile", index: 5),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required Icon icon,
    required String label,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: icon,
      backgroundColor: controller.currentIndex.value == index
          ? AppColors.green
          : AppColors.black,
      label: label,
    );
  }
}
