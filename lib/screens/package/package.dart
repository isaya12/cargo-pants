import 'dart:convert';
import 'package:cargo_pants/model/parcel_model.dart';
import 'package:cargo_pants/utils/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cargo_pants/screens/package/addpackage/add_package.dart';
import 'package:cargo_pants/screens/package/packagedetails/package_details.dart';
import 'package:cargo_pants/utils/constants/colors.dart';
import 'package:cargo_pants/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';

class PackageScreen extends StatelessWidget {
  PackageScreen({super.key});

  final ValueNotifier<bool> isIncoming = ValueNotifier(true);

  Future<List<Parcel>> fetchParcels({required bool incoming}) async {
    final token = await GetStorage().read('token');
    final endpoint = incoming
        ? '${APIConstants.baseUrl}/api/parcel/incomming'
        : '${APIConstants.baseUrl}/api/parcel/outgoing';

    final response = await http.get(
      Uri.parse(endpoint),
      headers: {
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        return (data['parcels'] as List)
            .map((item) => Parcel.fromJson(item))
            .toList();
      } else {
        throw Exception(data['message']);
      }
    } else {
      throw Exception('Failed to fetch parcels. Status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          'Parcels',
          style: TextStyle(fontSize: ESizes.fontSizeLg),
        ),
        backgroundColor: EColors.primary,
        foregroundColor: EColors.white,
        elevation: 0,
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: isIncoming,
        builder: (context, incoming, _) {
          return FutureBuilder<List<Parcel>>(
            future: fetchParcels(incoming: incoming),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text('No ${incoming ? 'incoming' : 'outgoing'} parcels found'),
                );
              } else {
                final parcels = snapshot.data!;
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
              
                        // const SizedBox(height: 16),
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
                                  Get.to(() =>  AddPackageScreen()),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => isIncoming.value = true,
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 16,horizontal:16),
                                decoration: BoxDecoration(
                                  color: incoming ? EColors.secondary : Colors.white,
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
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                     Icon(
          Iconsax.box,
          size: 40,
          color: incoming ? Colors.white : Colors.black,  // Change color here
        ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Incoming Parcel',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: incoming ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            GestureDetector(
                              onTap: () => isIncoming.value = false,
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 16,horizontal:16),
                                decoration: BoxDecoration(
                                  color: !incoming ? EColors.secondary : Colors.white,
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
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
          Iconsax.box_tick,
          size: 40,
          color: !incoming ? Colors.white : Colors.black,  // Change color here
        ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Outgoing Parcel',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: !incoming ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
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
          );
        },
      ),
    );
  }

  Widget buildParcelItem(Parcel parcel) {
    final DateTime parsedDate = DateTime.parse(parcel.createdat);
    final String formattedDate = DateFormat('d, MMM yyyy').format(parsedDate);
     String locationInfo = isIncoming.value ? parcel.branchCreated : parcel.destination;
    return GestureDetector(
      onTap: () => Get.to(() => PackageDetailsScreen(parcel: parcel, id:parcel.id,)),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(Iconsax.box, color: EColors.primary, size: 30),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    parcel.packageName,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'ParcelID: ${parcel.barcodeId}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Text(locationInfo),
          ],
        ),
      ),
    );
  }
}
