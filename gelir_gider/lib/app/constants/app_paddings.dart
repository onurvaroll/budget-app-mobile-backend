import 'package:flutter/material.dart';

class AppPaddings {
  // Genel padding değerleri
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;

  // EdgeInsets - All
  static const EdgeInsets allXs = EdgeInsets.all(xs);
  static const EdgeInsets allSm = EdgeInsets.all(sm);
  static const EdgeInsets allMd = EdgeInsets.all(md);
  static const EdgeInsets allLg = EdgeInsets.all(lg);
  static const EdgeInsets allXl = EdgeInsets.all(xl);
  static const EdgeInsets allXxl = EdgeInsets.all(xxl);

  // EdgeInsets - Horizontal
  static const EdgeInsets hXs = EdgeInsets.symmetric(horizontal: xs);
  static const EdgeInsets hSm = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets hMd = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets hLg = EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets hXl = EdgeInsets.symmetric(horizontal: xl);
  static const EdgeInsets hXxl = EdgeInsets.symmetric(horizontal: xxl);

  // EdgeInsets - Vertical
  static const EdgeInsets vXs = EdgeInsets.symmetric(vertical: xs);
  static const EdgeInsets vSm = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets vMd = EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets vLg = EdgeInsets.symmetric(vertical: lg);
  static const EdgeInsets vXl = EdgeInsets.symmetric(vertical: xl);
  static const EdgeInsets vXxl = EdgeInsets.symmetric(vertical: xxl);

  // Card padding
  static const EdgeInsets card = EdgeInsets.all(lg);
  static const EdgeInsets cardCompact = EdgeInsets.all(md);

  // List item padding
  static const EdgeInsets listItem = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: md,
  );
  static const EdgeInsets listItemCompact = EdgeInsets.symmetric(
    horizontal: md,
    vertical: sm,
  );

  // Page padding
  static const EdgeInsets page = EdgeInsets.all(lg);
  static const EdgeInsets pageHorizontal = EdgeInsets.symmetric(horizontal: lg);
}
