import 'package:cargo_pants/screens/home/home.dart';
import 'package:cargo_pants/utils/constants/colors.dart';
import 'package:cargo_pants/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: ()=>Get.back(),
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
              ),
              const SizedBox(height:ESizes.spaceBtwSections),
              _buildTextField(
                labelText: 'Password',
                prefixIcon: Iconsax.password_check,
              ),
              const SizedBox(
                height: ESizes.spaceBtwSections,
              ),
 
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
                  onPressed: ()=>Get.to(()=>const HomePage()),
                  child: const Text(
                    'Log in',
                    style: TextStyle(
                        fontSize: ESizes.fontSizeSm, color: EColors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    required IconData prefixIcon,
    bool obscureText = false,
  }) {
    return TextField(
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
