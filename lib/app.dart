import 'package:cargo_pants/main.dart';
import 'package:cargo_pants/screens/navigation/navigation_menu.dart';
import 'package:cargo_pants/screens/login/login.dart';
import 'package:cargo_pants/screens/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget {
  const App({super.key});

  Future<bool> isLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isLoggedIn(),
      builder: (context, snapshot) {
        // Show splash/loading screen while waiting for the result
        if (!snapshot.hasData) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        final bool loggedIn = snapshot.data!;

        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: initScreen == 0
              ? const OnboadingScreen() :  LoginScreen(),
        );
      },
    );
  }
}
