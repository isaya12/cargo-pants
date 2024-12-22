// import 'package:cargo_pants/screens/home/home.dart';
// import 'package:cargo_pants/screens/package/package.dart';
// import 'package:cargo_pants/screens/package/packagedetails/package_details.dart';
import 'package:cargo_pants/screens/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboadingScreen(),
    );
  }
}