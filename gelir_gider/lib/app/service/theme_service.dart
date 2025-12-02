import 'package:flutter/material.dart';
import 'package:gelir_gider/app/service/storage_service.dart';
import 'package:get/get.dart';

class ThemeService extends GetxService {
  late final StorageService _storageService;
  final _isDarkMode = false.obs;

  bool get isDarkMode => _isDarkMode.value;

  @override
  void onInit() {
    super.onInit();
    _storageService = Get.find<StorageService>();
    loadThemeData();
  }

  void loadThemeData() {
    final savedThemeMode = _storageService.getValue<String>(
      StorageKeys.themeMode,
    );
    if (savedThemeMode != null) {
      _isDarkMode.value = savedThemeMode == 'dark';
      Get.changeThemeMode(_isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    } else {
      final systemBrightness = Get.theme.brightness;
      _isDarkMode.value = systemBrightness == Brightness.dark;
    }
  }

  Future<void> changeThemeMode() async {
    _isDarkMode.value = !_isDarkMode.value;
    Get.changeThemeMode(_isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    await _storageService.setValue<String>(
      StorageKeys.themeMode,
      _isDarkMode.value ? 'dark' : 'light',
    );
  }
}
