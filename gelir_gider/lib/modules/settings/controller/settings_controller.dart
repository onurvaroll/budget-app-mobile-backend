import 'package:gelir_gider/app/core/base/base_controller.dart';
import 'package:gelir_gider/app/routes/app_routes.dart';
import 'package:gelir_gider/app/service/auth_service.dart';
import 'package:get/get.dart';

class SettingsController extends BaseController {
  Future<void> signOut() async {
    await Get.find<AuthService>().signOut();
    Get.offAllNamed(AppRoutes.login);
  }
}
