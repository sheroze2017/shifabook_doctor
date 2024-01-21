import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BookingList extends GetxController {
  var isloading = false.obs;
  var bookings = <Booking>[].obs;
  var isloadig2 = true.obs;
  Map<String, dynamic> bookingData = {};
  Map<String, dynamic>? pastBookingData = null;

  bookingconfirmation(int id) async {
    isloadig2.value = false;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? refreshtoken = prefs.getString('refresh_Token');
      String? access_token = prefs.getString('access_Token');

      var url = Uri.parse('http://3.80.54.173:4005/api/v1/bookings/$id');
      var response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $access_token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        int pat_id = await data['data']['booking_log_patient']['user_patient']
            ['patient_id'];
        print(pat_id);

        final body = {
          "booking_id": id,
          "is_accepted": true,
          "patient_id": pat_id
        };
        var url =
            Uri.parse('http://3.80.54.173:4005/api/v1/bookings/accept-booking');
        var response2 = await http.post(
          url,
          headers: {
            "Authorization": "Bearer $access_token",
            "Content-Type": "application/json",
          },
          body: jsonEncode(body),
        );

        if (response.statusCode == 200) {
          Get.snackbar('Status', 'Confirm Appointment');
        }
      } else {
        Get.snackbar('Error', 'Server Error');
      }
    } catch (error) {
      isloadig2.value = true;
      print(error);
    } finally {
      isloadig2.value = true;
    }
  }

  getBooking() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accesstoken = await prefs.getString('access_Token');

      String url = 'http://3.80.54.173:4005/api/v1/bookings/doctor-bookings';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $accesstoken",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // bookingData = data;
        // print(bookingData);
        final List<dynamic> statusData = data['data'];

        bookings.value = statusData
            .map((bookingData) => Booking(
                  id: bookingData['id'],
                  scheduledAt: bookingData['scheduled_at'],
                  isCompleted: bookingData['is_completed'],
                  isActive: bookingData['is_active'],
                  patientfullname: bookingData['booking_log_patient']
                      ['full_name'],
                  landmarkName: bookingData['landmark']['name'],
                  bookingStatus: bookingData['booking_status'],
                ))
            .toList();
      } else {
        // Handle error
      }
    } catch (error) {
      // Handle error
    } finally {
      isloading.value = false;
    }
  }

  getbookingdetails(int id) async {
    bookingData.clear();
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accesstoken = await prefs.getString('access_Token');

      String url = 'http://3.80.54.173:4005/api/v1/bookings/$id';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $accesstoken",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        bookingData = data;
        print(bookingData);
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle error
      print('Error: $error');
    } finally {
      //isLoading3.value = false;
    }
  }

  Future<bool> changeStatusToComplete(
      int patientId, int bookingId, bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? access_token = prefs.getString('access_Token');

    final body = {
      "patient_id": patientId,
      "booking_id": bookingId,
      "is_completed": status
    };
    try {
      var url = Uri.parse(
          'http://3.80.54.173:4005/api/v1/bookings/complete-bookings');
      var response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $access_token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print(response.body);
        print('status change');
        Get.snackbar('Message', 'Meeting Complete',
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.green);
        return true;
      } else {
        var data = jsonDecode(response.body);
        print('rrrr');
        Get.snackbar('Message', data['message'],
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.red);
        print(response.body);
        print(response.statusCode);
        return false;
      }
    } catch (error) {
      print(error);

      return false;
    } finally {}
  }

  getPastBooking(int patid) async {
    try {
      //  pastBookingData!.clear();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accesstoken = await prefs.getString('access_Token');

      String url =
          'http://3.80.54.173:4005/api/v1/bookings/past-bookings?patient_id=$patid';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $accesstoken",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        final data = json.decode(response.body);
        pastBookingData = data;
      } else {
        final data = json.decode(response.body);
        // Handle error
        print('oh');
        pastBookingData = {};
      }
    } catch (error) {
      print('catch');
      pastBookingData = {};
      print(error);
      // Handle error
    } finally {
      isloading.value = false;
    }
  }
}

class Booking {
  final int id;
  final String scheduledAt;
  final bool isCompleted;
  final bool isActive;
  final String patientfullname;
  final String landmarkName;
  final String bookingStatus;

  Booking({
    required this.id,
    required this.scheduledAt,
    required this.isCompleted,
    required this.isActive,
    required this.patientfullname,
    required this.landmarkName,
    required this.bookingStatus,
  });
}
