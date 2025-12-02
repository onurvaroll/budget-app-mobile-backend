import 'package:gelir_gider/app/repositories/category_repositories.dart';
import 'package:gelir_gider/app/repositories/transaction_repositories.dart';
import 'package:gelir_gider/app/service/api_service.dart';
import 'package:gelir_gider/app/service/auth_service.dart';
import 'package:gelir_gider/app/service/storage_service.dart';
import 'package:gelir_gider/app/service/theme_service.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Storage Service - senkron başlat, init SplashController'da yapılacak
    Get.put<StorageService>(StorageService());
    Get.put<ThemeService>(ThemeService());
    Get.put<ApiService>(ApiService());
    Get.lazyPut<AuthService>(() => AuthService());
    Get.put<CategoryRepositories>(CategoryRepositories());
    Get.put<TransactionRepositories>(TransactionRepositories());
  }
}
