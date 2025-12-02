import 'package:flutter/material.dart';
import 'package:gelir_gider/app/core/binding/app_bindings.dart';
import 'package:gelir_gider/app/routes/app_pages.dart';
import 'package:gelir_gider/app/routes/app_routes.dart';
import 'package:gelir_gider/app/themes/app_theme.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      getPages: AppPages.pages,
      initialRoute: AppRoutes.initial,
      initialBinding: AppBindings(),
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    ),
  );
}
