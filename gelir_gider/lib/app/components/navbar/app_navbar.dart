import 'package:flutter/material.dart';
import 'package:gelir_gider/app/core/extensions/extensions.dart';
import 'package:gelir_gider/app/core/radius/radius.dart';
import 'package:gelir_gider/modules/home/controller/home_controller.dart';
import 'package:get/get.dart';

class AppNavbar extends GetView<HomeController> {
  const AppNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      height: 10.h,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: CustomAppRadius.navbarRadius,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.onSurface.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: controller.navbarItems,
      ),
    );
  }
}
