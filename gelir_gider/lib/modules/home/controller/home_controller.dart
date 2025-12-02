import 'package:flutter/material.dart';
import 'package:gelir_gider/app/components/navbar/navigation_item.dart';
import 'package:gelir_gider/app/core/base/base_controller.dart';
import 'package:gelir_gider/app/models/page_config.dart';
import 'package:gelir_gider/modules/dashboard/page/dashboard_page.dart';
import 'package:gelir_gider/modules/profile/page/profile_page.dart';
import 'package:gelir_gider/modules/settings/page/settings_page.dart';
import 'package:gelir_gider/app/routes/app_routes.dart';
import 'package:get/get.dart';

class HomeController extends BaseController {
  final currentIndex = 0.obs;

  late final List<PageConfig> pageConfigs;

  @override
  void onInit() {
    super.onInit();
    pageConfigs = [
      PageConfig(
        title: 'Bütçe Yönetimi',
        page: const DashboardPage(),
        navIcon: Icons.home_rounded,
        actions: [
          IconButton(
            onPressed: goToTransactions,
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      PageConfig(
        title: 'Profil',
        page: const ProfilePage(),
        navIcon: Icons.person_outline_rounded,
      ),
      PageConfig(
        title: 'Ayarlar',
        page: const SettingsPage(),
        navIcon: Icons.settings_rounded,
      ),
    ];
  }

  List<Widget> get pages => pageConfigs.map((config) => config.page).toList();

  List<NavigationItem> get navbarItems => pageConfigs
      .asMap()
      .entries
      .map(
        (entry) => NavigationItem(index: entry.key, icon: entry.value.navIcon),
      )
      .toList();

  PageConfig get currentPageConfig => pageConfigs[currentIndex.value];

  void changePage(int index) {
    currentIndex.value = index;
  }

  void goToTransactions() {
    Get.toNamed(AppRoutes.transactions);
  }
}
