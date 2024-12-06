import 'package:cargo_pants/screens/home/home.dart';
import 'package:cargo_pants/screens/onboarding/onboarding.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}