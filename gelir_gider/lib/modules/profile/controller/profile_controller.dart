import 'package:gelir_gider/app/core/base/base_controller.dart';
import 'package:gelir_gider/app/models/app_user.dart';
import 'package:gelir_gider/app/service/auth_service.dart';
import 'package:get/get.dart';

class ProfileController extends BaseController {
  final _authService = Get.find<AuthService>();

  Rx<AppUser?> get user => _authService.currentUser;

  @override
  void onInit() {
    super.onInit();
    if (user.value == null) {
      print("ProfileController: User is null, fetching profile...");
      _authService.getProfile().then((value) {
        if (value != null) {
          _authService.currentUser.value = value;
        }
      });
    } else {
      print("ProfileController: User found: ${user.value?.email}");
    }
  }
}
