import 'package:flutter/material.dart';

class EChipTheme {
  EChipTheme._();

  //lightChipTheme
  static ChipThemeData lightChipTheme = ChipThemeData(
    selectedColor: Colors.blue,
    checkmarkColor: Colors.white,
    disabledColor: Colors.grey.withOpacity(0.4),
    labelStyle: TextStyle(color: Colors.black,),
    padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal:12, ),
  );

  //--darkchiptheme
  static ChipThemeData darkChipTheme = ChipThemeData(
    selectedColor: Colors.blue,
    checkmarkColor: Colors.white,
    disabledColor: Colors.grey,
    labelStyle: TextStyle(color: Colors.white,),
    padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal:12, ),
  );
}
