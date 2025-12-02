import 'package:flutter/material.dart';
import 'package:gelir_gider/app/themes/app_colors.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  final isLoading = false.obs;

  bool get isLoadingValue => isLoading.value;

  void setLoading(bool value) => isLoading.value = value;

  void showErrorSnackbar({
    required String message,
    String title = 'Hata',
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.isDarkMode
          ? AppColors.darkExpense
          : AppColors.expense,
      colorText: Get.isDarkMode
          ? AppColors.darkTextPrimary
          : AppColors.textPrimary,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      duration: duration,
      icon: const Icon(Icons.error_outline, color: Colors.white),
      overlayBlur: 0.5,
      overlayColor: Colors.black12,
    );
  }

  void showSuccessSnackbar({
    required String message,
    String title = 'Başarılı',
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.isDarkMode ? AppColors.darkIncome : AppColors.income,
      colorText: Get.isDarkMode
          ? AppColors.darkTextPrimary
          : AppColors.textPrimary,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      duration: duration,
      icon: const Icon(Icons.check_circle_outline, color: Colors.white),
      overlayBlur: 0.5,
      overlayColor: Colors.black12,
    );
  }
}
