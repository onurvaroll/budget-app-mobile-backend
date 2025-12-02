import 'package:gelir_gider/app/core/base/base_controller.dart';
import 'package:gelir_gider/app/service/auth_service.dart';
import 'package:get/get.dart';

import 'package:gelir_gider/app/routes/app_routes.dart';

class LoginController extends BaseController {
  late final AuthService _authService;

  @override
  void onInit() {
    super.onInit();
    print('on init login controller');
    _authService = Get.find<AuthService>();
  }

  Future<void> loginWithGoogle() async {
    try {
      final user = await _authService.signInWithGoogle();
      if (user != null) {
        print('User logged in successfully: ${user.email}');
        Get.offAllNamed(AppRoutes.home);
      } else {
        print('Login failed or cancelled');
      }
    } catch (error) {
      // Handle login error
      print('Login failed: $error');
    }
  }

  Future<void> logout() async {
    try {
      await _authService.signOut();
      // Handle successful logout
      print('User logged out successfully');
    } catch (error) {
      // Handle logout error
      print('Logout failed: $error');
    }
  }
}
