import 'package:cargo_pants/data/controller/usercontroller.dart';
import 'package:cargo_pants/screens/home/home.dart';
import 'package:cargo_pants/utils/constants/colors.dart';
import 'package:cargo_pants/utils/constants/sizes.dart';
import 'package:cargo_pants/screens/profile/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find();

    // Retrieve the stored user data
    final String fullName =
        userController.storage.read('fullName') ?? 'Unknown';
    final String branchname =
        userController.storage.read('branch_name') ?? 'Unknown';
    final String phone = userController.storage.read('phone') ?? 'Unknown';
    final String companyname =
        userController.storage.read('company_name') ?? 'Unknown';
    final String savebrachRegion =
        userController.storage.read('branch_region') ?? 'Unknown';
    final String avatar =
        userController.storage.read('avatar') ?? 'assets/profile/user.jpg';

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(fontSize: ESizes.fontSizeMd),
        ),
        foregroundColor: EColors.white,
        backgroundColor: EColors.primary,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with background and avatar
            Stack(
              children: [
                // Background container that stays behind the avatar
                Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    color: EColors.primary,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                  ),
                ),
                // Positioned Avatar on top of the background
                Positioned(
                  top: 60, // Adjust the top value to position it properly
                  left: MediaQuery.of(context).size.width / 2 - 50,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://kago.akilikubwadigital.com/images/${userController.storage.read('avatar') ?? 'user.jpg'}',
                    ),
                  ),
                ),
              ],
            ),

            // Information Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personal Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      InfoRow(
                        icon: Iconsax.user,
                        label: 'Full Name',
                        value: fullName,
                      ),
                      InfoRow(
                        icon: Iconsax.tree,
                        label: 'Branch Name',
                        value: branchname,
                      ),
                      InfoRow(
                        icon: Iconsax.call,
                        label: 'Phone',
                        value: phone,
                      ),
                      InfoRow(
                        icon: Iconsax.calendar,
                        label: 'Branch Region',
                        value: savebrachRegion,
                      ),
                      InfoRow(
                        icon: Iconsax.calendar,
                        label: 'Company Name',
                        value: companyname,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Tags Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  // Update Password Row
                  GestureDetector(
                    onTap: () => Get.to(() => PersonalInformationScreen()),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.lock_reset),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Update Password',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Logout Row
                  GestureDetector(
                    onTap: () async {
                      UserController userController = Get.put(UserController());
                      await userController.logout();
                    },
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.red,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
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


// Reusable Widget for Info Rows
class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoRow({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: EColors.secondary),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Text(value, style: TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}