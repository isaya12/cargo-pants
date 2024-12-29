import 'package:cargo_pants/data/controller/usercontroller.dart';
import 'package:cargo_pants/utils/constants/colors.dart';
import 'package:cargo_pants/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
        backgroundColor: EColors.primary,
        foregroundColor: EColors.white,
        title: const Text(
          'Log in',
          style: TextStyle(fontSize: ESizes.fontSizeMd),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Let's Login to your account",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: EColors.secondary,
                ),
              ),
              const SizedBox(height: 30),
              
              const SizedBox(height: 16),
              _buildTextField(
                labelText: 'Phone number',
                prefixIcon: Iconsax.user,
                controller: phone,
              ),
              const SizedBox(height: ESizes.spaceBtwSections),
              _buildTextField(
                labelText: 'Password',
                prefixIcon: Iconsax.password_check,
                controller: password,
                obscureText: true,
              ),
              // SizedBox(height: ESizes.spaceBtwItems),
              // Forgot Password Button
               Row(
                 children: [
                  const Spacer(),
                   TextButton(
                      onPressed: () {
                        // Navigate to Forgot Password Screen
                        // Get.to(() => ForgotPasswordScreen());
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: ESizes.fontSizeSm,
                          color: EColors.secondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                 ],
               ),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: EColors.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => controller.login(phone.text, password.text),
                  child: const Text(
                    'Log in',
                    style: TextStyle(
                        fontSize: ESizes.fontSizeSm, color: EColors.white),
                  ),
                ),
              ),

              const SizedBox(height: 16),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    required IconData prefixIcon,
    required TextEditingController controller,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
