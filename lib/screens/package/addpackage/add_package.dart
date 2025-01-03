import 'package:cargo_pants/utils/constants/colors.dart';
import 'package:cargo_pants/utils/constants/sizes.dart';
import 'package:cargo_pants/data/controller/parcelcontroller.dart';
import 'package:cargo_pants/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddPackageScreen extends StatelessWidget {
  AddPackageScreen({super.key});

  ParcelController controller = Get.put(ParcelController());
  final _formKey = GlobalKey<FormState>();
  // List of dropdown items
  final List<ParcelSizes> _parcelSizes = ParcelSizes.values;

  // ValueNotifier to manage the selected value
  final ValueNotifier<ParcelSizes?> _selectedParcelSize =
      ValueNotifier<ParcelSizes?>(null);

      

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
                    controller: controller.senderNameController,
                    labelText: 'Sender name',
                    prefixIcon: Iconsax.user,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Sender name cannot be empty';
                      }
                      return null;
                    },
                  ),
                  _buildTextField(
                    controller: controller.senderPhoneController,
                    labelText: 'Sender phone',
                    prefixIcon: Iconsax.call,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Sender name cannot be empty';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: controller.receiverNameController,
                  labelText: 'Receiver name',
                  prefixIcon: Iconsax.user,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Sender name cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: controller.receiverPhoneController,
                  labelText: 'Receiver phone',
                  prefixIcon: Iconsax.call,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Sender name cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: controller.transporterNameController,
                  labelText: 'Transporter name',
                  prefixIcon: Iconsax.truck,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Sender name cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: controller.transporterPhoneController,
                  labelText: 'Transporter phone',
                  prefixIcon: Iconsax.call,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Sender name cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildRow(
                  _buildTextField(
                    controller: controller.packageNameController,
                    labelText: 'Package name',
                    prefixIcon: Iconsax.box,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Sender name cannot be empty';
                      }
                      return null;
                    },
                  ),
                  _buildTextField(
                    controller: controller.packageNameController,
                    labelText: 'Package name',
                    prefixIcon: Iconsax.box,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Sender name cannot be empty';
                      }
                      return null;
                    },
                  ),
//                  ValueListenableBuilder<ParcelSizes?>(
//   // valueListenable: controller.packageSize, // Use the controller's property
//   builder: (context, value, _) {
//     return DropdownButtonFormField<ParcelSizes>(
//       decoration: InputDecoration(
//         labelText: 'Parcel Size',
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//       value: value,
//       items: _parcelSizes.map((ParcelSizes size) {
//         return DropdownMenuItem<ParcelSizes>(
//           value: size,
//           child: Text(size.toString().split('.').last), // Display enum value
//         );
//       }).toList(),
//       onChanged: (ParcelSizes? newValue) {
//         controller.updateParcelSize(newValue); // Update the controller's property
//       },
//     );
//   },
// ),
),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: controller.packageTypeController,
                  labelText: 'Package Type',
                  prefixIcon: Iconsax.category,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Sender name cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: controller.parcelValueController,
                  labelText: 'Parcel value',
                  prefixIcon: Iconsax.dollar_circle,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Sender name cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildRow(
                  _buildTextField(
                    controller: controller.parcelWeightController,
                    labelText: 'Parcel Weight',
                    prefixIcon: Iconsax.weight,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Sender name cannot be empty';
                      }
                      return null;
                    },
                  ),
                  _buildTextField(
                    controller: controller.destinationController,
                    labelText: 'Destination',
                    prefixIcon: Iconsax.location,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Sender name cannot be empty';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: controller.transportationPriceController,
                  labelText: 'Transportation Price',
                  prefixIcon: Iconsax.money,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Sender name cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: controller.specifyLocationController,
                  labelText: 'Specify location',
                  prefixIcon: Iconsax.location,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Sender name cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: controller.descriptionController,
                  labelText: 'Description',
                  prefixIcon: Iconsax.document_text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Sender name cannot be empty';
                    }
                    return null;
                  },
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
                          "senderName": controller.senderNameController.text,
                          "senderPhone": controller.senderPhoneController.text,
                          "receiverName":
                              controller.receiverNameController.text,
                          "receiverPhone":
                              controller.receiverPhoneController.text,
                          "packageName": controller.packageNameController.text,
                          "packageSize": controller.packageSize.value
                              ?.toString(), // Include the selected parcel size
                          "parcelValue": controller.parcelValueController.text,
                          "destination": controller.destinationController.text,
                        };
                        ParcelController.createParcel(parcelData)
                            .then((value) => Get.snackbar(
                                  'Success',
                                  'Parcel created successfully!',
                                  snackPosition: SnackPosition.BOTTOM,
                                ))
                            .catchError((error) => Get.snackbar(
                                  'Error',
                                  error.toString(),
                                  snackPosition: SnackPosition.BOTTOM,
                                ));
                      }
                    },
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
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator ??
          (value) {
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
