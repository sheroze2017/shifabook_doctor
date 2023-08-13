import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class availbility extends GetxController {
  final AvailabilityData = {};

  updateAvailibility(
      int id, List days, String starttime, String endtime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> availability =
        await jsonDecode(prefs.getString('DoctorAvailability')!);

    for (var day in days) {
      availability.add({
        "Day": day,
        "times": [
          {"start_time": starttime + '0', "end_time": endtime + '0'}
        ],
        "landmark_id": id
      });
    }

    print(availability);
    String? access_token = await prefs.getString('access_Token');
    final body = {"availability": availability};
    String url = 'http://3.80.54.173:4005/api/v1/doctors/set-availability';
    final response = await http.post(Uri.parse(url),
        headers: {
          "Authorization": "Bearer $access_token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      prefs.setString('DoctorAvailability', jsonEncode(availability));

      Get.snackbar('Message', 'Updated');
    } else {
      Get.snackbar('Message', 'Error adding time');
    }
  }

  updateAvailibility2(availability) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? access_token = await prefs.getString('access_Token');
    final body = {"availability": availability};
    String url = 'http://3.80.54.173:4005/api/v1/doctors/set-availability';
    final response = await http.post(Uri.parse(url),
        headers: {
          "Authorization": "Bearer $access_token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      prefs.setString('DoctorAvailability', jsonEncode(availability));
      Get.snackbar('Message', 'Remove Time');
    }
  }
}

class SwitchController extends GetxController {
  var isSwitchedOn = false.obs;
  var isLeaveOn = false.obs;

  updateonlinebusy() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? access_token = prefs.getString('access_Token');
      final body = {"is_busy": isSwitchedOn.value, "on_leave": isLeaveOn.value};
      print(access_token);
      String url = 'http://3.80.54.173:4005/api/v1/doctors/update-availability';
      final response = await http.put(Uri.parse(url),
          headers: {
            "Authorization": "Bearer $access_token",
            "Content-Type": "application/json",
          },
          body: jsonEncode(body));

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Map<String, dynamic> fullDoctorData =
            await jsonDecode(prefs.getString('DoctorFullData')!);
        fullDoctorData['doctor_availability']['is_busy'] = isSwitchedOn.value;
        fullDoctorData['doctor_availability']['on_leave'] = isLeaveOn.value;
        await prefs.setString('DoctorFullData', jsonEncode(fullDoctorData));
        print(response.body);
        // Get.snackbar('Message', 'Update Done');

        // Successful response
      } else {
        Get.snackbar('Error', 'Server Error');
      }
    } catch (error) {
      print(error);
    } finally {
      //  isloading.value = false;
    }
  }

  toggleSwitch() async {
    isSwitchedOn.toggle();
  }

  toggleSwitch2() async {
    isLeaveOn.toggle();
  }
}
