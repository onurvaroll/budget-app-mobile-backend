import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension NumX on num {
  double get h => (Get.height * this) / 100;

  double get w => (Get.width * this) / 100;

  //White Spaces//

  // yh is meaning the vertical space (using screen height)
  // yw is meaning the vertical space (using screen width)
  SizedBox get yh => SizedBox(height: (Get.height * this) / 100);

  SizedBox get yw => SizedBox(height: (Get.width * this) / 100);

  // xh is meaning the horizontal space (using screen height)
  // xw is meaning the horizontal space (using screen width)
  SizedBox get xh => SizedBox(width: (Get.height * this) / 100);

  SizedBox get xw => SizedBox(width: (Get.width * this) / 100);

  //Paddings//
  EdgeInsetsGeometry get pH => EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsetsGeometry get pV => EdgeInsets.symmetric(vertical: toDouble());
  EdgeInsetsGeometry get pVH =>
  EdgeInsets.symmetric(vertical: toDouble(), horizontal: toDouble());
  EdgeInsetsGeometry get pLeft => EdgeInsets.only(left: toDouble());
  EdgeInsetsGeometry get pTop => EdgeInsets.only(top: toDouble());
  EdgeInsetsGeometry get pBottom => EdgeInsets.only(bottom: toDouble());
  EdgeInsetsGeometry get pRight => EdgeInsets.only(right: toDouble());

  EdgeInsetsGeometry get pAll => EdgeInsets.all(toDouble());

  BorderRadius get allCircular => BorderRadius.circular(toDouble());

  BorderRadius get topCircular => BorderRadius.only(
    topLeft: Radius.circular(toDouble()),
    topRight: Radius.circular(toDouble()),
  );
  BorderRadius get bottomCircular => BorderRadius.only(
    bottomLeft: Radius.circular(toDouble()),
    bottomRight: Radius.circular(toDouble()),
  );
  BorderRadius get leftCircular => BorderRadius.only(
    topLeft: Radius.circular(toDouble()),
    bottomLeft: Radius.circular(toDouble()),
  );
  BorderRadius get rightCircular => BorderRadius.only(
    topRight: Radius.circular(toDouble()),
    bottomRight: Radius.circular(toDouble()),
  );
}

extension GradientX on List<Color> {
  LinearGradient get gradientLR => LinearGradient(
    colors: this,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  LinearGradient get gradientRL => LinearGradient(
    colors: this,
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );
  RadialGradient get radialGradient =>
      RadialGradient(colors: this, center: Alignment.center, radius: 0.5);

  LinearGradient get gradientTB => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: this,
  );
  LinearGradient get gradientBT => LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: this,
  );
}

extension BoxShadowX on Color {
  List<BoxShadow> get boxShadow => [
    BoxShadow(color: this, blurRadius: 3, offset: const Offset(0, 3)),
  ];

  List<BoxShadow> get menuBoxShadow => [
    BoxShadow(
      offset: const Offset(0, 5),
      color: this,
      spreadRadius: 2,
      blurRadius: 5,
      blurStyle: BlurStyle.normal,
    ),
  ];

  List<BoxShadow> get elevatedBoxShadow => [
    BoxShadow(
      // ignore: unnecessary_this
      color: this.withOpacity(0.2),
      blurRadius: 30,
      spreadRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];
}
