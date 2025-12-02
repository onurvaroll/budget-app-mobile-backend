import 'package:flutter/material.dart';
import 'package:gelir_gider/app/themes/app_colors.dart';
import 'package:gelir_gider/modules/home/controller/home_controller.dart';
import 'package:get/state_manager.dart';

class NavigationItem extends GetView<HomeController> {
  const NavigationItem({super.key, required this.index, required this.icon});

  final int index;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Obx(() {
      final isSelected = controller.currentIndex.value == index;
      return GestureDetector(
        onTap: () => controller.changePage(index),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SVG kullanacağınız zaman burayı SvgPicture.asset(...) ile değiştirin
              Icon(
                icon,
                color: isSelected
                    ? (isDark
                          ? AppColors.darkTiffanyBlue
                          : AppColors.tiffanyBlue)
                    : (isDark ? AppColors.darkTextHint : AppColors.textHint),
                size: 28,
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: isSelected ? 5 : 0,
                height: isSelected ? 5 : 0,
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkTiffanyBlue
                      : AppColors.tiffanyBlue,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
