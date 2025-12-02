import 'package:gelir_gider/app/core/base/base_controller.dart';
import 'package:gelir_gider/app/routes/app_routes.dart';
import 'package:gelir_gider/app/service/api_service.dart';
import 'package:gelir_gider/app/service/auth_service.dart';
import 'package:gelir_gider/app/service/storage_service.dart';
import 'package:get/get.dart';

class SplashController extends BaseController {
  @override
  void onInit() {
    super.onInit();
    print('on init splash controller');
  }

  @override
  void onReady() async {
    super.onReady();
    await initializeServices();
    await checkTokenAndRedirect();
  }

  Future<void> initializeServices() async {
    // Storage Service init
    final storageService = Get.find<StorageService>();
    await storageService.init();

    // API Service init
    final apiService = Get.find<ApiService>();
    await apiService.init();

    // Auth Service init
    final authService = Get.find<AuthService>();
    await authService.init();

    var map = storageService.getAllValues();
    print('Storage values: $map');
  }
}

Future<void> checkTokenAndRedirect() async {
  final _authService = Get.find<AuthService>();
  final isLoggedIn = await _authService.isLoggedIn();
  if (isLoggedIn) {
    Get.offAllNamed(AppRoutes.home);
  } else {
    Get.offAllNamed(AppRoutes.login);
  }
}
