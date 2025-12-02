import 'package:flutter/material.dart';

class PageConfig {
  final String title;
  final Widget page;
  final IconData navIcon;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showAppBar;

  const PageConfig({
    required this.title,
    required this.page,
    required this.navIcon,
    this.actions,
    this.leading,
    this.showAppBar = true,
  });
}
