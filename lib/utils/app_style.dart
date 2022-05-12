import 'package:flutter/material.dart';
import 'package:vizmo_employee_management_app/utils/app_colors.dart';

class AppStyle {
  static ThemeData lightTheme(BuildContext context){
    final ThemeData base = ThemeData.light();

    return base.copyWith(
        primaryColor: AppColors.primaryColor
    );
  }
}