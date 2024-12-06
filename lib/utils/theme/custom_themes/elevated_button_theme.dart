import 'package:flutter/material.dart';

class EElevatedButtonTheme {
  EElevatedButtonTheme._();

  ///--- lightTheme
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(vertical:18),
      textStyle: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white),
    ),
  );
  //--darkTheme
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(vertical:18),
      textStyle: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white),
    ),
  );
}
