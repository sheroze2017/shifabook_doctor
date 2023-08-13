import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'doctorInfo.dart';

class UpdatePofile extends GetxController {
  updateDoctorProfile(
      String fullname,
      String age,
      String exp,
      List<dynamic> qualification,
      List<dynamic> selectedexpertise,
      List<dynamic> selectedexpertiseid,
      List<dynamic> selectedaffiliation,
      int id) async {
    print(fullname);
    print(age);
    print(exp);
    print(qualification);
    print(selectedexpertise);
    print(selectedexpertiseid);
    print(selectedaffiliation);
    print(id);

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
        "full_name": fullname.toString(),
        "age": int.parse(age),
        "years_of_experience": int.parse(exp),
        "qualification": qualification,
        "affilation": selectedaffiliation,
        "expertise": expertise,
        "city_id": id
      };
      print(access_token);
      String url =
          'http://3.80.54.173:4005/api/v1/doctors/update-doctor-profile';
      final response = await http.put(Uri.parse(url),
          headers: {
            "Authorization": "Bearer $access_token",
            "Content-Type": "application/json",
          },
          body: jsonEncode(body));

      if (response.statusCode == 200) {
        Get.snackbar('Message', 'Profile Updated');
        await doctorProfileService().fetchAndStoreProfile();

        // Successful response
      } else {
        Get.snackbar('Error', 'Invalid Data');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error creating doctor: $error');
      Get.snackbar('Error', 'Invalid Credentials');

      // Handle any error messages or UI updates here
    } finally {
      //  isloading.value = false;
    }
  }
}
