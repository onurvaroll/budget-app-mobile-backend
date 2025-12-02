import 'package:flutter/material.dart';

class AppRadius {
  // Genel radius değerleri
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;
  static const double full = 100.0;

  // BorderRadius - All corners
  static BorderRadius allXs = BorderRadius.circular(xs);
  static BorderRadius allSm = BorderRadius.circular(sm);
  static BorderRadius allMd = BorderRadius.circular(md);
  static BorderRadius allLg = BorderRadius.circular(lg);
  static BorderRadius allXl = BorderRadius.circular(xl);
  static BorderRadius allXxl = BorderRadius.circular(xxl);
  static BorderRadius allXxxl = BorderRadius.circular(xxxl);
  static BorderRadius allFull = BorderRadius.circular(full);

  // BorderRadius - Top corners
  static BorderRadius topSm = const BorderRadius.only(
    topLeft: Radius.circular(sm),
    topRight: Radius.circular(sm),
  );
  static BorderRadius topMd = const BorderRadius.only(
    topLeft: Radius.circular(md),
    topRight: Radius.circular(md),
  );
  static BorderRadius topLg = const BorderRadius.only(
    topLeft: Radius.circular(lg),
    topRight: Radius.circular(lg),
  );
  static BorderRadius topXl = const BorderRadius.only(
    topLeft: Radius.circular(xl),
    topRight: Radius.circular(xl),
  );

  // BorderRadius - Bottom corners
  static BorderRadius bottomSm = const BorderRadius.only(
    bottomLeft: Radius.circular(sm),
    bottomRight: Radius.circular(sm),
  );
  static BorderRadius bottomMd = const BorderRadius.only(
    bottomLeft: Radius.circular(md),
    bottomRight: Radius.circular(md),
  );
  static BorderRadius bottomLg = const BorderRadius.only(
    bottomLeft: Radius.circular(lg),
    bottomRight: Radius.circular(lg),
  );
  static BorderRadius bottomXl = const BorderRadius.only(
    bottomLeft: Radius.circular(xl),
    bottomRight: Radius.circular(xl),
  );

  // Card radius
  static BorderRadius card = allLg;
  static BorderRadius cardLarge = allXl;

  // Button radius
  static BorderRadius button = allMd;
  static BorderRadius buttonLarge = allLg;

  // Input radius
  static BorderRadius input = allMd;
}
