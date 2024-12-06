import 'package:flutter/material.dart';

class ELightTextFieldTheme {
  ELightTextFieldTheme._();
  //---lightTextFieldTheme
  static final InputDecorationTheme lightTextFieldTheme =InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    labelStyle: TextStyle().copyWith(color: Colors.black,fontSize: 14,),
    hintStyle: TextStyle().copyWith(color: Colors.black,fontSize: 14,),
    errorStyle: TextStyle().copyWith(fontStyle: FontStyle.normal,),

    floatingLabelStyle: TextStyle().copyWith(color: Colors.black.withOpacity(0.8)),
    border: OutlineInputBorder().copyWith(borderRadius: BorderRadius.circular(14),
    borderSide: BorderSide(color: Colors.grey, width: 1.0)),

    enabledBorder: OutlineInputBorder().copyWith(borderRadius: BorderRadius.circular(14),
    borderSide: BorderSide(color: Colors.grey, width: 1.0)),

    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
    borderSide: BorderSide(color: Colors.black12, width: 1.0)),

    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
    borderSide: BorderSide(color: Colors.red, width: 1.0)),

    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
    borderSide: BorderSide(color: Colors.orange, width: 2.0),),

  );

  //---darkTextFieldTheme
  static final InputDecorationTheme darkTextFieldTheme =InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    labelStyle: TextStyle().copyWith(color: Colors.white,fontSize: 14,),
    hintStyle: TextStyle().copyWith(color: Colors.white,fontSize: 14,),
    errorStyle: TextStyle().copyWith(fontStyle: FontStyle.normal,),

    floatingLabelStyle: TextStyle().copyWith(color: Colors.white.withOpacity(0.8)),
    border: OutlineInputBorder().copyWith(borderRadius: BorderRadius.circular(14),
    borderSide: BorderSide(color: Colors.grey, width: 1.0)),

    enabledBorder: OutlineInputBorder().copyWith(borderRadius: BorderRadius.circular(14),
    borderSide: BorderSide(color: Colors.grey, width: 1.0)),

    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
    borderSide: BorderSide(color: Colors.white, width: 1.0)),

    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
    borderSide: BorderSide(color: Colors.red, width: 1.0)),

    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
    borderSide: BorderSide(color: Colors.orange, width: 2.0),),

  );
}
