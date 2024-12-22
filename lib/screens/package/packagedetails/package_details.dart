import 'package:cargo_pants/utils/constants/colors.dart';
import 'package:cargo_pants/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PackageDetailsScreen extends StatelessWidget {
  const PackageDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Package details",style: TextStyle(fontSize: ESizes.fontSizeLg),),
        foregroundColor: Colors.white,
        backgroundColor: EColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: ()=>Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Horizontal Stepper
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStep(
                    label: "Package Details",
                    isActive: true,
                  ),
                  _buildStepDivider(),
                  _buildStep(
                    label: "Review Summary",
                    isActive: true,
                  ),
                  _buildStepDivider(),
                  _buildStep(
                    label: "Confirmation",
                    isActive: false,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Review Summary Title
              const Text(
                "REVIEW SUMMARY",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),

              // Sender Details Card
              buildSummaryCard(
                title: "Sender Name ",
                details: {
                  "Sender Name ": " Bruce Wayne",
                  "Sender Phone :": " 656 555 678",
                  "Receiver name :": " Fred john",
                  "Receiver Phone :": " 656 555 678",
                  "Transporter name :": " isaya emmanuel",
                  "Transporter Phone :": " 656 555 678",
                },
              ),
              const SizedBox(height: 16),

              // Receiver Details Card
              buildSummaryCard(
                title: "Package Details",
                details: {
                  "Package name : ": "Sony phone",
                  "Package Size : ": "small",
                  "Package Type : ": "phone",
                  "Package value : ": "10000",
                  "Package Weight : ": "1 kg",
                },
              ),
              const SizedBox(height: 16),

              // Shipping Fee and Payment
              buildSummaryCard(
                title: "Shipping Details",
                details: {
                  "Destination : ": "Dar es salaam",
                  "Transportation Price : ": "Tsh 500",
                  "Specify location : ": "Mwananyamala",
                  "Description : ": "Mwananyamala sokoni ",
                  
                },
              ),
              const SizedBox(height: 30),

              // Confirm Order Button
              const SizedBox(height: 20), // Extra space at the bottom
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep({required String label, required bool isActive}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: isActive ? EColors.primary : Colors.grey[400],
          child: const Icon(
            Icons.check,
            size: 15,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.black : Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildStepDivider() {
    return Expanded(
      child: Container(
        height: 2,
        color: Colors.grey[400],
      ),
    );
  }

  // Function to build a summary card
  Widget buildSummaryCard(
      {required String title, required Map<String, String> details}) {
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
        children: details.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    entry.key,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    entry.value,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
