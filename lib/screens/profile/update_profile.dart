import 'package:cargo_pants/data/controller/usercontroller.dart';
import 'package:cargo_pants/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:cargo_pants/utils/constants/colors.dart';
import 'package:get/get.dart';

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({Key? key}) : super(key: key);
      
  @override
  Widget build(BuildContext context) {
final controller = Get.put(UserController());
    return Scaffold(
      backgroundColor: Colors.grey[200], // Background purple
      appBar: AppBar(
        backgroundColor: EColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
           Get.back();
          },
        ),
        title: const Text(
          'Update Password',
          style: TextStyle(color: Colors.white, fontSize: ESizes.fontSizeMd),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 CustomTextField(
                    label: 'Current Password',
                    hintText: 'Enter current password',
                    controller: controller.currentPasswordController,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: 'New Password',
                    hintText: 'Enter new password',
                    controller: controller.newPasswordController,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: 'Confirm New Password',
                    hintText: 'Confirm new password',
                    controller: controller.confirmPasswordController,
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2A2B5E),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: controller.isLoading.value
                          ? null
                          : () {
                              controller.updatePassword();
                            },
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Update Password',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                      
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.hintText, required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
