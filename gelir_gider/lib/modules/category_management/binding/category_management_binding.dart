import 'package:gelir_gider/modules/category_management/controller/category_management_controller.dart';
import 'package:get/get.dart';

class CategoryManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryManagementController>(
      () => CategoryManagementController(),
    );
  }
}
