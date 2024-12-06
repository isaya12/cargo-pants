import 'package:cargo_pants/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Kagopoint',style: TextStyle(color: EColors.white),),
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
                    'Your Location',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Sleman, Yogyakarta',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
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
                        'See All >',
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
        selectedItemColor:EColors.secondary,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.box),
            label: 'Package',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.message),
            label: 'Message',
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
          Column(
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
          Text(
            status,
            style: TextStyle(fontSize: 12, color: statusColor),
          ),
        ],
      ),
    );
  }
}
