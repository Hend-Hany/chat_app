import 'package:flutter/material.dart';

import '../app_colors/app_colors.dart';

class Utils {

  static ThemeData get appTheme {
    return ThemeData(
      appBarTheme: AppBarTheme(
        color: AppColors.black,
        elevation: 0,
      ),
      canvasColor: AppColors.black,
      iconTheme: IconThemeData(
        color: AppColors.white
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.darkGray
      ),
    );
  }
}
