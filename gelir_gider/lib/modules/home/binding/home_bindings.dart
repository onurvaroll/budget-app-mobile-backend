import 'package:gelir_gider/modules/dashboard/controller/dashboard_controller.dart';
import 'package:gelir_gider/modules/home/controller/home_controller.dart';
import 'package:gelir_gider/modules/profile/controller/profile_controller.dart';
import 'package:gelir_gider/modules/settings/controller/settings_controller.dart';
import 'package:get/get.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<SettingsController>(() => SettingsController());
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
