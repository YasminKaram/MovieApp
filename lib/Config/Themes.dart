import 'package:flutter/material.dart';
import 'package:movieapp/Core/Utils/AppColors.dart';

class MyThemes {
  static ThemeData LightTheme = ThemeData(
    scaffoldBackgroundColor:  AppColors.Backgroundblack,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.primaryblack,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: AppColors.whitecolor,
        unselectedItemColor: AppColors.unselectcolor,
        elevation: 0,
      ));
}
