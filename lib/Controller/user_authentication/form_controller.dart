import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shifabook_doctor/views/home.dart';

class DoctorController extends GetxController {
  var isloading = false.obs;
  Future<void> createDoctor(
      String selectedGender,
      String nameController,
      List<String> selectedqualification,
      List<String> selectedexpertise,
      List<int> selectedexpertiseid,
      List<String> selectedaffiliation,
      String expController,
      String onsitefeeController,
      String onlinefeeController,
      int selectedCityId,
      String ageController,
      String dobController) async {
    isloading.value = true;

    List<Map<String, dynamic>> expertise = [];
    try {
      for (int i = 0; i < selectedexpertise.length; i++) {
        expertise.add({
          "id": selectedexpertiseid[i],
          "name": selectedexpertise[i].toString()
        });
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? access_token = await prefs.getString('access_Token');
      final body = {
        "license_number": nameController.toString(),
        "qualification": selectedqualification,
        "expertise": expertise,
        "affilation": selectedaffiliation,
        "years_of_experience": int.parse(expController),
        "onsite_consultation_fee": int.parse(onsitefeeController),
        "online_consultation_fee": int.parse(onlinefeeController),
        "city_id": selectedCityId,
        "age": int.parse(ageController),
        "gender": selectedGender,
        "dob": dobController
      };
      print(access_token);
      String url =
          'http://3.80.54.173:4005/api/v1/doctors/create-doctor-profile';
      final response = await http.post(Uri.parse(url),
          headers: {
            "Authorization": "Bearer $access_token",
            "Content-Type": "application/json",
          },
          body: jsonEncode(body));

      if (response.statusCode == 200) {
        // Successful response
        print('Doctor created successfully');
        await prefs.setString('Gender', selectedGender);
        await prefs.setString('liscense', nameController);
        await prefs.setStringList('qualification', selectedqualification);
        await prefs.setStringList('expertise', selectedexpertise);
        await prefs.setStringList(
            'expertiseid', selectedexpertiseid.cast<String>());
        await prefs.setStringList('affiliation', selectedaffiliation);
        await prefs.setString('experience', expController);
        await prefs.setString('onsitefee', onsitefeeController);
        await prefs.setString('onlinefee', onlinefeeController);
        await prefs.setInt('CityId', selectedCityId);
        await prefs.setString('age', ageController);
        await prefs.setString('dob', dobController);
        Future.delayed(Duration(seconds: 3));

        final response2nd = await http.post(Uri.parse(url),
            headers: {
              "Authorization": "Bearer $access_token",
              "Content-Type": "application/json",
            },
            body: jsonEncode(body));
        if (response2nd.statusCode == 409) {
          Get.to(HomePage());
        }
      } else {
        print('Failed to create doctor: ${response.body}');
        Get.snackbar('Error', 'Invalid Credentials');
        // Handle any error messages or UI updates here
      }
    } catch (error) {
      // Handle network or other errors
      print('Error creating doctor: $error');
      Get.snackbar('Error', 'Invalid Credentials');

      // Handle any error messages or UI updates here
    } finally {
      isloading.value = false;
    }
  }
}
