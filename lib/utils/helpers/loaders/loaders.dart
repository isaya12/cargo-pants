import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cargo_pants/utils/constants/colors.dart';
import 'package:cargo_pants/utils/helpers/helper_functions.dart';

class ELoaders {
  static customToast({required message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      elevation: 0,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.transparent,
      content: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: EHelperFunctions.isDarkMode(Get.context!)
                ? EColors.darkerGrey.withOpacity(0.9)
                : EColors.grey.withOpacity(0.9)),
        child: Center(
            child: Text(message,
                style: Theme.of(Get.context!).textTheme.labelLarge)),
      ),
    ));
  }

  static successSnackBar({required title, required message, duration = 3}) {
    Get.snackbar(title, message,
        isDismissible: true,
        colorText: EColors.white,
        backgroundColor: EColors.primary,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: duration),
        margin: const EdgeInsets.all(10),
        icon: const Icon(Iconsax.check));
  }

  static warningSnackBar({required title, message = '', duration = 3}) {
    Get.snackbar(title, message,
        isDismissible: true,
        colorText: EColors.white,
        backgroundColor: EColors.warning,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: duration),
        margin: const EdgeInsets.all(10),
        icon: const Icon(Iconsax.warning_2));
  }

  static errorSnackBar({required title, required message, duration = 3}) {
    Get.snackbar(title, message,
        isDismissible: true,
        colorText: EColors.white,
        backgroundColor: EColors.error,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: duration),
        margin: const EdgeInsets.all(10),
        icon: const Icon(Iconsax.warning_2));
  }
}
