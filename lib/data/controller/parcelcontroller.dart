import 'dart:convert';
import 'package:cargo_pants/model/parcel_model.dart';
import 'package:cargo_pants/model/parcel_type_model.dart';
import 'package:cargo_pants/screens/package/packagedetails/package_details.dart';
import 'package:cargo_pants/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cargo_pants/utils/constants/enums.dart';
import 'package:cargo_pants/model/parcel_branches_model.dart';
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
  final parcelValueController = TextEditingController();
  final parcelWeightController = TextEditingController();
  final transportationPriceController = TextEditingController();
  final specifyLocationController = TextEditingController();
  final descriptionController = TextEditingController();
  var packageSize = Rx<ParcelSizes?>(null); // Assuming this is your size enum
  var parcelTypes = RxList<ParcelType>([]); // Your parcel types list
  var parcelBranch = RxList<ParcelBranch>([]);

  // Method to update the selected parcel size
  void updateParcelSize(ParcelSizes? size) {
    packageSize.value = size;
  }

  // Reactive variables for destinations
  var destinations = [].obs;
  var selectedDestination = ''.obs;
  var parcelImage = ''.obs;
  var parcelPhone = ''.obs;
  RxList<ParcelType> parcelType = <ParcelType>[].obs;
  RxList<ParcelBranch> parcelBranchs = <ParcelBranch>[].obs;
  var isPTLoading = false.obs;
  var isBRLoading = false.obs;
  var dashboardData = {}.obs; // Use a reactive map to store dashboard data
  var isDataLoaded = false.obs; // To track loading state
  

  
  @override
  void onInit() {
    super.onInit();
    fetchPackageTypes();
    fetchDestination(); // Ensure this is called here
  }
  
   Future<void> updateParcel(Map<String, dynamic> parcelsData, int parcelId) async {
  final url = Uri.parse('${APIConstants.baseUrl}/api/parcel/update');
  final token = await GetStorage().read('token');

  try {
    print('Payload: ${jsonEncode(parcelsData)}');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token, // Include the 'Bearer' token
      },
      body: jsonEncode(parcelsData),
    );

    if (response.statusCode == 200) {
      print('Parcel update successfully: ${response.body}');

      Get.snackbar(
        'Success', 
        'Parcel updated successfully!',
        snackPosition: SnackPosition.BOTTOM,  // Position at the bottom
        backgroundColor: Colors.green,  // Set background color for success
        colorText: Colors.white,  // Text color
        duration: Duration(seconds: 2),  // Duration for the SnackBar
      );
      final updatedParcel = await fetchParcelById(parcelId);

      // Pass the updated parcel data to PackageDetailsScreen
      Get.offAll(() => PackageDetailsScreen(id: parcelId, parcel: updatedParcel));

    } else {
      throw Exception('Failed to update parcel: ${response.body}');
    }
  } catch (e) {
    print('Error updating parcel: $e');
    rethrow;
  }
}

// Method to fetch parcel by ID
Future<Parcel> fetchParcelById(int parcelId) async {
  final token = await GetStorage().read('token');
  final response = await http.get(
    Uri.parse('${APIConstants.baseUrl}/api/parcel/$parcelId'),
    headers: {
      "Content-Type": "application/json",
      "Authorization": token,
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    return Parcel.fromJson(data['parcel']);
  } else {
    throw Exception('Failed to fetch parcel data');
  }
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
          'Authorization': token, // Include the 'Bearer' token
        },
        body: jsonEncode(parcelData),
      );
      if (response.statusCode == 200) {
        Get.snackbar(
        'Success', 
        'Parcel created successfully!',
        snackPosition: SnackPosition.BOTTOM,  // Position at the bottom
        backgroundColor: Colors.green,  // Set background color for success
        colorText: Colors.white,  // Text color
        duration: Duration(seconds: 2),  // Duration for the SnackBar
      );
        // Get.offAll(() => NavigationMenu());
      } else {
        throw Exception('Failed to create parcel: ${response.body}');
      }
    } catch (e) {
      print('Error creating parcel: $e');
      rethrow;
    }
  }

//  fetch destination
  Future<void> fetchDestination() async {
    final token = await GetStorage().read('token');
    try {
      isPTLoading.value = true;
      final response = await http.get(
        Uri.parse('${APIConstants.baseUrl}/api/branch/other-branches'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": token,
        },
      );
      print(' body :${response.body}');
      print(' body :${response.statusCode}');

      if (response.statusCode == 200) {
        isBRLoading.value = true;
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Safely cast the tags list to List<dynamic>
        final List<dynamic> branches = jsonResponse['branches'];

        // Map the data to the parcelTypes list
        final List<ParcelBranch> pBranch = branches.map((e) {
          return ParcelBranch.fromJson(e);
        }).toList();

        parcelBranchs.addAll(pBranch);
      } else {
        throw Exception('Failed to load package types');
      }
    } catch (e) {
      print('Error fetching package types: $e');
      throw Exception('Error fetching package types: $e');
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

    print('status code: ${response.statusCode} - ${response.body}');

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
      // print(' body :${response.body}');
      // print(' body :${response.statusCode}');

      if (response.statusCode == 200) {
        isPTLoading.value = true;
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Safely cast the tags list to List<dynamic>
        final List<dynamic> tags = jsonResponse['tags'];

        // Map the data to the parcelTypes list
        final List<ParcelType> ptypes = tags.map((e) {
          return ParcelType.fromJson(e);
        }).toList();

        parcelType.addAll(ptypes);
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
      final response = await http.get(
        Uri.parse('${APIConstants.baseUrl}/api/dashbord-data'),
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


 Future<void> sendSms(String phoneList, String message) async {
     final apiUrl = '${APIConstants.baseUrl}/sms/multiple';
    final token = await GetStorage().read('token');
    
    final payload = {
  'phone_list': phoneList.split(','), // Convert comma-separated list to an array
  'message': message,
};

   try {
    // print('API URL: $apiUrl');
    print('Payload: ${jsonEncode(payload)}');
    print('Authorization Token: $token');

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": token,
      },
      body: jsonEncode(payload),
    );

    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      print('Message sent successfully');
    } else {
      print('Failed to send message: ${response.body}');
      throw Exception('Failed to send message');
    }
  } catch (error) {
    print('Error sending message: $error');
    throw error;
  }
  }
}
