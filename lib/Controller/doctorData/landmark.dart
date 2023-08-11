import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class landmark extends GetxController {
  var location = [].obs;

  fetchLandmarkNames(int cityId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? access_token = await prefs.getString('access_Token');
    String apiUrl =
        "http://3.80.54.173:4005/api/v1/location/landmark?city_id=1";

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $access_token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        final jsonData = json.decode(response.body);
        final landmarks = jsonData['data'] as List<dynamic>;
        for (final item in landmarks) {
          location.add(item["name"]);
        }

        print(location);
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
