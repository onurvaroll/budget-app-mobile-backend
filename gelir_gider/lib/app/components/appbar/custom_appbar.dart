import 'package:flutter/material.dart';
import 'package:gelir_gider/app/models/page_config.dart';
import 'package:get/get.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key, required this.pageConfig});

  final PageConfig pageConfig;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    if (!pageConfig.showAppBar) {
      return const SizedBox.shrink();
    }

    return AppBar(
      title: Text(pageConfig.title, style: context.theme.textTheme.titleLarge),
      leading: pageConfig.leading,
      actions: pageConfig.actions,
    );
  }
}
