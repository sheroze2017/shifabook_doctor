import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shifabook_doctor/views/Authentication/form_screen.dart';
import 'package:shifabook_doctor/views/home.dart';

import '../../model/user_authentication/login_model.dart';

class LoginController extends GetxController {
  var isloading = false.obs;
  Future<void> login(String mobile, String password) async {
    isloading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var url = Uri.parse('http://3.80.54.173:4005/api/v1/users/login');
      var response = await http.post(
        url,
        body: {
          'mobile': mobile,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // Successful login
        var responseData = await response.body;
        var loginResponse = await UserModel.fromJson(jsonDecode(responseData));

        // Access the data from the loginResponse object
        await prefs.setString(
            'fullname', loginResponse.data!.user!.fullName.toString());
        await prefs.setString(
            'userId', loginResponse.data!.user!.id.toString());
        await prefs.setString(
            'email', loginResponse.data!.user!.email.toString());
        await prefs.setString(
            'mobile', loginResponse.data!.user!.mobile.toString());
        await prefs.setString(
            'isActive', loginResponse.data!.user!.isActive.toString());
        await prefs.setString(
            'isVerify', loginResponse.data!.user!.isVerify.toString());
        await prefs.setString(
            'createdAt', loginResponse.data!.user!.createdAt.toString());
        await prefs.setString(
            'updatedAt', loginResponse.data!.user!.updatedAt.toString());
        await prefs.setString(
            'roleName', loginResponse.data!.user!.role!.name.toString());
        await prefs.setString(
            'roleId', loginResponse.data!.user!.role!.id.toString());
        await prefs.setString(
            'access_Token', loginResponse.data!.accessToken.toString());
        await prefs.setString(
            'refresh_Token', loginResponse.data!.refreshToken.toString());

        print('Access Token: ${loginResponse.data!.accessToken}');
        print('User Full Name: ${loginResponse.data!.user!.fullName}');
        // ... Access other properties as needed
        if (loginResponse.data!.user!.isProfileCreated == false) {
          Get.to(() => formScreen());
        } else {
          Get.to(() => HomePage());
        }
      } else if (response.statusCode == 404) {
        // Invalid credentials
        Get.snackbar('Error', 'Invaild Credentials');
        //print('Invalid credentials');
      } else {
        // Error occurred during login
        print('Login failed');
      }
    } catch (error) {
      // Exception occurred during the API request
      print('An error occurred: $error');
    } finally {
      isloading.value = false;
    }
  }
}
