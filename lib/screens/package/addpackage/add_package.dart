import 'package:cargo_pants/utils/constants/colors.dart';
import 'package:cargo_pants/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddPackageScreen extends StatefulWidget {
  const AddPackageScreen({super.key});

  @override
  State<AddPackageScreen> createState() => _AddPackageScreenState();
}

class _AddPackageScreenState extends State<AddPackageScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController senderNameController = TextEditingController();
  final TextEditingController senderPhoneController = TextEditingController();
  final TextEditingController receiverNameController = TextEditingController();
  final TextEditingController receiverPhoneController = TextEditingController();
  final TextEditingController transporterNameController = TextEditingController();
  final TextEditingController transporterPhoneController = TextEditingController();
  final TextEditingController packageNameController = TextEditingController();
  final TextEditingController packageSizeController = TextEditingController();
  final TextEditingController packageTypeController = TextEditingController();
  final TextEditingController parcelValueController = TextEditingController();
  final TextEditingController parcelWeightController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController transportationPriceController = TextEditingController();
  final TextEditingController specifyLocationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final parcelData = {
        "sender_name": senderNameController.text,
        "sender_phone": senderPhoneController.text,
        "receiver_name": receiverNameController.text,
        "receiver_phone": receiverPhoneController.text,
        "transporter_name": transporterNameController.text,
        "transporter_phone": transporterPhoneController.text,
        "package_name": packageNameController.text,
        "package_size": packageSizeController.text,
        "package_type": packageTypeController.text,
        "parcel_value": double.tryParse(parcelValueController.text) ?? 0.0,
        "parcel_weight": double.tryParse(parcelWeightController.text) ?? 0.0,
        "destination": destinationController.text,
        "transportation_price": double.tryParse(transportationPriceController.text) ?? 0.0,
        "specify_location": specifyLocationController.text,
        "description": descriptionController.text,
      };

      // Call an API or a method to save the data
      // Example: ApiService.createParcel(parcelData);

      // Get.snackbar("Success", "Parcel created successfully!");
    }
  }

  @override
  void dispose() {
    // Dispose controllers when not needed
    senderNameController.dispose();
    senderPhoneController.dispose();
    receiverNameController.dispose();
    receiverPhoneController.dispose();
    transporterNameController.dispose();
    transporterPhoneController.dispose();
    packageNameController.dispose();
    packageSizeController.dispose();
    packageTypeController.dispose();
    parcelValueController.dispose();
    parcelWeightController.dispose();
    destinationController.dispose();
    transportationPriceController.dispose();
    specifyLocationController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
        backgroundColor: EColors.primary,
        foregroundColor: EColors.white,
        title: const Text(
          'Create Parcel',
          style: TextStyle(fontSize: ESizes.fontSizeMd),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Let's Create a new parcel",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: EColors.secondary,
                  ),
                ),
                const SizedBox(height: 30),
                _buildRow(
                  _buildTextField(
                    controller: senderNameController,
                    labelText: 'Sender name',
                    prefixIcon: Iconsax.user,
                  ),
                  _buildTextField(
                    controller: senderPhoneController,
                    labelText: 'Sender phone',
                    prefixIcon: Iconsax.call,
                  ),
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: receiverNameController,
                  labelText: 'Receiver name',
                  prefixIcon: Iconsax.user,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: receiverPhoneController,
                  labelText: 'Receiver phone',
                  prefixIcon: Iconsax.call,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: transporterNameController,
                  labelText: 'Transporter name',
                  prefixIcon: Iconsax.truck,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: transporterPhoneController,
                  labelText: 'Transporter phone',
                  prefixIcon: Iconsax.call,
                ),
                const SizedBox(height: 16),
                _buildRow(
                  _buildTextField(
                    controller: packageNameController,
                    labelText: 'Package name',
                    prefixIcon: Iconsax.box,
                  ),
                  _buildTextField(
                    controller: packageSizeController,
                    labelText: 'Package Size',
                    prefixIcon: Iconsax.ruler,
                  ),
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: packageTypeController,
                  labelText: 'Package Type',
                  prefixIcon: Iconsax.category,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: parcelValueController,
                  labelText: 'Parcel value',
                  prefixIcon: Iconsax.dollar_circle,
                ),
                const SizedBox(height: 16),
                _buildRow(
                  _buildTextField(
                    controller: parcelWeightController,
                    labelText: 'Parcel Weight',
                    prefixIcon: Iconsax.weight,
                  ),
                  _buildTextField(
                    controller: destinationController,
                    labelText: 'Destination',
                    prefixIcon: Iconsax.location,
                  ),
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: transportationPriceController,
                  labelText: 'Transportation Price',
                  prefixIcon: Iconsax.money,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: specifyLocationController,
                  labelText: 'Specify location',
                  prefixIcon: Iconsax.location,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: descriptionController,
                  labelText: 'Description',
                  prefixIcon: Iconsax.document_text,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: EColors.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _submitForm,
                    child: const Text(
                      'Submit parcel',
                      style: TextStyle(
                          fontSize: ESizes.fontSizeSm, color: EColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData prefixIcon,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $labelText';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildRow(Widget left, Widget right) {
    return Row(
      children: [
        Expanded(child: left),
        const SizedBox(width: 16),
        Expanded(child: right),
      ],
    );
  }
}
