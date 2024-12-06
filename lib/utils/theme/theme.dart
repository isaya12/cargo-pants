import 'package:cargo_pants/utils/constants/colors.dart';
import 'package:cargo_pants/utils/theme/custom_themes/appbar_theme.dart';
import 'package:cargo_pants/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:cargo_pants/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:cargo_pants/utils/theme/custom_themes/chip_theme.dart';
import 'package:cargo_pants/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:cargo_pants/utils/theme/custom_themes/outline_botton.dart';
import 'package:cargo_pants/utils/theme/custom_themes/text_field_theme.dart';
import 'package:cargo_pants/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class EAppTheme {
  EAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'poppins',
    brightness: Brightness.light,
    primaryColor: EColors.primary,
    scaffoldBackgroundColor:Colors.white,
    chipTheme: EChipTheme.lightChipTheme,
    textTheme: ETextTheme.lightTextTheme,
    appBarTheme: EAppBarTheme.lightAppBarTheme,
    elevatedButtonTheme: EElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: EOutlineBottonTheme.lightOutlinedButtonTheme,
    checkboxTheme: ECheckBoxTheme.lightCheckBoxTheme,
    bottomSheetTheme: EBottomSheetTheme.lightBottomSheetTheme,
    inputDecorationTheme: ELightTextFieldTheme.lightTextFieldTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'poppins',
    brightness: Brightness.dark,
    scaffoldBackgroundColor:Colors.black,
    primaryColor: EColors.primary,
    appBarTheme: EAppBarTheme.darkAppBarTheme,
    chipTheme: EChipTheme.darkChipTheme,
    textTheme: ETextTheme.darkTextTheme,
    elevatedButtonTheme: EElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: EOutlineBottonTheme.darkOutlinedButtonTheme,
    checkboxTheme: ECheckBoxTheme.darkCheckBoxTheme,
    bottomSheetTheme: EBottomSheetTheme.darkBottomSheetTheme,
    inputDecorationTheme: ELightTextFieldTheme.darkTextFieldTheme,
  );
}
