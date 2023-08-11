import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user_authentication/doctorProfile.dart';

class doctorProfileService extends GetxController {
  //RxList<dynamic> dataArray = <dynamic>[].obs;
  List<String> day = [];
  List<String> landmark = [];
  List<String> time = [];

  fetchAndStoreProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? access_token = await prefs.getString('access_Token');

    doctorProfile accountData;
    print(access_token);
    final url =
        Uri.parse('http://3.80.54.173:4005/api/v1/doctors/get-doctor-profile');

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $access_token",
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> parsedData = json.decode(response.body);
        final Map<String, List<Schedule>> availabilityMap = {};
        final List<dynamic> availabilityData =
            parsedData['data']['doctor_availability']['availability'];
        print(availabilityData);

        prefs.setString('DoctorAvailability', jsonEncode(availabilityData));
        //accountData = await doctorProfile.fromJson(jsonDecode(response.body));
        //var userData = await accountData.data;
        // for (final availabilityItem in availabilityData) {
        //   final Schedule schedule = Schedule.fromJson(availabilityItem);
        //   final String day = schedule.day;

        //   if (!availabilityMap.containsKey(day)) {
        //     availabilityMap[day] = [];
        //   }

        //   availabilityMap[day]!.add(schedule);
        // }
        // print(availabilityMap);
        // print(userData!.doctorAvailability!.availability![0].day);

        // prefs.setStringList('userData', userProfile);
        // prefs.setStringList('userDisease', userDisease);
        // prefs.setStringList('userAllergies', userAllergies);
        print('Data saved to local storage');
        print('User profile data saved to local storage');
      } else {
        print('API call failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching and storing API data: $error');
    }
  }
}

class Schedule {
  final String day;
  final List<TimeSlot> times;
  final int landmarkId;

  Schedule({
    required this.day,
    required this.times,
    required this.landmarkId,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    final List<dynamic> timesData = json['times'];
    final List<TimeSlot> times =
        timesData.map((data) => TimeSlot.fromJson(data)).toList();

    return Schedule(
      day: json['Day'],
      times: times,
      landmarkId: json['landmark_id'],
    );
  }
}

class TimeSlot {
  final String startTime;
  final String endTime;

  TimeSlot({required this.startTime, required this.endTime});

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }
}
