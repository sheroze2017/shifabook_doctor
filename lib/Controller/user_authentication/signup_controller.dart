import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shifabook_doctor/model/user_authentication/signup_model.dart';
import 'package:shifabook_doctor/views/Authentication/otp_screen.dart';

class SignupController extends GetxController {
  var isloading = false.obs;
  Future<void> signup(String fullName, String password, String mobile) async {
    isloading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String url = 'http://3.80.54.173:4005/api/v1/users/signup';

    Map<String, dynamic> requestBody = {
      'full_name': fullName,
      'password': password,
      'mobile': mobile,
      'type': 2,
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 201) {
        // User Created
        final responseData = await json.decode(response.body);
        final signupResponse = await SignupResponse.fromJson(responseData);
        await prefs.setString(
            'fullname', signupResponse.data.fullName.toString());
        await prefs.setString('mobile', signupResponse.data.mobile.toString());
        await prefs.setString('userId', signupResponse.data.id.toString());
        Get.to(otpmobile(),
            transition: Transition.native,
            duration: Duration(milliseconds: 300),
            arguments: [fullName, mobile]);
        // TODO: Handle successful signup
      } else if (response.statusCode == 409) {
        // User already exists
        final responseData = json.decode(response.body);
        print(responseData);
        Get.snackbar('Error', 'User Already Exist');
        // TODO: Handle user already exists
      } else {
        // Error occurred
        print('Error: ${response.statusCode}');
        // TODO: Handle error
      }
    } catch (error) {
      // Exception occurred
      print('Exception: $error');
      // TODO: Handle exception
    } finally {
      isloading.value = false;
    }
  }
}
