import 'package:flutter/material.dart';
import 'package:gelir_gider/app/components/appbar/custom_appbar.dart';
import 'package:gelir_gider/app/components/navbar/app_navbar.dart';
import 'package:gelir_gider/modules/home/controller/home_controller.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: CustomAppbar(pageConfig: controller.currentPageConfig),
        extendBody: true,
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: controller.pages,
        ),
        bottomNavigationBar: const AppNavbar(),
      ),
    );
  }
}
