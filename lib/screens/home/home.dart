import 'package:cargo_pants/data/controller/usercontroller.dart';
import 'package:cargo_pants/utils/constants/colors.dart';
import 'package:cargo_pants/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends StatelessWidget {
  //  late final String branchImageUrl;
  @override
  Widget build(BuildContext context) {
    final  userController = Get.put(UserController());
    final String imageName = GetStorage().read('branchImage') ?? '';
    // Full image URL construction
    final String branchImageUrl = imageName.isNotEmpty
        ? 'https://kago.akilikubwadigital.com/images/$imageName'
        : '';
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: EColors.primary,
        elevation: 0,
        title: const Text(
          'Kagopoint',
          style: TextStyle(fontSize: ESizes.fontSizeLg, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                     Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
  'Dashboard',
  style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold, // Correct property
  ),
),

                      branchImageUrl.isNotEmpty
                              ? Container(
                    width: 600, // Fixed width
                    height: 100, // Fixed height
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8), // Optional: Rounded corners
                      image: DecorationImage(
                        image: NetworkImage(branchImageUrl),
                        fit: BoxFit.cover, // Ensures the image fills the container
                      ),
                    ),
                  )
                              : Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.image, size: 50),
                                ),
                          // SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SectionCard(
                    title: "20",
                    subtitle: "incoming parcels",
                    icon: Iconsax.box,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  SectionCard(
                    title: "38",
                    subtitle: "Outgoing parcels",
                    icon: Iconsax.box, // Pass the icon here
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SectionCard(
                    title: "Received parcel",
                    subtitle: "100",
                    icon: Iconsax.box,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  SectionCard(
                    subtitle: "400",
                    title: " sent parcel",
                    icon: Iconsax.box,
                  ),
                ],
              ),
              SizedBox(height: 16),
              ReferralCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class WalletCard extends StatelessWidget {
  WalletCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: EColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Wallet',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(height: 8),
          Obx(() => Text(
                '1224',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              )),
          SizedBox(height: 4),
          Obx(() => Text(
                'Account ',
                style: TextStyle(color: Colors.grey),
              )),
        ],
      ),
    );
  }
}

class SectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget? child;

  SectionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: EColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: EColors.primary, size: 28),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              if (subtitle.isNotEmpty)
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              if (child != null) child!,
            ],
          ),
        ),
      ),
    );
  }
}

class ReferralCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: EColors.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kago pont',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'simplfy the transportation process',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
