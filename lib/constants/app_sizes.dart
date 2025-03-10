import 'package:flutter/material.dart';

class AppSizes {
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  // Padding ve margin değerleri
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;

  // Border radius değerleri
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 24.0;
  static const double radiusCircular = 100.0;
}
