import 'package:get/get.dart';

import '../modules/add_vehicle/bindings/add_vehicle_binding.dart';
import '../modules/add_vehicle/views/add_vehicle_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/owner_home/bindings/owner_home_binding.dart';
import '../modules/owner_home/views/owner_home_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/vehicle_detail/bindings/vehicle_detail_binding.dart';
import '../modules/vehicle_detail/views/vehicle_detail_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.OWNER_HOME,
      page: () => const OwnerHomeView(),
      binding: OwnerHomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.VEHICLE_DETAIL,
      page: () => VehicleDetailView(
        type: '',
        name: '',
        number: '',
        location: '',
        description: '',
        phone: '',
        driverUserId: '',
      ),
      binding: VehicleDetailBinding(),
    ),
    GetPage(
      name: _Paths.ADD_VEHICLE,
      page: () => const AddVehicleView(),
      binding: AddVehicleBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => ChatView(
        currentUserId: '',
        otherUserId: '',
        otherUserName: '',
      ),
      binding: ChatBinding(),
    ),
  ];
}
