import 'package:cargo_pants/data/controller/usercontroller.dart';
import 'package:cargo_pants/screens/home/home.dart';
import 'package:cargo_pants/utils/constants/colors.dart';
import 'package:cargo_pants/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            onPressed: () => Get.to(() => const HomePage()),
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with background and avatar
            // Padding(
            // padding: const EdgeInsets.all(8.0),
            Stack(
              children: [
                Container(
                  height: 70,
                  decoration: const BoxDecoration(
                    color: EColors.primary,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: MediaQuery.of(context).size.width / 2 - 50,
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                      'assets/profile/user.jpg', // Replace with profile image URL
                    ),
                  ),
                ),
              ],
            ),
            // ),

            const SizedBox(height: 60),

            // Profile Info
            const Center(
              child: Column(
                children: [
                  Text(
                    'Arnoldy Chafe',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '@Arnoldy',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Bandung | Joined March 2023',
                    style: TextStyle(
                      fontSize: 14,
                      color: EColors.secondary,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      'CEO System D, Because your satisfaction is everything & Standing out from the rest, and that\'s what we want you to be as well.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Update',
                      style: TextStyle(color: EColors.black),
                    ),
                  ),
                  Container(
                    width: 1, // Thickness of the line
                    height: 30, // Height of the line
                    color: Colors.grey[400], // Color of the line
                  ),
                  const Column(
                    children: [
                      Text(
                        'Parcel by me',
                        style: TextStyle(color: EColors.black),
                      ),
                      Text('30')
                    ],
                  ),
                  Container(
                    width: 1, // Thickness of the line
                    height: 30, // Height of the line
                    color: Colors.grey[400], // Color of the line
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz),
                  ),
                ],
              ),
            ),

            // Information Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100], // Updated background color
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(
                          0.5), // Adjusted shadow color and transparency
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(2, 4), // Position of the shadow
                    ),
                  ],
                ),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Information',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const InfoRow(
                          icon: Iconsax.user,
                          label: 'Full Name',
                          value: 'fred john akilikubwa',
                        ),
                        const InfoRow(
                          icon: Iconsax.message,
                          label: 'Email',
                          value: 'Hello@adalahreza.com',
                        ),
                        const InfoRow(
                          icon: Iconsax.call,
                          label: 'Phone',
                          value: '+62 517 218 92 00',
                        ),
                        const InfoRow(
                          icon: Iconsax.calendar,
                          label: 'Joined',
                          value: '26 March, 2023',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Tags Section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                onPressed: () async {
                  UserController userController = Get.put(UserController());
                  await userController.logout(); // Call the logout function
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
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
          Text(value, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}

// Reusable Widget for Tags

