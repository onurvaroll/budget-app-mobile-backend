import 'package:gelir_gider/modules/category_management/binding/category_management_binding.dart';
import 'package:gelir_gider/modules/category_management/page/category_management_page.dart';
import 'package:gelir_gider/modules/home/binding/home_bindings.dart';
import 'package:gelir_gider/modules/home/page/home_page.dart';
import 'package:gelir_gider/modules/login/binding/login_bindings.dart';
import 'package:gelir_gider/modules/login/page/login_page.dart';
import 'package:gelir_gider/modules/splash/binding/splash_bindings.dart';
import 'package:gelir_gider/modules/splash/page/splash_page.dart';
import 'package:gelir_gider/modules/transaction/binding/transaction_binding.dart';
import 'package:gelir_gider/modules/transaction/page/transactions_page.dart';
import 'package:get/get.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: SplashBindings(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: AppRoutes.transactions,
      page: () => const TransactionsPage(),
      binding: TransactionBinding(),
    ),
    GetPage(
      name: AppRoutes.categoryManagement,
      page: () => const CategoryManagementPage(),
      binding: CategoryManagementBinding(),
    ),
  ];
}
