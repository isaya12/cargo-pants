import 'package:cargo_pants/utils/constants/colors.dart';
import 'package:cargo_pants/utils/constants/sizes.dart';
import 'package:cargo_pants/data/controller/parcelcontroller.dart';
import 'package:cargo_pants/utils/constants/enums.dart';
import 'package:cargo_pants/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddPackageScreen extends StatelessWidget {
  AddPackageScreen({super.key});

  final ParcelController controller = Get.put(ParcelController());
  final _formKey = GlobalKey<FormState>();

  // List of dropdown items
  final List<ParcelSizes> parcelSizes = ParcelSizes.values;

  // ValueNotifier to manage the selected value
  final ValueNotifier<ParcelSizes?> _selectedParcelSize =
      ValueNotifier<ParcelSizes?>(null);

  var selectedPackageType = RxString('');
  var selectedBranch = RxString('');

  @override
  Widget build(BuildContext context) {
    ParcelController parcelController = Get.put(ParcelController());
    var packages = parcelController.parcelTypes.value;
    var parcelBr = parcelController.parcelBranch.value;
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
                
                  _buildTextField(
                    controller: controller.senderNameController,
                    labelText: 'Sender name',
                    prefixIcon: Iconsax.user,
                    validator: (value) =>
                        EValidator.validateEmptyText('Sender name', value),
                  ),
                  const SizedBox(height: 30),
                  _buildTextField(
                    controller: controller.senderPhoneController,
                    labelText: 'Sender phone',
                    prefixIcon: Iconsax.call,
                    validator: (value) => EValidator.validatePhoneNumber(value),
                  ),
                
                const SizedBox(height: 16),
                _buildTextField(
                  controller: controller.receiverNameController,
                  labelText: 'Receiver name',
                  prefixIcon: Iconsax.user,
                  validator: (value) =>
                      EValidator.validateEmptyText('Receiver name', value),
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: controller.receiverPhoneController,
                  labelText: 'Receiver phone',
                  prefixIcon: Iconsax.call,
                  validator: (value) => EValidator.validatePhoneNumber(value),
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: controller.transporterNameController,
                  labelText: 'Transporter name (option)',
                  prefixIcon: Iconsax.truck,
                  validator: (value) =>
                      EValidator.validatetransporterName( value),
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: controller.transporterPhoneController,
                  labelText: 'Transporter phone (option)',
                  prefixIcon: Iconsax.call,
                  validator: (value) => EValidator.validatetransporterPhone(value),
                ),
                const SizedBox(height: 16),
                
                  _buildTextField(
                    controller: controller.packageNameController,
                    labelText: 'Package name',
                    prefixIcon: Iconsax.box,
                    validator: (value) =>
                        EValidator.validateEmptyText('Package name', value),
                  ),
                  const SizedBox(height: 30),
                  _buildTextField(
                    controller: controller.parcelValueController,
                    labelText: 'Parcel value',
                    prefixIcon: Iconsax.dollar_circle,
                    validator: (value) =>
                        EValidator.validateEmptyText('Parcel value', value),
                  ),
              
                const SizedBox(height: 16),
                Obx(() {
                  return DropdownButtonFormField<String>(
                    value: selectedPackageType.value.isNotEmpty
                        ? selectedPackageType.value
                        : null,
                    items: parcelController.parcelType.map((type) {
                      return DropdownMenuItem<String>(
                        value: type.id.toString(),
                        child: Text(type.name),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      selectedPackageType.value = newValue!;
                    },
                    decoration: InputDecoration(
                      labelText: 'Package Type',
                      prefixIcon: const Icon(Iconsax.box),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) =>
                        EValidator.validateEmptyText('Package Type', value),
                  );
                }),
                const SizedBox(height: 16),
                Obx(() {
                  return DropdownButtonFormField<String>(
                    value: selectedBranch.value.isNotEmpty
                        ? selectedBranch.value
                        : null,
                    items: parcelController.parcelBranchs.map((branches) {
                      return DropdownMenuItem<String>(
                        value: branches.id.toString(),
                        child: Text(branches.name),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      selectedBranch.value = newValue!;
                    },
                    decoration: InputDecoration(
                      labelText: 'Destination',
                      prefixIcon: const Icon(Iconsax.location),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) =>
                        EValidator.validateEmptyText('Destination', value),
                  );
                }),
                const SizedBox(height: 16),
                Obx(() {
                  return DropdownButtonFormField<ParcelSizes>(
                    value: controller.packageSize.value,
                    items: parcelSizes.map((size) {
                      return DropdownMenuItem<ParcelSizes>(
                        value: size,
                        child: Text(size.toString().split('.').last),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      controller.updateParcelSize(newValue);
                    },
                    decoration: InputDecoration(
                      labelText: 'Parcel Size',
                      prefixIcon: const Icon(Iconsax.box),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) => EValidator.validateEmptyText(
                        'Parcel Size', value.toString()),
                  );
                }),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: controller.parcelWeightController,
                  labelText: 'Parcel Weight',
                  prefixIcon: Iconsax.weight,
                  validator: (value) =>
                      EValidator.validateEmptyText('Parcel Weight', value),
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: controller.transportationPriceController,
                  labelText: 'Transportation Price',
                  prefixIcon: Iconsax.money,
                  validator: (value) => EValidator.validateEmptyText(
                      'Transportation Price', value),
                ),
                const SizedBox(height: 16),
               _buildTextField(
  controller: controller.specifyLocationController,
  labelText: 'Specify location (optional)',
  prefixIcon: Iconsax.location,
  validator: (value) => EValidator.validateSpecfyLocation(value),
),

                const SizedBox(height: 16),
                _buildTextField(
                  controller: controller.descriptionController,
                  labelText: 'Description (optional)',
                  prefixIcon: Iconsax.document_text,
                  validator: (value) =>
                      EValidator.validateDescription(value),
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> parcelData = {
                          "sender_name": controller.senderNameController.text,
                          "sender_phone": controller.senderPhoneController.text,
                          "receiver_name":
                              controller.receiverNameController.text,
                          "receiver_phone":
                              controller.receiverPhoneController.text,
                          "transporter_name":
                              controller.transporterNameController.text,
                          "transpoerter_phone":
                              controller.transporterPhoneController.text,
                          "name": controller.packageNameController.text,
                          "package_size": controller.packageSize.value != null
                              ? controller.packageSize.value
                                  .toString()
                                  .split('.')
                                  .last // Convert enum to string
                              : null, // Ensure this is correctly passed
                          "package_value": controller.parcelValueController.text,
                          "package_weight":
                              controller.parcelWeightController.text,
                          "price":
                              controller.transportationPriceController.text,
                          "specific_location":
                              controller.specifyLocationController.text,
                          "description": controller.descriptionController.text,
                          "package_tag": selectedPackageType
                              .value, // Use the selected package type directly
                          "branch_to": selectedBranch
                              .value, // Use the selected branch directly
                        };

                        ParcelController.createParcel(parcelData)
                            .then((value) =>print('success'))
                            .catchError((error) =>print('error'));
                      }
                    },
                    child: const Text('Create Parcel',style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build a row of two widgets
  Widget _buildRow(Widget firstChild, Widget secondChild) {
    return Row(
      children: [
        Expanded(child: firstChild),
        const SizedBox(width: 16),
        Expanded(child: secondChild),
      ],
    );
  }

  // Helper method to build a text field
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData prefixIcon,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    bool isOptional = false,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
     validator: isOptional ? null : validator,
     keyboardType: keyboardType,
    );
  }
}
