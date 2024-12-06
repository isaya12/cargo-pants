import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ECheckBoxTheme {
  //---lightCheckboxTheme
  static CheckboxThemeData lightCheckBoxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.white;
      } else {
        return Colors.black;
      }
    }),
    fillColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.blue;
      } else {
        return Colors.transparent;
      }
    }),
  );

  //---darkCheckboxTheme
  static CheckboxThemeData darkCheckBoxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.white;
      } else {
        return Colors.black;
      }
    }),
    fillColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.blue;
      } else {
        return Colors.transparent;
      }
    }),
  );
}
