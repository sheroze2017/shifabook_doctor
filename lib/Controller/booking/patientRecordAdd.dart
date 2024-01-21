import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shifabook_doctor/Controller/booking/createbooking.dart';
import 'package:shifabook_doctor/views/home.dart';

class ImageController extends GetxController {
  Rx<File?> selectedImage = Rx<File?>(null);
  // final getbooking = Get.put(BookingList());

  String imagelink = '';
  var loader = false.obs;
  var loader2 = false.obs;
  void pickImage(ImageSource source) async {
    imagelink = '';
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? access_token = prefs.getString('access_Token');
      final url = Uri.parse('http://3.80.54.173:4005/api/v1/media/');

      try {
        loader.value = true;
        var request = http.MultipartRequest('POST', url);
        request.headers["Authorization"] = "Bearer $access_token";
        // Read the file as bytes
        List<int> imageBytes = await selectedImage.value!.readAsBytes();
        // Add the image file as a part of the request
        var imagePart = http.MultipartFile.fromBytes('image', imageBytes,
            filename: 'image.jpg', contentType: MediaType('image', 'jpeg'));
        request.files.add(imagePart);
        // Send the request
        var response = await request.send();

        if (response.statusCode == 200) {
          loader.value = false;
          final responseBody = await response.stream.bytesToString();
          print('Image uploaded successfully. Response: $responseBody');
          final datalink = await jsonDecode(responseBody);
          imagelink = await datalink['data']['file'];
          if (imagelink != '') {
            print(imagelink);
            Get.snackbar('Message', 'Image Uploaded',
                snackPosition: SnackPosition.BOTTOM,
                colorText: Colors.white,
                backgroundColor: Colors.green);
          }
        } else {
          Get.snackbar('Error', 'Image Not Loaded',
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.red);
          print('Failed to hit the API. Status code: ${response.statusCode}');
          print(await response.stream.bytesToString());
        }
      } catch (e) {
        // Handle error
        print('Error hitting the API: $e');
      } finally {
        loader.value = false;
      }
    } else {
      print('No data yet');
    }
  }

  addRemark(String remark, int patientId, int bookingId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? access_token = prefs.getString('access_Token');

    final body = {
      "remarks": remark.toString(),
      "booking_id": bookingId,
      "patient_id": patientId,
      "media": [
        {"prescirptipon": imagelink}
      ]
    };
    try {
      loader2.value = true;
      var url =
          Uri.parse('http://3.80.54.173:4005/api/v1/bookings/doctor-remarks');
      var response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $access_token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        loader.value = false;
        Get.snackbar('Message', 'Remarks Added Successfully',
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.green);
        Get.offAll(HomePage());
      } else {
        Get.snackbar('Error', 'Error Adding Remarks',
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.red);
      }
    } catch (error) {
      loader2.value = false;
      print(error);
    } finally {
      loader2.value = false;
    }
  }
}
