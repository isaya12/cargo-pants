import 'dart:convert';
import 'package:cargo_pants/screens/home/home.dart';
import 'package:cargo_pants/screens/login/login.dart';
import 'package:cargo_pants/screens/navigation/navigation_menu.dart';
import 'package:cargo_pants/utils/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'package:cargo_pants/utils/constants/api_constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class UserController extends GetxController {
  RxBool isLoading = false.obs;
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Boolean to handle loading state
  var isPSLoading = false.obs;

  final GetStorage storage = GetStorage(); // GetStorage instance

  Future<void> login(String phone, String password) async {
    isLoading.value = true;

    final url = Uri.parse('${APIConstants.baseUrl}/api/auth/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'phone': phone, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == true && data['token'] != null) {
          // Extract the accessToken and userId
          final accessToken = data['token']['accessToken'];
          final userId = data['user']['id'];
          final branchImage = data['user']['branch_image'];
          final fullName = data['user']['fulname'];
          final branchname = data['user']['branch_name'];
          final phone = data['user']['phone'];
          final avatar = data['user']['avator'];
          final branchregion = data['user']['branch_region'];
          final companynames = data['user']['company_name'];

          if (accessToken is String && userId != null) {
            // Save the accessToken and userId
            saveToken(accessToken);
            saveUserId(userId.toString());
            saveBranchId(data['user']['branch_id'].toString());
            saveBranchImage(branchImage); // Save userId as a string
            saveUserFullName(fullName);
            saveUsername(branchname);
            savePhone(phone);
            saveAvatar(avatar);
            companyname(companynames);
            savebrachRegion(branchregion);
            Get.offAll(() => const NavigationMenu());
          } else {
            Get.snackbar(
              'Login Failed',
              'Invalid token or user data',
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        } else {
          String message = data['message']?.toString() ?? 'Login failed';
          Get.snackbar(
            'Login Failed',
            message,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'Server error: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        'Something went wrong: $error',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Save the token in GetStorage
  void saveToken(String token) {
    if (token.isNotEmpty) {
      storage.write('token', token);
      print('Token saved: $token'); // Debug log for verification
    } else {
      print('Error: Attempted to save an empty token.');
    }
  }

  void saveBranchId(String branchId) {
    storage.write('branchId', branchId);
  }

  void saveBranchImage(String branchImage) {
    if (branchImage.isNotEmpty) {
      storage.write('branchImage', branchImage);
      print('Branch image saved: $branchImage');
    } else {
      print('Error: Branch image is empty.');
    }
  }

  void saveUserFullName(String fullName) {
    storage.write('fullName', fullName);
  }

  void saveUsername(String branchname) {
    storage.write('branch_name', branchname);
  }

  void savePhone(String phone) {
    storage.write('phone', phone);
  }

  void saveAvatar(String avatar) {
    storage.write('avatar', avatar);
  }
  void companyname(String companyname) {
    storage.write('company_name', companyname);
  }
  void savebrachRegion(String savebrachRegion) {
    storage.write('branch_region', savebrachRegion);
  }

  // Save the user ID in GetStorage
  void saveUserId(String userId) {
    storage.write('userId', userId);
  }

  // Retrieve the token from GetStorage
  String? getToken() {
    final token = storage.read<String>('token');
    if (token != null && token.isNotEmpty) {
      return token;
    }
    return null;
  }

  // Retrieve the user ID from GetStorage
  String? getUserId() {
    return storage.read('userId');
  }

  // Clear the token and user ID from GetStorage
  void clearToken() {
    storage.remove('userId'); // Clear userId
    storage.erase(); // Clear all stored data
  }

  Future<void> logout() async {
    final url = Uri.parse('${APIConstants.baseUrl}/api/auth/logout');
    try {
      final token = await GetStorage().read('token');
      if (token == null) {
        Get.snackbar(
          'Error',
          'No token found. Please log in again.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );
      print('body:${response.body}');
      if (response.statusCode == 200) {
        clearToken();
        Get.offAll(() => LoginScreen());
        Get.snackbar(
          'Success',
          'Logged out successfully.',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to log out: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        'Something went wrong: $error',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Method to handle password update API call
  Future<void> updatePassword() async {
    // Input validation
    if (currentPasswordController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'All fields are required',
        backgroundColor: EColors.error,
        colorText: EColors.white,
      );
      return;
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'New password and confirmation do not match',
        backgroundColor: EColors.error,
        colorText: EColors.white,
      );
      return;
    }

    try {
      isPSLoading(true); // Set loading to true

      final token = await GetStorage().read('token');
      if (token == null) {
        Get.snackbar(
          'Error',
          'No token found. Please log in again.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      final url = Uri.parse('${APIConstants.baseUrl}/api/change-password');

      // Create the payload
      final payload = {
        'current_password': currentPasswordController.text,
        'new_password': newPasswordController.text,
        'confirm_password': confirmPasswordController.text,
      };

      // Print the payload to debug
      // print('Payload: ${json.encode(payload)}');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: json.encode(payload),
      );

      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          Get.snackbar(
            'Success',
            'Password changed successfully',
            backgroundColor: EColors.success,
            colorText: EColors.white,
          );

          // Clear fields after successful update
          currentPasswordController.clear();
          newPasswordController.clear();
          confirmPasswordController.clear();
        } else {
          Get.snackbar(
            'Error',
            'Failed to update password: ${data['message']}',
            backgroundColor: EColors.error,
            colorText: EColors.white,
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'Failed to update password: ${response.statusCode}',
          backgroundColor: EColors.error,
          colorText: EColors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        backgroundColor: EColors.error,
        colorText: EColors.white,
      );
    } finally {
      isPSLoading(false); // Set loading to false
    }
  }
}
