import 'package:cargo_pants/utils/constants/colors.dart';
import 'package:cargo_pants/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddPackageScreen extends StatelessWidget {
  const AddPackageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: ()=>Get.back(),
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
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      labelText: 'Sender name',
                      prefixIcon: Iconsax.user,
                    ),
                  ),
                  const SizedBox(
                    width: ESizes.spaceBtwItems,
                  ),
                  Expanded(
                    child: _buildTextField(
                      labelText: 'Sender phone',
                      prefixIcon: Iconsax.call,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField(
                labelText: 'Receiver name',
                prefixIcon: Iconsax.user,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                labelText: 'Receiver phone',
                prefixIcon: Iconsax.call,
              ),
              const SizedBox(
                height: ESizes.spaceBtwItems,
              ),
              _buildTextField(
                labelText: 'Transporter name',
                prefixIcon: Iconsax.truck,
              ),
              const SizedBox(
                height: ESizes.spaceBtwItems,
              ),
              _buildTextField(
                labelText: 'Transporter phone',
                prefixIcon: Iconsax.call,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      labelText: 'Package name',
                      prefixIcon: Iconsax.box,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      labelText: 'Package Size',
                      prefixIcon: Iconsax.ruler,
                      obscureText: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField(
                labelText: ' Package Type',
                prefixIcon: Iconsax.category,
                obscureText: true,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                labelText: '  Parcel value',
                prefixIcon: Iconsax.dollar_circle,
                obscureText: true,
              ),
              const SizedBox(height: 16),
              Row(children: [
                Expanded(
                  child: _buildTextField(
                  labelText: 'Parcel Weight  ',
                  prefixIcon: Iconsax.weight,
                  obscureText: true,
                                ),
                ),
               const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  labelText: 'Destination',
                  prefixIcon: Iconsax.location,
                  obscureText: true,
                ),
              ),
              ],),
              
             
              const SizedBox(height: 16),
              _buildTextField(
                labelText: 'Transportation Price ',
                prefixIcon: Iconsax.money,
                obscureText: true,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                labelText: 'Specify location',
                prefixIcon: Iconsax.location,
                obscureText: true,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                labelText: 'Description ',
                prefixIcon: Iconsax.document_text,
                obscureText: true,
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
                  onPressed: () {},
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
    );
  }

  Widget _buildTextField({
    required String labelText,
    required IconData prefixIcon,
    bool obscureText = false,
  }) {
    return TextField(
      obscureText: obscureText,
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
}
