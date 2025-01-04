import 'dart:convert';
import 'package:cargo_pants/screens/home/home.dart';
import 'package:cargo_pants/screens/login/login.dart';
import 'package:cargo_pants/screens/navigation/navigation_menu.dart';
import 'package:http/http.dart' as http;
import 'package:cargo_pants/utils/constants/api_constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserController extends GetxController {
  RxBool isLoading = false.obs;

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
          final branchImage = data['user']['branch_image'];// Assuming 'user' has 'id' key

          if (accessToken is String && userId != null) {
            // Save the accessToken and userId
            saveToken(accessToken);
            saveUserId(userId.toString());
            saveBranchId(data['user']['branch_id']
                .toString()); 
                saveBranchImage(branchImage);// Save userId as a string
            // print('User token: $accessToken');
            // print('User ID: $userId');
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

  
}
