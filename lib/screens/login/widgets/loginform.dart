import 'package:cargo_pants/screens/navigation/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cargo_pants/utils/constants/colors.dart';
import 'package:cargo_pants/utils/constants/sizes.dart';
import 'package:cargo_pants/utils/constants/text_strings.dart';

class ELoginForm extends StatelessWidget {
  const ELoginForm({
    super.key,
  });
  
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          // Email Field
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.direct),
              labelText: ETexts.email,
            ),
          ),
          const SizedBox(
            height: ESizes.spaceBtwItems,
          ),

          // Password Field
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.password_check),
              suffix: Icon(Iconsax.eye_slash),
              labelText: ETexts.password,
            ),
          ),
          const SizedBox(
            height: ESizes.spaceBtwItems,
          ),

          // Sign In Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.to(() => const NavigationMenu()),
              style: ElevatedButton.styleFrom(
                backgroundColor: EColors.secondary,
                foregroundColor:EColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8), // Adjust the radius as needed
                ),
              ),
              child: const Text(ETexts.signIn,),
            ),
          ),
          const SizedBox(
            height: ESizes.spaceBtwInputFields,
          ),
        ],
      ),
    );
  }
}
