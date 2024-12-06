import 'package:flutter/material.dart';

class EOutlineBottonTheme {
  EOutlineBottonTheme._();
  
  ///--- lightTheme
  static final  lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      side: BorderSide(color: Colors.blue),
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      padding: const EdgeInsets.symmetric(vertical:16,horizontal: 20,),
      textStyle: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.black),
    ),
  );
  //--darkTheme
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      side: BorderSide(color: Colors.blueAccent),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      padding: const EdgeInsets.symmetric(vertical:16,horizontal: 20,),
      textStyle: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white),
    ),
  );
}
