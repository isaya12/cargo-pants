import 'dart:ffi';

import 'package:cargo_pants/data/controller/parcelcontroller.dart';
import 'package:flutter/material.dart';
import 'package:cargo_pants/model/parcel_model.dart';
import 'package:cargo_pants/utils/constants/colors.dart';
import 'package:cargo_pants/utils/constants/sizes.dart';
import 'package:pdf/pdf.dart' as pw;
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:get/get.dart';

class PackageDetailsScreen extends StatelessWidget {
  final Parcel parcel;
  final int id;
  const PackageDetailsScreen(
      {super.key, required this.parcel, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          "Parcel Details",
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
              const Text(
                "PARCEL DETAILS",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              buildSummaryCard(parcel),
              const SizedBox(height: 16),
              buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build a summary card for parcel details
  Widget buildSummaryCard(Parcel parcel) {
    final details = {
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
      "Branch Created:": parcel.branchCreated,
    };

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
          );
        }).toList(),
      ),
    );
  }

  // Action buttons based on parcel status
  Widget buildActionButtons(BuildContext context) {
    final userBranch = 3; // Replace with user's branch logic

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
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Add space between buttons
            children: [
              if (parcel.branchCreated != userBranch) ...[
                buildButton(context, "Receive", Colors.green, () {
                  // Call showActionDialog with "receive" as the action type
                  showActionDialog(context, "receive");
                }),
                buildButton(context, "Print", Colors.blue, () async {
                  try {
                    int parcelId = id;
                    // final parcel =
                        // await ParcelController.printReceiptParcel(parcelId);
                    print(" parcel id: ${id}");
                    final pdf = await _generatePdf(parcel!);
                    print(" parcel details: ${parcel}");

                    await Printing.layoutPdf(
                      onLayout: (pw.PdfPageFormat format) async => pdf.save(),
                    );
                  } catch (e) {
                    print("Error: $e");
                  }
                }),
              ]
            ],
          ),
          const SizedBox(height: 8), // Add space between rows
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Add space between buttons
            children: [
              if (parcel.branchCreated != userBranch) ...[
                buildButton(context, "Update", Colors.orange, () {
                  // Implement update logic
                }),
                buildButton(context, "Delete", Colors.red, () {
                  // Call showActionDialog with "delete" as the action type
                  showActionDialog(context, "delete");
                }),
              ] else if (parcel.branchCreated == userBranch) ...[
                buildButton(context, "Receive", Colors.green, () {
                  // Call showActionDialog with "receive" as the action type
                  showActionDialog(context, "receive");
                }),
              ],
            ],
          ),
        ],
      ),
    );
  }

  // Helper function for creating buttons
  Widget buildButton(
    BuildContext context,
    String label,
    Color color,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 40,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Show dialog for receiving parcel
  void showActionDialog(BuildContext context, String actionType) {
    TextEditingController _descriptionController = TextEditingController();

    // Determine the message and action based on the actionType (receive or delete)
    String title = actionType == "receive" ? 'Receive Parcel' : 'Delete Parcel';
    String hintText = actionType == "receive"
        ? 'Please provide a description for receiving the parcel'
        : 'Please provide a reason for deleting the parcel';

    String buttonLabel = actionType == "receive" ? 'Receive' : 'Delete';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(hintText),
              SizedBox(height: 10),
              TextField(
                minLines: 2,
                maxLines: 2,
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: actionType == "receive"
                      ? 'Description....'
                      : 'Reason....',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                String description = _descriptionController.text;
                Navigator.of(context).pop();

                if (actionType == "receive") {
                  // Call receiveParcel() method and pass the description
                  await ParcelController().receiveParcel(parcel, description);
                } else if (actionType == "delete") {
                  // Call deleteParcel() method and pass the reason
                  await ParcelController().removeParcel(parcel, description);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: Text(
                buttonLabel,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  // PDF generation
  Future<pw.Document> _generatePdf(Parcel parcel) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: pw.PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Align(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  "Kagopoint",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              pw.SizedBox(height: 15),
              pw.Align(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  "TRUST FIRST",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "Cargo Receipt",
                  style: pw.TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "Booking ID: ${parcel.barcodeId}",
                  style: pw.TextStyle(fontSize: 16),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "Brand name: ${parcel.barcodeId}",
                  style: const pw.TextStyle(fontSize: 16),
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "Jouney route: ${parcel.barcodeId}",
                  style: const pw.TextStyle(fontSize: 16),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "shiping date: ${parcel.barcodeId}",
                  style: const pw.TextStyle(fontSize: 16),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "Alive date: ${parcel.barcodeId}",
                  style: const pw.TextStyle(fontSize: 16),
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "Paid amount: ${parcel.barcodeId}",
                  style: const pw.TextStyle(fontSize: 16),
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "Sender Details",
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "Sender Name: ${parcel.senderName}",
                  style: pw.TextStyle(fontSize: 16),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "Sender Phone: ${parcel.senderPhone}",
                  style: pw.TextStyle(fontSize: 16),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "Receiver Name: ${parcel.receiverName}",
                  style: pw.TextStyle(fontSize: 16),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "Receiver Phone: ${parcel.receiverPhone}",
                  style: pw.TextStyle(fontSize: 16),
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "Package Information",
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "Package Name: ${parcel.packageName}",
                  style: pw.TextStyle(fontSize: 16),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "Package Weight: ${parcel.description}",
                  style: pw.TextStyle(fontSize: 16),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "Package Size: ${parcel.packageSize}",
                  style: pw.TextStyle(fontSize: 16),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "Package Value: ${parcel.description}",
                  style: pw.TextStyle(fontSize: 12),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "Package Type: ${parcel.description}",
                  style: pw.TextStyle(fontSize: 12),
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "Agent Name : ${parcel.description}",
                  style: pw.TextStyle(fontSize: 12),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "Agent phone : ${parcel.description}",
                  style: pw.TextStyle(fontSize: 12),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "Bus Company : ${parcel.description}",
                  style: pw.TextStyle(fontSize: 12),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "Company phone : ${parcel.description}",
                  style: pw.TextStyle(fontSize: 12),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "CUSTOMER SERVICES : ${parcel.description}",
                  style: pw.TextStyle(fontSize: 12),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "${parcel.fromRegion} : ${parcel.description}",
                  style: pw.TextStyle(fontSize: 12),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "${parcel.toRegion} : ${parcel.description}",
                  style: pw.TextStyle(fontSize: 12),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "Asante kwa kuchagua TRUST FIRST",
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf;
  }
}
