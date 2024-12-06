import 'package:flutter/material.dart';

class EAppBarTheme {
  EAppBarTheme._();
  //---lightAppBarTheme
  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    actionsIconTheme: IconThemeData(color: Colors.black,size: 24,),
    centerTitle: false,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    scrolledUnderElevation: 0,
    iconTheme: IconThemeData(color: Colors.black,size: 24,),
    titleTextStyle: TextStyle(fontWeight:FontWeight.w600,color: Colors.black,fontSize: 18,),
  );

  //--darkAppBarTheme
  static const darkAppBarTheme =AppBarTheme(
    elevation: 0,
    scrolledUnderElevation:0,
    actionsIconTheme: IconThemeData(color: Colors.white,size: 24,),
    centerTitle: false,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.white,size: 24,),
    titleTextStyle: TextStyle(fontWeight:FontWeight.w600,color: Colors.white,fontSize: 18,),
  );
}
