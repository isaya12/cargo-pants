import 'package:cargo_pants/screens/home/home.dart';
import 'package:cargo_pants/screens/package/package.dart';
import 'package:cargo_pants/screens/profile/profile.dart';
import 'package:cargo_pants/utils/constants/colors.dart';
import 'package:cargo_pants/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = EHelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          selectedIndex: controller.SelectedIndex.value,
          onDestinationSelected: (index) =>
              controller.SelectedIndex.value = index,
          indicatorColor: darkMode
              ? EColors.white.withOpacity(0.1)
              : EColors.dark.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.box), label: 'Parcel'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.SelectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> SelectedIndex = 0.obs;
  final screens = [
     HomePage(),
     PackageScreen(),
    const ProfileScreen(),
  ];
}
