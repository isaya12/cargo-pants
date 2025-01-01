import 'package:cargo_pants/model/parcel_model.dart';
import 'package:cargo_pants/utils/constants/colors.dart';
import 'package:cargo_pants/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class PackageDetailsScreen extends StatelessWidget {
  final Parcel parcel;

  const PackageDetailsScreen({super.key, required this.parcel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          "Parcel details",
          style: TextStyle(fontSize: ESizes.fontSizeLg),
        ),
        foregroundColor: Colors.white,
        backgroundColor: EColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Review Summary Title
              const Text(
                "PARCELS DETAILS",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),

              // Sender Details Card
              buildSummaryCard(
                details: {
                  "Sender Name:": parcel.senderName,
                  "Sender Phone:": parcel.senderPhone,
                  "Receiver Name:": parcel.receiverName,
                  "Receiver Phone:": parcel.receiverPhone,
                  "Transporter Name:": parcel.transporterName,
                  "Transporter Phone:": parcel.transporterPhone,
                  "Package Name:": parcel.packageName,
                  "Package Size:": parcel.packageSize,
                  "Package Type:": parcel.packageType,
                  "Package Value:": parcel.parcelValue,
                  "Package Weight:": "${parcel.parcelWeight} kg",
                  "Destination:": parcel.destination,
                  "Transportation Price:": "Tsh ${parcel.transportationPrice}",
                  "Specific Location:": parcel.specifyLocation,
                  "Description:": parcel.description,
                  "Branch created:": parcel.branchCreated,
                },
                showDivider: {
                 "Sender Name:": false,
                  "Sender Phone:": false,
                  "Receiver Name:": false,
                  "Receiver Phone:": false,
                  "Transporter Name:": false,
                  "Transporter Phone:": true,
                  "Package Name:": false,
                  "Package Size:": false,
                  "Package Type:": false,
                  "Package Value:": false,
                  "Package Weight:": false,
                  "Destination:": true,
                  "Transportation Price:": false,
                  "Specific Location:": false,
                  "Description:": false,
                  "Branch created:": true,
               },
              ),
              const SizedBox(height: 16),

              // Action Buttons Container
              Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.shade200,
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ],
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      ElevatedButton(
        onPressed: () {
          AwesomeDialog(
            context: context,
            // dialogType:DialogType.success,
            animType:AnimType.topSlide,
            showCloseIcon:true,
            title:'OK if you receive Parcel',
            desc: "please enter message",
                  body: Column(
        children: [
          // Text Input Field
          TextField(
            decoration: InputDecoration(
              labelText: 'Receive description',
              hintText: ' message...',
              border: OutlineInputBorder(),
            ),
            maxLines: 2, // Allow multiline input
            keyboardType: TextInputType.text,
          ),
        ],
      ),
            btnCancelOnPress: () {},
            btnOkOnPress: () {},
            btnCancelColor: Colors.red,
            btnOkColor: Colors.green,
          ).show();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green, // Updated property
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 24,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 4,
        ),
        child: const Text(
          "Receive",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    ],
  ),
),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }


  // Function to build a summary card
  Widget buildSummaryCard({required Map<String, String> details, required Map<String, bool> showDivider}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade200,
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        ...details.entries.map((entry) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        entry.key,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          entry.value,
                          style: const TextStyle(fontSize: 14),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Check if we need to display the divider for the current entry
              if (showDivider[entry.key] == true) const Divider(),
            ],
          );
        }).toList(),
      ],
    ),
  );
}

}
