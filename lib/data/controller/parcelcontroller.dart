import 'dart:convert';
import 'package:cargo_pants/model/parcel_model.dart';
import 'package:cargo_pants/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:flutter/material.dart';


class ParcelController extends GetxController {

  final senderNameController = TextEditingController();
  final senderPhoneController = TextEditingController();
  final receiverNameController = TextEditingController();
  final receiverPhoneController = TextEditingController();
  final transporterNameController = TextEditingController();
  final transporterPhoneController = TextEditingController();
  final packageNameController = TextEditingController();
  final packageSizeController = TextEditingController();
  final packageTypeController = TextEditingController();
  final parcelValueController = TextEditingController();
  final parcelWeightController = TextEditingController();
  final destinationController = TextEditingController();
  final transportationPriceController = TextEditingController();
  final specifyLocationController = TextEditingController();
  final descriptionController = TextEditingController();

  static Future<void> createParcel(Map<String, dynamic> parcelData) async {
    final url = Uri.parse('${APIConstants.baseUrl}/api/parcel/create');
    try {
      print('Payload: ${jsonEncode(parcelData)}');
    
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjcsInVzZXJfZGF0YSI6eyJpZCI6Nywicm9sZSI6MiwiY3JlYXRlciI6NCwiY29tcGFueV9uYW1lIjoiTXV2dXppc2hhIiwicm9sZV9uYW1lIjoiQWRtaW4iLCJwaG9uZTEiOiIwNjE1NDk4MDI2IiwidXNlcm5hbWUiOiIwNjE1NDk4MDI2IiwiZnVsbmFtZSI6IklzYXlhIEJ1c2luZXNzICIsImJyYW5jaF9pZCI6MywiY29tcGFueV9pZCI6Mn0sImlhdCI6MTczNTQwMzE4MiwiZXhwIjoxNzY4MDYyMzgyLCJzdWIiOiJhY2Nlc3NBcGkifQ.NcwONl7Tav2nlh8col4PDSh9lnDQShODM5HC1q3ukLc',
        },
        body: jsonEncode(parcelData),
      );
      if (response.statusCode == 200) {
        print('Parcel created successfully: ${response.body}');
      } else {
        throw Exception('Failed to create parcel: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Parcel>> fetchIncomingParcels() async {
    final response =
        await http.get(Uri.parse('${APIConstants.baseUrl}/api/parcel/incomming'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data['success']) {
        return (data['parcels'] as List)
            .map((item) => Parcel.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load parcels');
      }
    } else {
      throw Exception('Failed to fetch data from API');
    }
  }
}
