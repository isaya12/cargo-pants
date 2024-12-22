import 'package:cargo_pants/screens/package/package.dart';
import 'package:cargo_pants/screens/package/packagedetails/package_details.dart';
import 'package:cargo_pants/screens/profile/profile.dart';
// import 'package:cargo_pants/screens/package/package_screen.dart';  // Example import for PackageScreen
// import 'package:cargo_pants/screens/message_screen.dart';  // Example import for MessageScreen
// import 'package:cargo_pants/screens/profile_screen.dart';  // Example import for ProfileScreen
import 'package:cargo_pants/utils/constants/colors.dart';
import 'package:cargo_pants/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;  // Track selected bottom navigation index

  final List<Widget> _pages = [
    const HomePage(),  // Home Screen
    const PackageScreen(),  // Package Screen
    // const MessageScreen(),  // Message Screen
    const ProfileScreen(),  // Profile Screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
      automaticallyImplyLeading: false,
        title: const Text(
          'Kagopoint',
          style: TextStyle(color: EColors.white, fontSize: ESizes.fontSizeLg),
        ),
        backgroundColor: EColors.primary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Section
            Container(
              color: EColors.primary,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Location',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Mwananyamla, Dar es Salaam',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ESizes.fontSizeSm),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Tracking by Receipt',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Button Row
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildIconButton('Pick Up', Iconsax.box),
                  buildIconButton('Package Claim', Icons.assignment),
                  buildIconButton('Check Rates', Icons.monetization_on),
                  buildIconButton('Drop Off', Iconsax.location),
                ],
              ),
            ),

            // Current Shipping Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Current Shipping',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Transit',
                          style: TextStyle(color: EColors.secondary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('Cargo Ship - Receipt: #AS213DX670'),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        buildShippingStatus('Picked', true),
                        buildShippingStatus('Settled', true),
                        buildShippingStatus('Delivery', true),
                        buildShippingStatus('Sent', false),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('12 Dec 2024 - Jakarta, IDN'),
                        // Text('24 Jan 2025 - Dallas, USA'),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Recent Delivery Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Delivery',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'See All ',
                        style: TextStyle(color: EColors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  buildRecentDeliveryItem(
                      'Logitech Peripheral', '#AA5D9A879', 'In Delivery'),
                  buildRecentDeliveryItem(
                      'Apple Watch Imported', '#SFAS3212DC', 'Done'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: EColors.secondary,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;  // Update currentIndex when a tab is selected
          });
          // Navigate to the respective screen based on the selected index
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => _pages[_currentIndex]),
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.box),
            label: 'Parcels',
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Iconsax.user),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget buildIconButton(String label, IconData icon) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: EColors.secondary,
          child: Icon(icon, color: EColors.white, size: 30),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget buildShippingStatus(String label, bool isActive) {
    return Expanded(
      child: Column(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: isActive ? EColors.secondary : Colors.grey[300],
          ),
          const SizedBox(height: 4),
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  color: isActive ? EColors.secondary : Colors.grey[600])),
        ],
      ),
    );
  }

  Widget buildRecentDeliveryItem(String title, String receipt, String status) {
    Color statusColor;
    switch (status) {
      case 'In Delivery':
        statusColor = EColors.secondary;
        break;
      case 'Done':
        statusColor = EColors.secondary;
        break;
      default:
        statusColor = Colors.grey;
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           const Icon(
          Iconsax.box,  // You can choose any icon from available ones
          color: EColors.primary,
          size: 30,
        ),
        const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                      const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Receipt: $receipt',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => Get.to(() => const PackageDetailsScreen()),
            style: TextButton.styleFrom(
              foregroundColor: statusColor,
              padding: EdgeInsets.zero,
              minimumSize: const Size(50, 20),
              textStyle: const TextStyle(fontSize: 12),
            ),
            child: Text(status),
          ),
        ],
      ),
    );
  }
}
