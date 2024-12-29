import 'dart:convert';
import 'package:cargo_pants/data/controller/usercontroller.dart';
import 'package:cargo_pants/model/parcel_model.dart';
import 'package:cargo_pants/utils/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cargo_pants/screens/home/home.dart';
import 'package:cargo_pants/screens/package/addpackage/add_package.dart';
import 'package:cargo_pants/screens/package/packagedetails/package_details.dart';
import 'package:cargo_pants/screens/profile/profile.dart';
import 'package:cargo_pants/utils/constants/colors.dart';
import 'package:cargo_pants/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';

class PackageScreen extends StatelessWidget {
  const PackageScreen({super.key});



  Future<List<Parcel>> fetchIncomingParcels() async {
  final token = await GetStorage().read('token');

  final response = await http.get(
    Uri.parse('${APIConstants.baseUrl}/api/parcel/incomming'),
    headers: {
      'Authorization': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjcsInVzZXJfZGF0YSI6eyJpZCI6Nywicm9sZSI6MiwiY3JlYXRlciI6NCwiY29tcGFueV9uYW1lIjoiTXV2dXppc2hhIiwicm9sZV9uYW1lIjoiQWRtaW4iLCJwaG9uZTEiOiIwNjE1NDk4MDI2IiwidXNlcm5hbWUiOiIwNjE1NDk4MDI2IiwiZnVsbmFtZSI6IklzYXlhIEJ1c2luZXNzICIsImJyYW5jaF9pZCI6MywiY29tcGFueV9pZCI6Mn0sImlhdCI6MTczNTQwMzE4MiwiZXhwIjoxNzY4MDYyMzgyLCJzdWIiOiJhY2Nlc3NBcGkifQ.NcwONl7Tav2nlh8col4PDSh9lnDQShODM5HC1q3ukLc',
    },
  );
  print('Response body: ${response.body}');
  print('Response status code: ${response.statusCode}');

  // Check if the response is successful
  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    print('Parsed Payload: $data');

    if (data['success']) {
      final List<Parcel> parcels = (data['parcels'] as List)
          .map((item) => Parcel.fromJson(item))
          .toList();
      print('Parcels List: $parcels');
      return parcels;
    } else {
      // Log the error message from the API
      print('Error: ${data['message']}');
      throw Exception('Failed to load parcels');
    }
  } else {
    // Handle non-200 responses
    throw Exception('Failed to fetch data from API. Status: ${response.statusCode}');
  }
}


  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomePage(),
      const PackageScreen(),
      const ProfileScreen(),
    ];
    
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          'Kagopoint',
          style: TextStyle(fontSize: ESizes.fontSizeLg),
        ),
        backgroundColor: EColors.primary,
        foregroundColor: EColors.white,
        elevation: 0,
      ),
      body: FutureBuilder<List<Parcel>>(
        future: fetchIncomingParcels(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No parcels found'),
            );
          } else {
            final parcels = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Search....',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Parcels',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () =>
                                  Get.to(() => const AddPackageScreen()),
                              icon: const Icon(Iconsax.add),
                              iconSize: 34,
                              color: Colors.black,
                            ),
                            const Text(
                              'Add Parcel',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Iconsax.box,
                                    color: EColors.primary, size: 40),
                                SizedBox(height: 8),
                                Text(
                                  'Incoming Parcel',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Iconsax.box_tick,
                                    color: EColors.secondary, size: 40),
                                SizedBox(height: 8),
                                Text(
                                  'Outgoing Parcel',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                    
                    const SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: parcels.length,
                      itemBuilder: (context, index) {
                        final parcel = parcels[index];
                        return buildParcelItem(parcel);
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: EColors.secondary,
        unselectedItemColor: Colors.grey,
        currentIndex: 1, // Default to the Parcels tab
        onTap: (index) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => pages[index]),
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

  Widget buildParcelItem(Parcel parcel) {
    final DateTime parsedDate = DateTime.parse(parcel.createdat);
  // Format the date to '12, May 2024'
  final String formattedDate = DateFormat('d, MMM yyyy').format(parsedDate);
    return GestureDetector(
      onTap: () => Get.to(() => PackageDetailsScreen(parcel: parcel)),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(
              Iconsax.box,
              color: EColors.primary,
              size: 30,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    parcel.packageName,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'ParcelID: ${parcel.barcodeId}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () =>
                  Get.to(() => PackageDetailsScreen(parcel: parcel)),
              style: TextButton.styleFrom(
                foregroundColor: parcel.senderName == 'In Delivery'
                    ? EColors.secondary
                    : parcel.senderName == 'Done'
                        ? Colors.green
                        : Colors.orange,
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 20),
                textStyle: const TextStyle(fontSize: 12),
              ),
              child: Text(formattedDate),
            ),
          ],
        ),
      ),
    );
  }
}
