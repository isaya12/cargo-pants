import 'dart:convert';
import 'package:cargo_pants/model/parcel_model.dart';
import 'package:cargo_pants/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ParcelController extends GetxController {
  static Future<void> createParcel(Map<String, dynamic> parcelData) async {
    final url = Uri.parse('${APIConstants.baseUrl}/api/parcel/create');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(parcelData),
      );

      print('response body: ${response.body}');
      if (response.statusCode == 200) {
        print('success');
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
