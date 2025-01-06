import 'dart:convert';

import 'package:cargo_pants/data/controller/parcelcontroller.dart';
import 'package:cargo_pants/data/controller/usercontroller.dart';
import 'package:flutter/material.dart';
import 'package:cargo_pants/model/parcel_model.dart';
import 'package:cargo_pants/utils/constants/colors.dart';
import 'package:cargo_pants/utils/constants/sizes.dart';
import 'package:cargo_pants/screens/package/updateparcel/update_parcel.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
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

  final showDivider = {
    "Sender Name:": false,
    "Sender Phone:": false,
    "Receiver Name:": false,
    "Receiver Phone:": false,
    "Transporter Name:": false, // No divider below Transporter Name
    "Transporter Phone:": true,
    "Package Name:": false,
    "Package Size:": false,
    "Package Type:": false,
    "Package Value:": false,
    "Package Weight:": false,
    "Destination:": true,
    "Transportation Price:": false,
    "Specific Location:": false, // No divider below Specific Location
    "Description:": false, // No divider below Description
    "Branch Created:": true,
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
            // Add Divider if showDivider for this key is true
            if (showDivider[entry.key] == true)
              Divider(
                color: Colors.grey.shade300,
                thickness: 1,
              ),
          ],
        );
      }).toList(),
    ),
  );
}

  // Action buttons based on parcel status
  Widget buildActionButtons(BuildContext context) {
    final storage = GetStorage();
    final userBranch = storage.read<String>('branchId') ?? '';
    String value = userBranch;
    int? parsedValue = int.tryParse(value);
    //  print('userBranch: $userBranch, parsedValue: $parsedValue');
    //  print('userBranch: ${parcel.bid}');
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
              if (parcel.branchCreated != parsedValue) ...[
                buildButton(context, "Receive", Colors.green, () {
                  // Call showActionDialog with "receive" as the action type
                  showActionDialog(context, "receive");
                }),
                buildButton(context, "Print", Colors.blue, () async {
                  try {
                    int parcelId = id;
                    // final parcel =

                    Parcel myparcel =
                        await ParcelController.printReceiptParcel(parcelId);
                    print("parcel dets **** ${myparcel.id}");
                    final pdf = await _generatePdf(myparcel);
                    print(" parcel details: ${myparcel}");

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
              if (parcel.branchCreated != parsedValue) ...[
                // print('we ${parcel.bid}');
                buildButton(context, "Update", Colors.orange, () {
                  Get.to(() => UpdateParcelScreen(parcel:parcel));
                }),
                buildButton(context, "Delete", Colors.red, () {
                  // Call showActionDialog with "delete" as the action type
                  showActionDialog(context, "delete");
                }),
              ] else if (parcel.branchCreated == parsedValue) ...[
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
              const SizedBox(height: 10),
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
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                String description = _descriptionController.text.trim();
                Navigator.of(context).pop();

                if (description.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Please enter a valid ${actionType == "receive" ? "description" : "reason"}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
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
                style: const TextStyle(color: Colors.white),
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
    final barcodeImage = parcel.codedata.isNotEmpty
        ? pw.MemoryImage(
            base64Decode(
                parcel.codedata.split(',').last), // Extract Base64 data
          )
        : null;
    print(' barcode : $barcodeImage');
    print('Agent Phone: ${parcel.phone1}');
    final DateFormat dateFormat = DateFormat('d MMMM yyyy');

// Format the dates
    final DateTime shippingDate = DateTime.parse(parcel.shippingat);
    final DateTime arrivalDate = DateTime.parse(parcel.ariveat);

    final String formattedShippingDate = dateFormat.format(shippingDate);
    final String formattedArrivalDate = dateFormat.format(arrivalDate);

    pdf.addPage(
      pw.Page(
        pageFormat: pw.PdfPageFormat.a4,
        build: (context) {
          final UserController userController = Get.find();
          final String companyname =
              userController.storage.read('company_name') ?? 'Unknown';
          return pw.Align(
            alignment: pw.Alignment.center, // Center-align the entire content
            child: pw.Container(
              width: 350, // Adjust width for your desired layout
              child: pw.Column(
                crossAxisAlignment:
                    pw.CrossAxisAlignment.start, // Left-justify text
                children: [
                  pw.Align(
                    alignment: pw.Alignment.center,
                    child: pw.Text(
                      companyname,
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
                  pw.Text(
                    "Cargo Receipt",
                    style: const pw.TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    "Booking ID: ${parcel.barcodeId}",
                    style: const pw.TextStyle(fontSize: 16),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    "Brand name: ${parcel.barcodeId}",
                    style: const pw.TextStyle(fontSize: 16),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    "Journey route: ${parcel.fromRegion} - ${parcel.toRegion}",
                    style: const pw.TextStyle(fontSize: 16),
                  ),
                  pw.Text(
                    "Shipping date: ${formattedShippingDate}",
                    style: const pw.TextStyle(fontSize: 16),
                  ),
                  pw.Text(
                    "Arrival date: ${formattedArrivalDate}",
                    style: const pw.TextStyle(fontSize: 16),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    "Paid amount: ${parcel.barcodeId}",
                    style: const pw.TextStyle(fontSize: 16),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    "Sender Details",
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    "Sender Name: ${parcel.senderName}",
                    style: pw.TextStyle(fontSize: 16),
                  ),
                  pw.Text(
                    "Sender Phone: ${parcel.senderPhone}",
                    style: pw.TextStyle(fontSize: 16),
                  ),
                  pw.Text(
                    "Receiver Name: ${parcel.receiverName}",
                    style: pw.TextStyle(fontSize: 16),
                  ),
                  pw.Text(
                    "Receiver Phone: ${parcel.receiverPhone}",
                    style: pw.TextStyle(fontSize: 16),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    "Package Information",
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    "Package Name: ${parcel.packageName}",
                    style: pw.TextStyle(fontSize: 16),
                  ),
                  pw.Text(
                    "Package Weight: ${parcel.description}",
                    style: pw.TextStyle(fontSize: 16),
                  ),
                  pw.Text(
                    "Package Size: ${parcel.packageSize}",
                    style: pw.TextStyle(fontSize: 16),
                  ),
                  pw.Text(
                    "Package Value: ${parcel.description}",
                    style: pw.TextStyle(fontSize: 16),
                  ),
                  pw.Text(
                    "Package Type: ${parcel.description}",
                    style: pw.TextStyle(fontSize: 16),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    "Agent Name: ${parcel.fullName}",
                    style: pw.TextStyle(fontSize: 16),
                  ),
                  pw.Text(
                    "Agent Phone: ${parcel.phone1}",
                    style: pw.TextStyle(fontSize: 16),
                  ),
                  pw.Text(
                    "${parcel.fromRegion} : ${parcel.bbfromcontact}",
                    style: pw.TextStyle(fontSize: 16),
                  ),
                  pw.Text(
                    "${parcel.toRegion} :",
                    style: pw.TextStyle(fontSize: 16),
                  ),
                  pw.SizedBox(height: 10),
                  if (barcodeImage != null)
                    pw.Center(
                      child: pw.Image(
                        barcodeImage,
                        height: 100,
                        width: 200,
                      ),
                    ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    "Asante kwa kuchagua TRUST FIRST",
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

    return pdf;
  }
}
