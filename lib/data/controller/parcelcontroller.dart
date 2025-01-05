import 'dart:convert';
import 'package:cargo_pants/model/parcel_model.dart';
import 'package:cargo_pants/model/parcel_type_model.dart';
import 'package:cargo_pants/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cargo_pants/utils/constants/enums.dart';
import 'package:flutter/material.dart';

class ParcelController extends GetxController {
  Future<List<String>>? packageTypesFuture;

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
  final packageSize = Rx<ParcelSizes?>(null);
  // Method to update the selected parcel size
  void updateParcelSize(ParcelSizes? size) {
    packageSize.value = size;
  }

  // Reactive variables for destinations
  var destinations = [].obs;
  var selectedDestination = ''.obs;
  var parcelImage = ''.obs;
  var parcelPhone = ''.obs;
  RxList<ParcelType> parcelTypes = <ParcelType>[].obs;
  var isPTLoading = false.obs;
  var dashboardData = {}.obs; // Use a reactive map to store dashboard data
  var isDataLoaded = false.obs; // To track loading state

  @override
  void onInit() {
    super.onInit();
    fetchPackageTypes(); // Ensure this is called here
  }

  static Future<void> createParcel(Map<String, dynamic> parcelData) async {
    final url = Uri.parse('${APIConstants.baseUrl}/api/parcel/create');
    final token = await GetStorage().read('token');
    try {
      print('Payload: ${jsonEncode(parcelData)}');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
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

//  fetch destination
  Future<void> fetchDestinations() async {
    try {
      var response = await http
          .get(Uri.parse('${APIConstants.baseUrl}/api/branch/other-branches'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        destinations.value = data['branches']; // Assuming 'branches' is the key
      } else {
        Get.snackbar('Error', 'Failed to fetch destinations');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

//  receive parcel
  Future<void> receiveParcel(Parcel parcel, String description) async {
    try {
      final token = await GetStorage().read('token');
      var payload = {
        "id": parcel.id,
        "barcode_id": parcel.barcodeId,
        "closed_description": description,
      };
      print("Payload: ${jsonEncode(payload)}");
      // Make the POST request
      var response = await http.post(
        Uri.parse('${APIConstants.baseUrl}/api/parcel/receive'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": token,
        },
        body: jsonEncode(payload),
      );
      print("Response body: ${response.body}");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        // Success message for parcel receiving
        Get.snackbar('Success', 'Parcel received successfully.');
      } else {
        // Error message for failed parcel receiving
        Get.snackbar('Error', 'Failed to receive parcel. Please try again.');
      }
    } catch (e) {
      // Error message for unexpected errors
      Get.snackbar('Error', 'An unexpected error occurred: ${e.toString()}');
    }
  }

  Future<void> removeParcel(Parcel parcel, String description) async {
    try {
      final token = await GetStorage().read('token');
      var payload = {
        "id": parcel.id,
        "barcode_id": parcel.barcodeId,
        "description": description,
      };
      print("Payload: ${jsonEncode(payload)}");
      // Make the POST request
      var response = await http.post(
        Uri.parse('${APIConstants.baseUrl}/api/parcel/delete'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": token,
        },
        body: jsonEncode(payload),
      );
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        // Success message for parcel receiving
        Get.snackbar('Success', 'Parcel received successfully.');
      } else {
        // Error message for failed parcel receiving
        Get.snackbar('Error', 'Failed to receive parcel. Please try again.');
      }
    } catch (e) {
      // Error message for unexpected errors
      Get.snackbar('Error', 'An unexpected error occurred: ${e.toString()}');
    }
  }

  Future<List<Parcel>> fetchIncomingParcels() async {
    final response = await http
        .get(Uri.parse('${APIConstants.baseUrl}/api/parcel/incomming'));

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

  static Future<Parcel> printReceiptParcel(int parcelId) async {
    final token = await GetStorage().read('token');
    final endpoint = '${APIConstants.baseUrl}/api/parcel/print-receipt';

    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        "Content-Type": "application/json",
        'Authorization': token,
      },
      body: jsonEncode({
        "id": parcelId,
      }),
    );

    // print('status code: ${response.statusCode} - ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['success']) {
        if (data.containsKey('parcel') && data['parcel'] != null) {
          return Parcel.fromJson(data['parcel']);
        } else {
          throw Exception('Parcel data is missing in the response.');
        }
      } else {
        throw Exception(data['message']);
      }
    } else {
      throw Exception(
          'Failed to fetch print parcels info. Status: ${response.statusCode}');
    }
  }

  Future<void> fetchPackageTypes() async {
    final token = await GetStorage().read('token');
    try {
      isPTLoading.value = true;
      final response = await http.get(
        Uri.parse('${APIConstants.baseUrl}/api/tag/all-tags'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": token,
        },
      );
      print('${APIConstants.baseUrl}/api/tag/all-tags');

      if (response.statusCode == 200) {
        isPTLoading.value = true;
        // Parse the JSON response
        // final List<dynamic> data = json.decode(response.body);
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        // Map the data to the parcelTypes list
        final ptypes = jsonResponse['tags'].map((e) {
          return ParcelType.fromJson(e);
        }).toList();

        parcelTypes.addAll(ptypes);
      } else {
        throw Exception('Failed to load package types');
      }
    } catch (e) {
      print('Error fetching package types: $e');
      throw Exception('Error fetching package types: $e');
    }
  }


  Future<void> fetchDashboardData() async {
    try {
      isDataLoaded.value = true;
       final token = await GetStorage().read('token');
      final response = await http.get(Uri.parse('${APIConstants.baseUrl}/api/dashbord-data'),
      headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": token,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          dashboardData.value = data['dataz']; // Assign the 'dataz' field
        } else {
          throw Exception('Failed to load dashboard data');
        }
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (e) {
      print('Error fetching dashboard data: $e');
    } finally {
      isDataLoaded.value = false;
    }
  }

}
